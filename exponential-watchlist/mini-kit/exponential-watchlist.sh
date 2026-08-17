#!/bin/bash
# LifeOS exponential-watchlist agent — runs on the Mac Mini, daily.
# Re-scores watchlist/bench names that reported earnings yesterday/today,
# runs a light discovery scan for new exponential-thesis candidates,
# rebuilds dashboard.html, commits + pushes the library.
# Telegram ping ONLY when something changed (agent outputs NO_CHANGES otherwise).
#
# Unlike company-health this runs the model EVERY day (the discovery scan is
# the point); the earnings check just feeds the prompt extra context.
# Set LIBRARY_DIR to the Mini's clone of the lifeos-library repo before install.
set -u
LIBRARY_DIR="${LIBRARY_DIR:-$HOME/LifeOS-agents/library}"
WL_DIR="$LIBRARY_DIR/exponential-watchlist"
PROMPT="$WL_DIR/mini-kit/prompt-exponential-watchlist.md"
TELEGRAM_ENV="${TELEGRAM_ENV:-$HOME/LifeOS-agents/.secrets/telegram.env}"
LOG="$HOME/LifeOS-agents/logs/exponential-watchlist.log"
mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1
echo "=== exponential-watchlist run $(date -u +%FT%TZ) ==="

cd "$LIBRARY_DIR" || { echo "library dir missing"; exit 1; }
git pull --rebase --quiet || echo "WARN: git pull failed (continuing on local copy)"

TODAY=$(date +%F)
YESTERDAY=$(date -v-1d +%F 2>/dev/null || date -d yesterday +%F)

# tickers (all sections) whose next_earnings ISO date has PASSED and not been
# re-scored — self-healing after downtime; oldest first, max 4 per run.
TICKERS=$(python3 - "$WL_DIR/register.json" "$YESTERDAY" "$TODAY" <<'EOF'
import json, sys, re
reg = json.load(open(sys.argv[1])); today = sys.argv[3]
hits = []
for c in reg["companies"] + reg.get("bench", []) + reg.get("distribution", []) + reg.get("distribution_bench", []):
    m = re.match(r"(\d{4}-\d{2}-\d{2})", str(c.get("next_earnings","")))
    if m and m.group(1) <= today:
        hits.append((m.group(1), c["ticker"]))
hits.sort()
print(",".join(t for _, t in hits[:4]))
EOF
)
echo "reported yesterday/today: ${TICKERS:-none}"

cd "$WL_DIR"
SUMMARY=$(claude -p "$(cat "$PROMPT")

Tickers that reported yesterday/today (re-score these first): ${TICKERS:-none}
Today's date: $TODAY
Working directory: $WL_DIR
Holdings exclusion list: $LIBRARY_DIR/holdings-tickers.json" \
  --model sonnet \
  --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Bash(python3 *)" \
  2>>"$LOG")

echo "$SUMMARY"

# rebuild dashboard defensively (agent should have done it; idempotent)
python3 "$WL_DIR/mini-kit/build_dashboard.py" "$WL_DIR" || echo "WARN: dashboard rebuild failed"

cd "$LIBRARY_DIR"
git add exponential-watchlist/
git commit -m "exponential-watchlist: daily run ($TODAY)" --quiet && \
  { git push --quiet || echo "WARN: git push failed — library not syncing (check PAT)"; } || \
  echo "nothing to commit"

# Telegram ping only on changes (agent outputs NO_CHANGES on a quiet day)
if [ "$SUMMARY" != "NO_CHANGES" ] && [ -n "$SUMMARY" ] && ! echo "$SUMMARY" | grep -q "^NO_CHANGES$"; then
  if [ -f "$TELEGRAM_ENV" ]; then
    # shellcheck disable=SC1090
    source "$TELEGRAM_ENV"
    if [ -n "${TELEGRAM_BOT_TOKEN:-}" ] && [ -n "${TELEGRAM_CHAT_ID:-}" ]; then
      MSG="📡 Exponential watchlist:
${SUMMARY:0:3500}"
      curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TELEGRAM_CHAT_ID}" --data-urlencode text="$MSG" >/dev/null \
        || echo "WARN: telegram send failed"
    fi
  fi
else
  echo "no changes — staying silent on Telegram"
fi
echo "=== done ==="
