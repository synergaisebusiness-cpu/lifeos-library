#!/bin/bash
# LifeOS company-health re-scorer — runs on the Mac Mini, weekday mornings.
# Checks whether any holding reported earnings yesterday or today (per
# register.json next_earnings ISO dates); if so, runs the re-score agent,
# rebuilds dashboard.html, commits + pushes the library, pings Telegram.
# No holdings reported -> exits without a model call.
#
# Set LIBRARY_DIR to the Mini's clone of the lifeos-library repo before install.
set -u
LIBRARY_DIR="${LIBRARY_DIR:-$HOME/LifeOS-agents/library}"
CH_DIR="$LIBRARY_DIR/company-health"
PROMPT="$CH_DIR/mini-kit/prompt-company-health.md"
TELEGRAM_ENV="${TELEGRAM_ENV:-$HOME/LifeOS-agents/.secrets/telegram.env}"
LOG="$HOME/LifeOS-agents/logs/company-health.log"
mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1
echo "=== company-health run $(date -u +%FT%TZ) ==="

cd "$LIBRARY_DIR" || { echo "library dir missing"; exit 1; }
git pull --rebase --quiet || echo "WARN: git pull failed (continuing on local copy)"

TODAY=$(date +%F)
YESTERDAY=$(date -v-1d +%F 2>/dev/null || date -d yesterday +%F)

# tickers whose next_earnings ISO date has PASSED (reported but not yet re-scored).
# Self-healing after downtime: a missed day no longer goes stale forever — the
# agent updates next_earnings on re-score, so processed names drop out.
# Oldest first, max 4 per run to bound a catch-up backlog.
TICKERS=$(python3 - "$CH_DIR/register.json" "$YESTERDAY" "$TODAY" <<'EOF'
import json, sys, re
reg = json.load(open(sys.argv[1])); today = sys.argv[3]
hits = []
for c in reg["companies"]:
    m = re.match(r"(\d{4}-\d{2}-\d{2})", str(c.get("next_earnings","")))
    if m and m.group(1) <= today:
        hits.append((m.group(1), c["ticker"]))
hits.sort()
print(",".join(t for _, t in hits[:4]))
EOF
)

if [ -z "$TICKERS" ]; then
  echo "no holdings reported ($YESTERDAY/$TODAY) — exiting without model call"
  exit 0
fi
echo "re-scoring: $TICKERS"

cd "$CH_DIR"
SUMMARY=$(claude -p "$(cat "$PROMPT")

Tickers that reported: $TICKERS
Today's date: $TODAY
Working directory: $CH_DIR" \
  --model sonnet \
  --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Bash(python3 *)" \
  2>>"$LOG")

echo "$SUMMARY"

# rebuild dashboard defensively (agent should have done it; idempotent)
python3 "$CH_DIR/mini-kit/build_dashboard.py" "$CH_DIR" || echo "WARN: dashboard rebuild failed"

cd "$LIBRARY_DIR"
git add company-health/
git commit -m "company-health: re-score $TICKERS ($TODAY)" --quiet && \
  { git push --quiet || echo "WARN: git push failed — library not syncing (check PAT)"; } || \
  echo "nothing to commit"

# Telegram ping (figure-free summary; skip silently if creds absent)
if [ -f "$TELEGRAM_ENV" ]; then
  # shellcheck disable=SC1090
  source "$TELEGRAM_ENV"
  if [ -n "${TELEGRAM_BOT_TOKEN:-}" ] && [ -n "${TELEGRAM_CHAT_ID:-}" ]; then
    MSG="🩺 Company health — re-scored ${TICKERS}:
${SUMMARY:0:3500}"
    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
      -d chat_id="${TELEGRAM_CHAT_ID}" --data-urlencode text="$MSG" >/dev/null \
      || echo "WARN: telegram send failed"
  fi
fi
echo "=== done ==="
