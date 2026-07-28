#!/bin/bash
# LifeOS earnings-check (daily, weekdays). Cheap guard — NO model call unless one
# of Jude's holdings actually reports today. Reads the earnings calendar the
# full briefing wrote (library/earnings-upcoming.json); if any ticker's date is
# today, fires market-briefing.sh in earnings-ping mode for those tickers.
set -u
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

LIFEOS="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$LIFEOS/logs/market-briefing.log"
JSON="$LIFEOS/library/earnings-upcoming.json"
DATE="$(date +%F)"
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] earnings-check: $*" | tee -a "$LOG" >&2; }

if [ ! -s "$JSON" ]; then log "no earnings calendar yet ($JSON) — nothing to check."; exit 0; fi

TICKERS="$(python3 - "$JSON" "$DATE" <<'PY'
import json, sys
path, today = sys.argv[1], sys.argv[2]
try:
    data = json.load(open(path))
    hits = sorted({str(e.get("ticker","")).strip().upper()
                   for e in data if str(e.get("date","")).strip() == today and e.get("ticker")})
    print(",".join(t for t in hits if t))
except Exception:
    print("")
PY
)"

if [ -z "$TICKERS" ]; then
  log "no holdings report today ($DATE); exiting quietly."
  exit 0
fi

log "holdings reporting today: $TICKERS — firing earnings-ping."
exec "$LIFEOS/agents/market-briefing.sh" --mode=earnings-ping --tickers="$TICKERS"
