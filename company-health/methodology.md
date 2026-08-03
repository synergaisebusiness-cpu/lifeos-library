# Company Health Score — Methodology v1.0

Scores the *business*, not the stock. Price action is deliberately excluded — no price, valuation, or P&L inputs anywhere. A company is re-scored after every earnings report; the score answers one question: **are the fundamentals of this business strong and getting stronger?**

Grounding: quality-investing practice (Piotroski F-Score's profitability/leverage/efficiency signals, the Rule of 40 for software economics, and Morningstar-style moat ratings), adapted to a growth-quality lens across sectors.

Informational only. Scores never map to buy/sell/trim actions — decisions stay with Jude.

## The score: /100 across six pillars

| Pillar | Max | What it measures |
|---|---|---|
| Growth | 25 | Revenue pace, acceleration, breadth across segments |
| Profitability | 20 | Operating margin level and trajectory |
| Cash generation | 20 | FCF margin and FCF trajectory |
| Balance sheet | 15 | Net cash/debt vs cash generation |
| Moat | 15 | Durability of competitive advantage |
| Execution & guidance | 5 | Beat/miss pattern, guidance direction |

Bands: **Elite 85–100 · Strong 70–84 · Solid 55–69 · Watch 40–54 · Weak 0–39**

## Pillar rules

### Growth (25 = pace 15 + acceleration 5 + breadth 5)
- Pace — latest reported quarter revenue YoY: ≥40% →15 · 25–40 →13 · 15–25 →10 · 8–15 →7 · 3–8 →4 · 0–3 →2 · negative →1
- Acceleration — latest YoY vs prior quarter's YoY: accelerating (≥+2pp) →5 · flat (±2pp) →3 · decelerating →1
- Breadth — share of reported segments growing >5% YoY: all →5 · ≥half →3 · <half →1 (·3 if segment data insufficient)

### Profitability (20 = level 10 + trend 10)
- Level — GAAP operating margin: ≥40% →10 · 30–40 →8 · 20–30 →6 · 10–20 →4 · 0–10 →2 · negative →0. **Non-GAAP floor:** if GAAP is negative/near-zero but non-GAAP operating margin is clearly positive AND improving (heavy SBC names like CRWD/DDOG), floor level at 4.
- Trend vs a year ago, ex one-offs: expanding →10 · flat →6 · compressing →2

### Cash generation (20 = FCF margin 10 + trajectory 10)
- FCF margin (TTM): ≥30% →10 · 20–30 →8 · 10–20 →6 · 0–10 →3 · negative →0
- Trajectory: surging (≥~40% growth or inflecting) →10 · growing →7 · flat/lumpy →4 · declining →2 · negative/burning →0
- Judgment notes required where FCF is distorted (customer advances → GEV; deliberate capex bets → AMZN/ORCL/TSLA: score what IS, flag the context in the watch note).

### Balance sheet (15)
Classify net position vs annual FCF: net cash →15 · roughly neutral (net debt <1× FCF) →12 · moderate (1–3×) →9 · elevated (3–6×) →6 · heavy (>6× or ballooning) →3.
Captive finance arms (DE, CAT, SIE) are judged on industrial/equipment-operations leverage, not the consolidated headline.

### Moat (15 = qualitative rating 1–5 × 3)
5 = structural monopoly/ecosystem lock-in (ASML, AAPL, NVDA-class) · 4 = durable franchise with real switching costs · 3 = advantaged but contested or commodity-adjacent · 2 = weak differentiation · 1 = none. Re-rated only on evidence (share shifts, pricing power changes), not on price action or narrative.

### Execution & guidance (5)
beat-and-raise →5 · beat/maintained →4 · in-line →3 · mixed (beat one line, missed other, or guide down) →2 · miss-and-cut →1

## Judgment classifications
Four inputs are judgment calls, not formula: op_trend, fcf_trend, exec_class, bs_class. They must be set from the reported numbers per the definitions above and recorded in the register so every score is reproducible and auditable. Per LifeOS rules these are hypotheses with confidence levels — data_confidence is carried per company and low-confidence scores must say so.

## Re-assessment protocol (every earnings report)
1. Pull the new quarter's reported figures (press release + a secondary source).
2. Update the company's data block; re-derive the four judgment classifications.
3. Recompute the score; append `{date, total, event: "Qx report"}` to score history.
4. If the score moves ≥10 points or crosses a band boundary, say why in one sentence in the changelog.
5. Never adjust the rubric to make a score "feel right" — rubric changes are versioned (v1.0 → v1.1) and noted in the changelog.

## Known limitations (honest list)
- Cyclicals at peak (MU today) score Elite on trailing numbers; the score measures current health, not durability of that health. Watch notes carry the cyclicality caveat — read them.
- One quarter of segment data can misclassify breadth for companies with lumpy segments.
- Moat ratings are opinion; they move slowly by design.
- Non-USD reporters (ASML, SIE, SU, CCJ) are scored in reporting currency; no FX adjustment.

## Changelog
- 2026-08-03: v1.0 — initial methodology + baseline scoring of all 29 holdings (Cowork session).
