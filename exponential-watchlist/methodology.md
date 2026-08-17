# Exponential Watchlist — Methodology v1.1

A forward radar. Where `company-health/` answers *"are the businesses I own still healthy?"*, this list answers *"which businesses I **don't** own fit the exponential thesis and clear the same fundamentals bar?"*. It is a research shortlist, not a shopping list — **informational only, never mapped to buy/sell language. Decisions stay with Jude**, and per the wealth plan any new individual-stock money is satellite money, capped.

Grounding for the thesis: Azeem Azhar's Exponential Age framing (technologies improving on sustained exponential cost/performance curves — see `library/voices/azeem-azhar.md`) crossed with the LifeOS theme files (`library/themes/`: compute, energy, biology, manufacturing). The convergence version of the thesis — multiple curves compounding into one product or market — is the strongest signal.

## Structure

Two sections in `register.json`:

- **`companies`** — the watchlist proper. Every entry cleared the bar (below) on evaluation day. Capped at **20**; a new qualifier displaces the lowest-scoring name.
- **`bench`** — evaluated, scored, but below the bar. Kept so the daily agent doesn't re-evaluate the same names from scratch, and so promotions on a new earnings report are one re-score away. Bench entries carry the same data blocks and a `bench_reason`.

**Exclusions:** anything in `library/holdings-tickers.json` (those live in company-health). If a watchlist name becomes a holding, it moves to company-health and leaves this register (noted in the changelog).

## The bar (entry criteria)

1. **Fundamentals score ≥ 70 (Strong or Elite)** on the company-health rubric v1.1 — identical pillars, weights and bands. `company-health/methodology.md` is authoritative for pillar arithmetic; `mini-kit/watchlist_engine.py` owns all arithmetic (never hand-compute).
2. **Thesis fit rated `high`** (below).

Both, not either. A wonderful business off-thesis doesn't belong here; an on-thesis story with weak fundamentals sits on the bench until the numbers arrive.

## Thesis-fit rating (high / medium / low)

Three tests, rated on evidence, recorded per company in `thesis_fit`:

1. **Curve exposure** — revenue is driven by at least one technology on a sustained exponential cost/performance curve (compute & AI, energy storage/generation learning curves, biology read/write costs, robotics/autonomy).
2. **Core, not adjacent** — the exponential IS the business, not a side bet or a narrative bolt-on.
3. **Moat on the curve** — a durable competitive position such that the curve accrues to the company rather than commoditizing it (Azhar's own caution: exponential markets are fragile — see EV #595 on the Aschenbrenner blowup).

`high` = all three clearly · `medium` = two · `low` = one or none. The rating carries a `themes` list (matching `library/themes/` names) and a one-paragraph `note`. Like moat ratings, thesis-fit moves slowly and only on evidence, never on price action or hype cycles.

## Scoring

Identical to company-health rubric v1.1: growth 25 / profitability 20 / cash 20 / balance-sheet 15 / moat 15 / execution 5; bands Elite 85+ / Strong 70+ / Solid 55+ / Watch 40+ / Weak. Four judgment classifications per company (`op_trend`, `fcf_trend`, `exec_class`, `bs_class`) set from reported numbers, recorded, reproducible. Same `market_context` percentile ranks, computed against the same benchmarks (`data/benchmarks.json`, synced from company-health quarterly — if it drifts more than a quarter stale, the agent flags it rather than editing it).

**Deliberately lighter than company-health:** no `financial_history` quarterly series (this is a radar, not a monitoring dashboard — 4+ years of history gets built only if a name is actually bought and graduates to company-health). Score history per company starts at evaluation.

Fundamentals score and thesis-fit rating are **never blended into one number**. Two axes, shown separately.

## Lens 2 — Distribution moat (added 2026-08-17)

A second, separate lens on the same register — motivated by Chris Camillo's
thesis (see `library/voices/chris-camillo.md`): once intelligence commoditises,
the gains accrue to incumbents whose distribution cannot be bypassed, not to
whoever designs the better product. This is deliberately the DEMAND side of AI
— the exponential lens tracks sellers of the curve; this lens tracks buyers of
it with moats. Sections `distribution` (cleared the bar) and
`distribution_bench` in `register.json`, cap **10** (`cap_distribution`).
**No cross-lens displacement** — a lens-2 name never displaces an exponential
name or vice versa. Rail rotation does not apply to this lens.

Same fundamentals bar (score ≥ 70, same rubric, same engine). Distribution-fit
tests, rated high/medium/low exactly like thesis fit (recorded in the same
`thesis_fit` field with `themes: ["distribution"]`):

1. **Unbypassable distribution** — physical, regulatory or network
   distribution that AI agents cannot disintermediate. Screens OUT
   attention-based and middleman distribution (OTAs, comparison sites,
   ad-driven brand pull) — those are what AI bypasses.
2. **Efficiency retention** — a labour-heavy cost base AI can compress AND a
   market structure concentrated enough (or fragmented against subscale rivals)
   that the gains are RETAINED as margin rather than competed away to
   customers. Evidence beats narrative: look for AI/efficiency language in
   earnings plus margin actually held ≥2 quarters later.
3. **Not priced for it** — a boring multiple; the market does not yet treat
   the name as an AI beneficiary. (Camillo's own exit rule: when the world
   sees it, the edge is gone.)

`high` = all three clearly · `medium` = two · `low` = one or none.

**Standing note (2026-08-17):** the rubric's profitability/cash pillars
structurally punish pass-through distribution economics — a 1.6%-operating-
margin drug distributor can never score high on margin level however good the
business. That is accepted; the bar never bends. It means lens-2 promotions
are rare and driven by margin-RETENTION evidence, not margin level — which is
exactly the Camillo indicator.

**Lens-2 discovery is passive:** no daily rotation. The agent may evaluate at
most 1 lens-2 seed per run, only after exponential work is done, from the seed
list (FAST, COR, FERG, WSO, DPLM, CPNG) or names Jude adds.

## Exit rules

A name leaves the list (→ bench, with reason) when any of:
- score < 70 on two consecutive quarterly re-scores (one bad print gets a chance to recover);
- thesis-fit downgraded below high on evidence;
- displaced by a higher-scoring qualifier at the cap;
- becomes a holding → moves to company-health entirely.

## Daily protocol (the Mini agent)

Runs daily. Each run:
1. **Re-score on earnings** — any watchlist or bench name whose `next_earnings` was yesterday/today gets the full company-health re-assessment treatment (fresh data blocks, re-derived judgments, engine run). Bench names that now clear the bar are promoted.
2. **Discovery scan** — look for NEW candidates fitting the thesis (earnings season standouts, names recurring in exponential-thesis coverage). **The scan must rotate across all four rails — compute, energy, biology, manufacturing — never letting the news cycle collapse discovery into compute alone**; on each run, start from whichever rail is least represented on the list. Evaluate at most **2** new names per run, fully (all data blocks + thesis fit), into `companies` or `bench`. No candidates found = write nothing. Rail balance is a *search* discipline, not a scoring one: the bar never bends to fill a rail.
3. **Date hygiene** — firm up approximate `next_earnings` strings within ~3 weeks (max 5 lookups/run).
4. **Telegram only on changes** — new entrant, promotion, exit, score move ≥5, or band cross. A silent day is a correct day.

All numbers from reported filings/press releases plus a secondary source; `data_confidence` set honestly; low confidence stated in the changelog. Never estimate a figure — null it.

## Known limitations
- Twenty slots and a Strong+ bar mean the list misses early-stage exponential names whose financials haven't inflected (RKLB-class). That's by design — the bench and the themes files are where those live.
- Discovery is model-driven scanning, not an exhaustive market screen; coverage is only as good as the day's sweep. The cap keeps that honest.
- Same cyclicality caveat as company-health: trailing-number scores flatter cyclicals at peak.
- Newly public companies (SPCX-class) often lack the reporting history to classify trends — they sit on the bench at low confidence rather than being force-scored.

## Changelog
- 2026-08-07: v1.0 — methodology written; initial universe of 20 candidates evaluated and seeded (Cowork session).
- 2026-08-17: v1.1 — Lens 2 (distribution moat) added: separate sections/cap, same fundamentals bar, three distribution-fit tests, passive discovery. Six candidates evaluated and seeded on distribution_bench (Cowork session).
