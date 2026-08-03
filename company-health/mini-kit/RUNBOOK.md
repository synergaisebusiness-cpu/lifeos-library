# Company-health Mini deployment — runbook

One-time setup, ~5 minutes, from the MacBook. The kit files sync to the Mini via the library repo automatically (they live in `library/company-health/mini-kit/`); you just need to install the wrapper + timer on the Mini.

## What runs
Weekdays 07:10 UK on the Mini: `company-health.sh` checks register.json for holdings whose `next_earnings` was yesterday or today. If none — exits with no model call (free). If some — a headless claude re-scores exactly those companies per `methodology.md`, the score engine recomputes the numbers, the dashboard HTML is rebuilt, the library is pushed (so the MacBook copy updates within the hour), and a short figure-free summary lands on Telegram.

Why 07:10: US earnings drop after UK 21:00 and calls finish late; by 07:10 the numbers and coverage are settled, and it slots before jensen-watch (07:00 fires first) and market-briefing (07:30).

## Install (ssh from MacBook)
```bash
ssh synergaise@100.94.218.62

# 1. Pull the library so the kit is present
cd <LIBRARY_DIR>   # the Mini's clone of lifeos-library
git pull

# 2. Install the wrapper next to the other agents
cp company-health/mini-kit/company-health.sh ~/LifeOS-agents/company-health.sh
chmod +x ~/LifeOS-agents/company-health.sh
# If the library clone is NOT at ~/LifeOS-agents/library, edit LIBRARY_DIR at the top of the script.
# If telegram.env lives elsewhere on the Mini, edit TELEGRAM_ENV too (check where market-briefing.sh reads it from and match that).

# 3. Dry-run (safe: exits with no model call unless a holding reported yesterday/today)
bash ~/LifeOS-agents/company-health.sh; tail -20 ~/LifeOS-agents/logs/company-health.log

# 4. Install the timer
cp <LIBRARY_DIR>/company-health/mini-kit/com.lifeos.company-health.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.lifeos.company-health.plist
launchctl list | grep lifeos   # should now show company-health alongside the others
```

## Forcing a real test
Tomorrow (Tue 4 Aug) AMD, ANET and CAT report — Wednesday 07:10 will be the first live run. To test before then: `LIBRARY_DIR=<...> bash ~/LifeOS-agents/company-health.sh` on a day after any holding's earnings, or temporarily set a ticker's `next_earnings` to yesterday's date in register.json (revert after).

## Refreshing the Cowork dashboard artifact
The Mini keeps `register.json` + `dashboard.html` current in the library (synced to the MacBook hourly). The Cowork sidebar artifact can't be updated by the Mini — in any LifeOS Cowork session say **"refresh the health dashboard"** and Claude will re-render the artifact from the latest register.

## Watch-items
- Same PAT expiry (~late Oct 2026) as the other Mini agents — if pushes fail this agent logs "git push failed" and keeps running, but the MacBook stops seeing updates.
- PLTR reported 3 Aug (today, after close) — the baseline register scores it on Q1 data. The first scheduled run that catches it is Tue 4 Aug 07:10 if the timer is installed today; otherwise re-score it manually in a Cowork session.
- Known gap: companies with only approximate `next_earnings` ("late October") won't auto-trigger until the agent firms the date up (it does this for anything within ~3 weeks on each run that fires). If a whole month passes with no runs firing, dates may go stale — say "refresh earnings dates" in a Cowork session.
