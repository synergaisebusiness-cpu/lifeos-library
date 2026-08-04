#!/usr/bin/env python3
"""Recompute company-health scores from register.json in place.

The re-score agent edits each company's DATA block (revenue, margins, fcf,
balance_sheet, segments, notes) and its score.judgment classifications, then
runs this engine. All arithmetic lives here so scores are reproducible and
the model never does mental maths.

Usage:  python3 score_engine.py /path/to/register.json [--event "PLTR Q2 2026 report"] [--date YYYY-MM-DD]
"""
import json, sys, datetime

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
    """Where a value sits against the market-wide distribution."""
    if v is None: return None
    if v >= ladder["p90"]: return "top 10%"
    if v >= ladder["p75"]: return "top 25%"
    if v >= ladder["p50"]: return "above median"
    if v >= ladder["p25"]: return "below median"
    return "bottom 25%"

def refresh_market_context(reg):
    """Recomputeeach company's percentile ranks against the benchmarks block."""
    b = reg.get("benchmarks")
    if not b: return
    P = b["percentiles"]
    for c in reg["companies"]:
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
    changed = []
    for c in reg["companies"]:
        total, ss = score(c)
        old = c["score"]["total"]
        c["score"]["total"] = total
        c["score"]["band"] = bandname(total)
        c["score"]["subscores"] = ss
        if total != old:
            c["score"].setdefault("history", []).append(
                {"date": date, "total": total, "event": event or "re-score"})
            changed.append((c["ticker"], old, total))
    refresh_market_context(reg)
    reg["companies"].sort(key=lambda x: -x["score"]["total"])
    reg["as_of"] = date
    json.dump(reg, open(path, "w"), indent=1)
    if changed:
        for t, o, n in changed:
            print(f"{t}: {o} -> {n}")
    else:
        print("no score changes")

if __name__ == "__main__":
    main()
