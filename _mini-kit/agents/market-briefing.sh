#!/bin/bash
# LifeOS market-briefing agent — MAC MINI EDITION (runs from ~/LifeOS-agents).
# Same behaviour as the MacBook original, plus git sync of the library
# (pull before the run, commit+push after). Scoped by the figure-free
# library/holdings-tickers.json — this machine holds NO personal figures.
#
# Usage:
#   market-briefing.sh                         # full briefing (default)
#   market-briefing.sh --mode=earnings-ping --tickers=NVDA,AMD
set -u
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

LIFEOS="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$LIFEOS/logs/market-briefing.log"
PROMPT_FILE="$LIFEOS/agents/prompts/market-briefing.md"
SECRETS="$LIFEOS/.secrets/telegram.env"
RENDER="$LIFEOS/agents/lib/render_briefing.py"
LIB="$LIFEOS/library"
mkdir -p "$LIFEOS/logs" "$LIB/briefings"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] market-briefing: $*" | tee -a "$LOG" >&2; }

git_pull() { git -C "$LIB" pull --rebase --autostash --quiet 2>>"$LOG" || log "WARN: git pull failed (continuing with local copy)"; }
git_push() {
  git -C "$LIB" add -A 2>>"$LOG"
  if ! git -C "$LIB" diff --cached --quiet 2>/dev/null; then
    git -C "$LIB" commit -m "market-briefing: $DATE ($MODE)" --quiet 2>>"$LOG" || log "WARN: git commit failed"
    git -C "$LIB" push --quiet 2>>"$LOG" || log "WARN: git push failed (library will sync on next successful push)"
  fi
}

# --- args ---
MODE="full"; TICKERS=""
for a in "$@"; do
  case "$a" in
    --mode=*)    MODE="${a#*=}";;
    --tickers=*) TICKERS="${a#*=}";;
  esac
done

DATE="$(date +%F)"
BRIEFING_MD="$LIB/briefings/briefing-$DATE.md"
BRIEFING_HTML="$LIB/briefings/briefing-$DATE.html"
TG_SUMMARY="$LIFEOS/logs/tg-summary-$DATE.txt"
EARNINGS_JSON="$LIB/earnings-upcoming.json"
: > "$TG_SUMMARY"

log "=== run started (mode=$MODE${TICKERS:+, tickers=$TICKERS}) ==="
git_pull

# --- claude ---
CLAUDE_BIN="$(command -v claude || true)"
[ -z "$CLAUDE_BIN" ] && CLAUDE_BIN="$HOME/.local/bin/claude"
if [ ! -x "$CLAUDE_BIN" ]; then log "ERROR: claude CLI not found"; exit 1; fi

RUNTIME="

---
# RUNTIME INPUTS
TODAY: $DATE
MODE: $MODE
TICKERS: ${TICKERS:-none}
BRIEFING_MD (write full briefing here, full mode only): $BRIEFING_MD
TG_SUMMARY (write short Telegram summary here, always): $TG_SUMMARY
EARNINGS_JSON (write upcoming-earnings JSON here, full mode only): $EARNINGS_JSON
Holdings universe (tickers only): $LIB/holdings-tickers.json
Library root: $LIB
Remember: NO personal portfolio figures. Cite sources. Append library entries, never overwrite.
"

cd "$LIFEOS" || exit 1
log "invoking claude (web research; this can take a few minutes)..."
if "$CLAUDE_BIN" -p "$(cat "$PROMPT_FILE")$RUNTIME" \
    --model sonnet \
    --allowedTools "Read,Write,Edit,Glob,WebSearch,WebFetch" \
    --permission-mode acceptEdits \
    >> "$LOG" 2>&1; then
  log "claude call finished."
else
  log "ERROR: claude call failed (see above)."; git_push; exit 1
fi

git_push

# --- must have a Telegram summary to send ---
if [ ! -s "$TG_SUMMARY" ]; then
  log "ERROR: no Telegram summary produced ($TG_SUMMARY empty); nothing to send."
  exit 1
fi

# --- load Telegram secrets ---
if [ ! -f "$SECRETS" ]; then log "ERROR: no secrets file at $SECRETS"; exit 1; fi
set -a; . "$SECRETS"; set +a
TOK="${TELEGRAM_BOT_TOKEN:-}"; CHAT="${TELEGRAM_CHAT_ID:-}"
if [ -z "$TOK" ] || [ -z "$CHAT" ]; then log "ERROR: telegram token/chat id missing in secrets"; exit 1; fi
API="https://api.telegram.org/bot${TOK}"

SUMMARY="$(head -c 3900 "$TG_SUMMARY")"
send_ok() { printf '%s' "$1" | python3 -c 'import sys,json;print(json.load(sys.stdin).get("ok"))' 2>/dev/null; }

log "sending Telegram summary..."
RESP="$(curl -s "$API/sendMessage" --data-urlencode "chat_id=$CHAT" --data-urlencode "text=$SUMMARY")"
[ "$(send_ok "$RESP")" = "True" ] && log "summary sent OK." || log "WARN: summary send response: $RESP"

# --- full mode: render + attach the briefing document ---
if [ "$MODE" = "full" ] && [ -s "$BRIEFING_MD" ]; then
  DOC="$BRIEFING_MD"
  if python3 "$RENDER" "$BRIEFING_MD" "$BRIEFING_HTML" >> "$LOG" 2>&1 && [ -s "$BRIEFING_HTML" ]; then
    DOC="$BRIEFING_HTML"
    log "rendered HTML: $BRIEFING_HTML"
    git_push
  else
    log "WARN: HTML render failed; attaching markdown instead."
  fi
  log "attaching briefing document ($DOC)..."
  RESP="$(curl -s "$API/sendDocument" -F "chat_id=$CHAT" -F "document=@${DOC}")"
  [ "$(send_ok "$RESP")" = "True" ] && log "document sent OK." || log "WARN: document send response: $RESP"
fi

log "=== run finished OK ==="
