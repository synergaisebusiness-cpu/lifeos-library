# Exponential-watchlist Mini deployment — runbook

One-time setup, ~5 minutes, from the MacBook. The kit files sync to the Mini via the library repo automatically (they live in `library/exponential-watchlist/mini-kit/`); you just need to install the wrapper + timer on the Mini.

## What runs
Daily 07:45 UK on the Mini: `exponential-watchlist.sh` pulls the library, then a headless claude (1) re-scores any watchlist/bench name that reported earnings yesterday/today, (2) runs a light discovery scan for new exponential-thesis candidates (max 2 evaluated per run), (3) runs `watchlist_engine.py` (all arithmetic) + rebuilds `dashboard.html`, then the library is pushed. Telegram pings ONLY when something changed — the agent outputs `NO_CHANGES` on a quiet day and the wrapper stays silent (like jensen-watch, a silent day is a correct day).

Unlike company-health, this makes a model call every day — the discovery scan is the point. It burns some daily usage on the Mini's business Max account (same accepted trade-off as the other agents).

Why 07:45: after jensen-watch (07:00), company-health (07:10) and market-briefing (07:30 Mon/Thu), so the agents never overlap and earnings coverage from the prior US evening is settled.

## Install (ssh from MacBook)
```bash
ssh synergaise@100.94.218.62

# 1. Pull the library so the kit is present
cd ~/LifeOS-agents/library   # the Mini's clone of lifeos-library
git pull

# 2. Install the wrapper next to the other agents
cp exponential-watchlist/mini-kit/exponential-watchlist.sh ~/LifeOS-agents/exponential-watchlist.sh
chmod +x ~/LifeOS-agents/exponential-watchlist.sh
# If the library clone is NOT at ~/LifeOS-agents/library, edit LIBRARY_DIR at the top of the script.
# If telegram.env lives elsewhere, edit TELEGRAM_ENV to match the other agents.

# 3. Dry-run (makes one model call — the discovery scan runs every day by design)
bash ~/LifeOS-agents/exponential-watchlist.sh; tail -30 ~/LifeOS-agents/logs/exponential-watchlist.log

# 4. Install the timer
cp ~/LifeOS-agents/library/exponential-watchlist/mini-kit/com.lifeos.exponential-watchlist.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.lifeos.exponential-watchlist.plist
launchctl list | grep lifeos   # should show exponential-watchlist alongside the others
```

## Refreshing the Cowork dashboard artifact
The Mini keeps `register.json` + `dashboard.html` current in the library (synced to the MacBook hourly). The Cowork sidebar artifact ("exponential-watchlist") can't be updated by the Mini — a scheduled Cowork task re-renders it each morning when the Mac is online, or say **"refresh the exponential watchlist"** in any LifeOS Cowork session.

## Watch-items
- Same PAT expiry (~late Oct 2026) as the other Mini agents — on push failure the agent logs "git push failed" and keeps running, but the MacBook stops seeing updates.
- Same OAuth-expiry gotcha as all agents: if the run dies immediately, check the log for "OAuth session expired" — Jude must re-login interactively on the Mini.
- If a whole earnings season passes with no re-scores, `next_earnings` dates have probably gone stale — say "refresh watchlist earnings dates" in a Cowork session.
- The discovery scan can drift toward whatever the news cycle hypes. The bar (Strong fundamentals AND high thesis fit) is the defence; if the bench fills with hype names, tighten the prompt.
