#!/usr/bin/env python3
"""Recompute exponential-watchlist scores from register.json in place.

Same rubric arithmetic as company-health/mini-kit/score_engine.py (v1.1) —
kept as a self-contained copy so the kit installs independently. The agent
edits DATA blocks + score.judgment (+ thesis_fit on evidence), then runs this.
All arithmetic lives here; the model never does mental maths.

Scores ALL sections (companies + bench + distribution + distribution_bench). Does NOT move entries between
sections — promotions/demotions are judgment calls per methodology.md — but
prints WARN lines when a bench entry now clears the bar (score>=70 AND
thesis_fit high) or a watchlist entry falls below it, so the agent acts.

Usage: python3 watchlist_engine.py /path/to/register.json [--event "TSM Q3 report"] [--date YYYY-MM-DD]
"""
import json, sys, os, datetime

def band(v, cuts):
    for t, p in cuts:
        if v is not None and v >= t:
            return p
    return cuts[-1][1] if v is not None else 0

def bandname(t):
    if t >= 85: return "Elite"
    if t >= 70: return "Strong"
    if t >= 55: return "Solid"
    if t >= 40: return "Watch"
    return "Weak"

def score(c):
    j = c["score"]["judgment"]
    r, m = c["revenue"], c["margins"]
    ss = {}
    g = r["latest_q_yoy_pct"]
    g_level = band(g, [(40,15),(25,13),(15,10),(8,7),(3,4),(0,2),(-100,1)])
    prior = r.get("prior_q_yoy_pct")
    if g is None or prior is None: g_accel = 3
    elif g - prior >= 2: g_accel = 5
    elif g - prior >= -2: g_accel = 3
    else: g_accel = 1
    segs = [s["latest_q_yoy_pct"] for s in c["segments"] if s["latest_q_yoy_pct"] is not None]
    if len(segs) >= 2:
        frac = sum(1 for s in segs if s > 5) / len(segs)
        g_breadth = 5 if frac >= 0.99 else (3 if frac >= 0.5 else 1)
    else:
        g_breadth = 3
    ss["growth"] = {"points": g_level+g_accel+g_breadth, "max": 25,
                    "detail": {"pace": g_level, "acceleration": g_accel, "breadth": g_breadth}}
    op = m["operating_pct"]
    p_level = band(op, [(40,10),(30,8),(20,6),(10,4),(0,2),(-100,0)])
    if j.get("nongaap_floor") and p_level < 4: p_level = 4
    p_trend = {"expanding":10, "flat":6, "compressing":2}[j["op_trend"]]
    ss["profitability"] = {"points": p_level+p_trend, "max": 20, "detail": {"level": p_level, "trend": p_trend}}
    fm = m["fcf_margin_pct"]
    c_level = band(fm, [(30,10),(20,8),(10,6),(0,3),(-1000,0)])
    c_trend = {"surging":10, "growing":7, "flat":4, "declining":2, "negative":0}[j["fcf_trend"]]
    ss["cash"] = {"points": c_level+c_trend, "max": 20, "detail": {"fcf_margin": c_level, "trajectory": c_trend}}
    ss["balance_sheet"] = {"points": {"net_cash":15,"neutral":12,"moderate":9,"elevated":6,"heavy":3}[j["bs_class"]],
                           "max": 15, "detail": {"class": j["bs_class"]}}
    ss["moat"] = {"points": c["moat"]["rating_1to5"]*3, "max": 15, "detail": {"rating": c["moat"]["rating_1to5"]}}
    ss["execution"] = {"points": {"beat_raise":5,"beat":4,"inline":3,"mixed":2,"miss_cut":1}[j["exec_class"]],
                       "max": 5, "detail": {"class": j["exec_class"]}}
    return sum(v["points"] for v in ss.values()), ss

def pct_rank(v, ladder):
    if v is None: return None
    if v >= ladder["p90"]: return "top 10%"
    if v >= ladder["p75"]: return "top 25%"
    if v >= ladder["p50"]: return "above median"
    if v >= ladder["p25"]: return "below median"
    return "bottom 25%"

def refresh_market_context(entries, b):
    if not b: return
    P = b["percentiles"]
    for c in entries:
        c["market_context"] = {
            "rev_growth": {"value": c["revenue"]["latest_q_yoy_pct"],
                           "rank": pct_rank(c["revenue"]["latest_q_yoy_pct"], P["rev_growth"]),
                           "vs_sp500_aggregate": round((c["revenue"]["latest_q_yoy_pct"] or 0) - b["sp500"]["rev_growth_yoy_pct"], 1)},
            "op_margin": {"value": c["margins"]["operating_pct"], "rank": pct_rank(c["margins"]["operating_pct"], P["op_margin"])},
            "gross_margin": {"value": c["margins"]["gross_pct"], "rank": pct_rank(c["margins"]["gross_pct"], P["gross_margin"])},
            "fcf_margin": {"value": c["margins"]["fcf_margin_pct"], "rank": pct_rank(c["margins"]["fcf_margin_pct"], P["fcf_margin"])},
        }

def main():
    path = sys.argv[1]
    event = None; date = datetime.date.today().isoformat()
    args = sys.argv[2:]
    while args:
        a = args.pop(0)
        if a == "--event": event = args.pop(0)
        elif a == "--date": date = args.pop(0)
    reg = json.load(open(path))
    bpath = os.path.join(os.path.dirname(os.path.abspath(path)), "data", "benchmarks.json")
    benchmarks = json.load(open(bpath)) if os.path.exists(bpath) else None
    changed = []
    dist = reg.get("distribution", []); dist_bench = reg.get("distribution_bench", [])
    everyone = reg["companies"] + reg.get("bench", []) + dist + dist_bench
    for c in everyone:
        total, ss = score(c)
        old = c["score"].get("total")
        c["score"]["total"] = total
        c["score"]["band"] = bandname(total)
        c["score"]["subscores"] = ss
        if total != old:
            c["score"].setdefault("history", []).append(
                {"date": date, "total": total, "event": event or "re-score"})
            changed.append((c["ticker"], old, total))
    refresh_market_context(everyone, benchmarks)
    reg["companies"].sort(key=lambda x: -x["score"]["total"])
    reg.get("bench", []).sort(key=lambda x: -x["score"]["total"])
    dist.sort(key=lambda x: -x["score"]["total"])
    dist_bench.sort(key=lambda x: -x["score"]["total"])
    reg["as_of"] = date
    json.dump(reg, open(path, "w"), indent=1)
    if changed:
        for t, o, n in changed:
            print(f"{t}: {o} -> {n}")
    else:
        print("no score changes")
    # bar checks (informational — moves are the agent's judgment call)
    for c in reg["companies"]:
        if c["score"]["total"] < 70 or c["thesis_fit"]["rating"] != "high":
            print(f"WARN: {c['ticker']} on watchlist but below bar (score {c['score']['total']}, fit {c['thesis_fit']['rating']}) — check exit rules")
    for c in reg.get("bench", []):
        if c["score"]["total"] >= 70 and c["thesis_fit"]["rating"] == "high":
            print(f"WARN: {c['ticker']} on bench but clears bar (score {c['score']['total']}) — consider promotion")
    n = len(reg["companies"])
    if n > reg.get("cap", 20):
        print(f"WARN: watchlist has {n} entries, over the cap of {reg.get('cap',20)} — displace the lowest scorer")
    # lens 2 (distribution-moat) bar checks — same pattern, separate sections, no cross-lens moves
    for c in dist:
        if c["score"]["total"] < 70 or c["thesis_fit"]["rating"] != "high":
            print(f"WARN: {c['ticker']} on distribution list but below bar (score {c['score']['total']}, fit {c['thesis_fit']['rating']}) — check exit rules")
    for c in dist_bench:
        if c["score"]["total"] >= 70 and c["thesis_fit"]["rating"] == "high":
            print(f"WARN: {c['ticker']} on distribution bench but clears bar (score {c['score']['total']}) — consider promotion")
    nd = len(dist)
    if nd > reg.get("cap_distribution", 10):
        print(f"WARN: distribution list has {nd} entries, over the cap of {reg.get('cap_distribution',10)} — displace the lowest scorer")

if __name__ == "__main__":
    main()
