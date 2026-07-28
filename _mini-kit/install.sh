#!/bin/bash
# LifeOS Mini installer. Run ON THE MAC MINI after cloning the library repo:
#
#   mkdir -p ~/LifeOS-agents && cd ~/LifeOS-agents
#   git clone <REPO_URL> library
#   bash library/_mini-kit/install.sh
#
# Then copy the Telegram secrets from the MacBook (see README) and run a test.
set -u
BASE="$HOME/LifeOS-agents"
KIT="$BASE/library/_mini-kit"

fail() { echo "ERROR: $*" >&2; exit 1; }
note() { echo "==> $*"; }

[ -d "$BASE/library/.git" ] || fail "library repo not found at $BASE/library — clone it first (see header)."
[ -d "$KIT" ] || fail "kit not found at $KIT — was _mini-kit pushed from the MacBook?"

note "creating folder structure..."
mkdir -p "$BASE/agents/prompts" "$BASE/agents/lib" "$BASE/logs" "$BASE/.secrets" "$BASE/memory" "$BASE/launchd"

note "installing agents..."
cp "$KIT/agents/market-briefing.sh" "$KIT/agents/earnings-check.sh" "$KIT/agents/jensen-watch.sh" "$BASE/agents/"
cp "$KIT/agents/prompts/"*.md "$BASE/agents/prompts/"
cp "$KIT/agents/lib/render_briefing.py" "$BASE/agents/lib/"
chmod +x "$BASE/agents/"*.sh
chmod 700 "$BASE/.secrets"

# run-log only — no personal data lives on this machine
[ -s "$BASE/memory/state.json" ] || echo '{"runs":[]}' > "$BASE/memory/state.json"

note "installing launchd timers..."
mkdir -p "$HOME/Library/LaunchAgents"
for PL in com.lifeos.market-briefing com.lifeos.earnings-check com.lifeos.jensen-watch; do
  sed "s|__HOME__|$HOME|g" "$KIT/launchd/$PL.plist" > "$BASE/launchd/$PL.plist"
  cp "$BASE/launchd/$PL.plist" "$HOME/Library/LaunchAgents/$PL.plist"
  launchctl unload "$HOME/Library/LaunchAgents/$PL.plist" 2>/dev/null
  launchctl load "$HOME/Library/LaunchAgents/$PL.plist" || fail "launchctl load failed for $PL"
done

note "checks..."
if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
  echo "    claude CLI: OK"
else
  echo "    claude CLI: MISSING — install it and log in before the first run."
fi
if [ -s "$BASE/.secrets/telegram.env" ]; then
  echo "    telegram.env: OK"
else
  echo "    telegram.env: MISSING — copy it from the MacBook (see README step 4). Agents will fail to deliver until it exists."
fi
if git -C "$BASE/library" push --dry-run >/dev/null 2>&1; then
  echo "    git push access: OK"
else
  echo "    git push access: NOT WORKING — set up auth (gh auth login, or a fine-grained PAT for this repo only)."
fi
echo
launchctl list | grep lifeos || true
echo
note "done. Test with:  bash $BASE/agents/jensen-watch.sh   (check $BASE/logs/jensen-watch.log)"
