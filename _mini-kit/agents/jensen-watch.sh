#!/bin/bash
# LifeOS jensen-watch agent — MAC MINI EDITION (runs from ~/LifeOS-agents).
# Daily Jensen Huang / NVIDIA-signal sweep. Same behaviour as the MacBook
# original, plus git sync of the library (pull before, commit+push after).
# Silent unless something new. Informational only — never advice.
set -u
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

LIFEOS="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$LIFEOS/logs/jensen-watch.log"
PROMPT_FILE="$LIFEOS/agents/prompts/jensen-watch.md"
SECRETS="$LIFEOS/.secrets/telegram.env"
LIB="$LIFEOS/library"
mkdir -p "$LIFEOS/logs"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] jensen-watch: $*" | tee -a "$LOG" >&2; }

git_pull() { git -C "$LIB" pull --rebase --autostash --quiet 2>>"$LOG" || log "WARN: git pull failed (continuing with local copy)"; }
git_push() {
  git -C "$LIB" add -A 2>>"$LOG"
  if ! git -C "$LIB" diff --cached --quiet 2>/dev/null; then
    git -C "$LIB" commit -m "jensen-watch: $DATE" --quiet 2>>"$LOG" || log "WARN: git commit failed"
    git -C "$LIB" push --quiet 2>>"$LOG" || log "WARN: git push failed (will sync on next successful push)"
  fi
}

DATE="$(date +%F)"
TG_SUMMARY="$LIFEOS/logs/tg-jensen-$DATE.txt"
: > "$TG_SUMMARY"

log "=== run started ==="
git_pull

CLAUDE_BIN="$(command -v claude || true)"
[ -z "$CLAUDE_BIN" ] && CLAUDE_BIN="$HOME/.local/bin/claude"
if [ ! -x "$CLAUDE_BIN" ]; then log "ERROR: claude CLI not found"; exit 1; fi

RUNTIME="

---
# RUNTIME INPUTS
TODAY: $DATE
TG_SUMMARY (write ONLY if there is something new): $TG_SUMMARY
Voice log to dedupe against and append to: $LIB/voices/jensen-huang.md
Remember: silent empty day is a correct outcome. Cite sources. Append-only. No advice, no personal figures.
"

cd "$LIFEOS" || exit 1
log "invoking claude (web scan; may take a few minutes)..."
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

# --- silent day? ---
if [ ! -s "$TG_SUMMARY" ]; then
  log "nothing new today — staying silent."
  rm -f "$TG_SUMMARY"
  log "=== run finished OK (silent) ==="
  exit 0
fi

# --- load Telegram secrets ---
if [ ! -f "$SECRETS" ]; then log "ERROR: no secrets file at $SECRETS"; exit 1; fi
set -a; . "$SECRETS"; set +a
TOK="${TELEGRAM_BOT_TOKEN:-}"; CHAT="${TELEGRAM_CHAT_ID:-}"
if [ -z "$TOK" ] || [ -z "$CHAT" ]; then log "ERROR: telegram token/chat id missing in secrets"; exit 1; fi
API="https://api.telegram.org/bot${TOK}"

SUMMARY="$(head -c 3900 "$TG_SUMMARY")"
send_ok() { printf '%s' "$1" | python3 -c 'import sys,json;print(json.load(sys.stdin).get("ok"))' 2>/dev/null; }

log "new material found — sending Telegram note..."
RESP="$(curl -s "$API/sendMessage" --data-urlencode "chat_id=$CHAT" --data-urlencode "text=$SUMMARY")"
[ "$(send_ok "$RESP")" = "True" ] && log "note sent OK." || log "WARN: send response: $RESP"

log "=== run finished OK ==="
