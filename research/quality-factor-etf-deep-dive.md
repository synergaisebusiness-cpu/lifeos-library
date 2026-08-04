# Quality Factor ETFs — Deep Dive

**Research date: 4 August 2026 · Subject: iShares Edge MSCI World Quality Factor UCITS ETF (IWQU, IE00BP3QZ601) and alternatives**

Public fund research only. No personal positions or figures. Informational, not advice.

---

## Executive summary

The quality factor has a real academic foundation. The specific ETF most UK investors reach for to express it — IWQU — tracks a **constrained** version of the index that has **underperformed plain MSCI World over its entire live decade**.

| | 10yr annualised (net USD, to 30 Apr 2026) |
|---|---|
| MSCI World Sector Neutral Quality (IWQU's index) | **12.22%** |
| MSCI World | **12.65%** |
| Difference | **−0.43pp per year** |

Sharpe over the same decade: 0.71 vs 0.72. No risk-adjusted improvement either.

The unconstrained MSCI World Quality Index, by contrast, returned 15.36% vs 13.70% over 10 years (gross USD, to 30 Jun 2026) — **+1.66pp/yr**. Same factor, different construction, opposite outcome.

**The core finding: sector neutrality is what breaks it, and sector neutrality is exactly what IWQU buys.**

---

## 1. What the index actually does

IWQU tracks the **MSCI World Sector Neutral Quality Index** — not the headline "MSCI World Quality Index" that most factor marketing cites. This distinction drives nearly everything below.

**Three screens**, each z-scored, winsorised at the 5th/95th percentiles, then equally averaged:

| Variable | Definition | Direction |
|---|---|---|
| Return on Equity | Trailing 12m EPS ÷ latest book value per share | Higher better |
| Debt-to-Equity | Total debt ÷ book value | Lower better |
| Earnings Variability | Std dev of YoY EPS growth over 5 fiscal years | Lower better |

**Sector neutrality is applied twice.** First at scoring — a company is ranked against its own GICS sector peers, not the whole market. Second at weighting — sector weights are reset to match MSCI World's at each rebalance. If a sector scores badly overall, the index still holds it at parent weight, buying the least-bad names within it.

**Weighting:** quality score × market-cap weight, normalised. 5% single-issuer cap. ~300 constituents from a parent universe of ~1,283. Semi-annual rebalance (May/November), with a 20% buffer band (ranks 241–360) to suppress turnover.

**Parent universe — what's excluded matters.** MSCI World is 23 developed markets, large and mid cap only. No emerging markets (so no TSMC, no Samsung), no small caps. Roughly 73% United States at index level — higher than plain MSCI World, because US firms dominate the high-ROE/low-leverage screen.

---

## 2. The performance record

### Annualised, net USD, to 30 April 2026

| Period | SN Quality | MSCI World | Diff |
|---|---|---|---|
| 1 year | 23.95% | 29.16% | −5.21pp |
| 3 years | 17.80% | 19.70% | −1.90pp |
| 5 years | 10.28% | 11.29% | −1.01pp |
| **10 years** | **12.22%** | **12.65%** | **−0.43pp** |
| Since inception (Nov 1998) | 8.04% | 7.27% | +0.77pp |

**The since-inception figure is the tell.** The index launched 11 August 2014 with backtested history to 1998. All of the claimed outperformance sits in the simulated window; the live decade is negative. IWQU itself launched 3 October 2014 — real money has only ever experienced the underperforming regime.

### Calendar years (net USD)

| Year | SN Quality | MSCI World | Relative |
|---|---|---|---|
| 2015 | +2.63% | −0.87% | **+3.50** |
| 2016 | +5.05% | +7.51% | −2.46 |
| 2017 | +23.21% | +22.40% | +0.81 |
| 2018 | −7.20% | −8.71% | **+1.51** |
| 2019 | +30.65% | +27.67% | **+2.98** |
| 2020 | +14.98% | +15.90% | −0.92 |
| 2021 | +23.42% | +21.82% | +1.60 |
| **2022** | **−19.16%** | **−18.14%** | **−1.02** |
| 2023 | +25.83% | +23.79% | +2.04 |
| 2024 | +16.81% | +18.67% | −1.86 |
| 2025 | +15.49% | +21.09% | **−5.60** |

**Did quality protect in 2022? No — it fell further.** −19.16% vs −18.14%. The 2022 drawdown was a rate/duration shock that punished exactly the long-duration, high-multiple growth names the quality screen selects. The defensive claim failed in the one episode where it mattered most.

**2025 was the worst relative year on record** at −5.60pp, driven by a low-quality/high-beta rally after the April 2025 tariff moderation and factor rotation toward momentum and AI mega-caps. J.P. Morgan called it quality's worst 12 months since COVID.

The years quality did work — 2015, 2018, 2019 — all preceded the bad run. Anyone who bought after the good years has experienced mostly the bad ones.

### Risk metrics (index level, to 30 Apr 2026)

| Metric | SN Quality | MSCI World |
|---|---|---|
| Beta | 0.95 | 1.00 |
| Tracking error | 2.93% | — |
| Sharpe 3yr | 1.01 | 1.12 |
| Sharpe 5yr | 0.49 | 0.56 |
| **Sharpe 10yr** | **0.71** | **0.72** |
| Annual turnover | **22.57%** | 2.30% |

Ten times the turnover for identical risk-adjusted returns.

---

## 3. The academic case, and where it breaks down

**The factor is real.** Asness, Frazzini & Pedersen's *Quality Minus Junk* (2013, rev. 2017) documents a robust premium across 24 countries for stocks that are "safe, profitable, growing and well managed." AQR's quality factor delivered ~4.11% annualised with a t-stat of 4.30 in US data — statistically strong. Novy-Marx's gross profitability work is the other pillar.

**Three problems with getting it through this ETF:**

**(a) Two of MSCI's three screens are the ones with no documented premium.** Hsu, Kalesnik & Kose's *What Is Quality?* (Financial Analysts Journal, 2019 — Graham & Dodd award) audited six providers' quality definitions and sorted characteristics into robust and non-robust. Premium found for: profitability, accounting quality, payout/dilution, investment. **No evidence of premium for: earnings stability (16% average significance) and capital structure (0%).** MSCI uses ROE (profitability — robust), Debt-to-Equity (capital structure — 0%) and Earnings Variability (earnings stability — 16%). Two-thirds of the signal rests on characteristics the leading academic audit could not validate.

Their broader conclusion is blunt: quality indices are best read as multifactor portfolios rather than a standalone premium, and index design "seems driven more by marketing optics than theory or data."

**(b) The premium lives largely in the short leg.** Both WEDGE Capital's review and MSCI itself concede the effect comes mostly from *junk underperforming*, not from high-quality names outperforming. MSCI states the debt-to-equity premium "was largely driven by the poor performance of highly leveraged companies" — a short-side effect "limiting long-only effectiveness." IWQU is long-only and holds ~300 of ~1,283 names. It captures the weaker half of the trade.

**(c) Sector neutrality halves what's left.** MSCI's own research (Dec 2000 – Mar 2023): unconstrained quality delivered **+189bps/yr**; sector-neutral delivered **+96bps/yr**. The rationale for neutralising is to remove "unintended" sector bets — underweight financials, overweight tech and healthcare. But those bets *were* much of the return. The 2020 case is the cleanest illustration: unconstrained quality +22.73% vs MSCI World +16.50%, while sector-neutral quality returned +14.98% vs +15.90%. Same factor, same year, opposite result — purely from the constraint.

**One mechanical wrinkle worth noting:** ROE uses book value as its denominator, so buybacks (which shrink book equity) mechanically inflate it without operational improvement, and intangible-heavy firms that expense R&D look artificially high-ROE. Leverage also inflates ROE — while MSCI simultaneously penalises leverage, so the two screens partially cancel each other.

---

## 4. The counterargument

The strongest bull case is **not** the realised record — it's valuation.

J.P. Morgan Asset Management (Factor Views, 2Q 2026) reports that high-quality stocks now trade at a **discount** to the broad market relative to their long-term history, describing the US quality factor as "more attractive than at any time outside the dot-com bubble and the COVID-era dislocation," with "no signs that fundamentals have deteriorated." They are close to upgrading quality from neutral to positive.

That reframes the recent underperformance as **de-rating rather than crowding** — the factor got cheaper, not broken. Parametric adds that historically, following a year of quality underperformance, quality outperformed over the subsequent three years 77% of the time (practitioner statistic, unspecified sample window, treat with caution).

So the case for buying quality today rests on mean reversion from a cheap starting point, not on a track record of it working.

---

## 5. If buying anyway — the vehicle matters

**XDEQ (Xtrackers MSCI World Quality UCITS ETF 1C, IE00BL25JL35) is the better wrapper for the identical index.**

| | IWQU | XDEQ |
|---|---|---|
| Index | MSCI World Sector Neutral Quality | Same |
| TER | 0.25% | 0.25% |
| Avg tracking difference | 0.10%/yr | **0.05%/yr** |
| Replication | Physical, optimised sampling | Physical |
| Fund size | ~USD 5.6bn | ~EUR 2.8bn |
| LSE line | IWQU (USD), IWFQ (GBX) | XDEQ (GBX) |
| On Trading 212 | Yes | Yes |

Both funds cost *less* in practice than their headline TER — Irish domicile means 15% US withholding tax under the treaty versus the 30% the net-return index assumes, so 15–20bp/yr is recovered.

**Trading 212 FX note:** T212 charges 0.15% on trades in a non-account currency. Buying the USD line (IWQU) costs that on both buy and sell; the GBX lines (IWFQ or XDEQ) avoid it. Roughly a 0.3% round-trip saving — about a year's TER.

**IWFQ is a GBP trading line, not a hedged share class.** It removes the broker FX fee. It does not reduce currency exposure by a single basis point. No GBP-hedged MSCI World Quality ETF exists.

**The unconstrained version isn't practically available.** iShares MSCI World Quality Factor Advanced (IE000U1MQKJ2) tracks an unconstrained index with ~130 holdings — but it has no LSE listing and only ~£54m in assets. The version that historically worked is the one you can't easily buy in a UK ISA.

**Adjacent strategies on T212**, all genuinely different rather than cheaper wrappers:

| Fund | Ticker | TER | How it differs |
|---|---|---|---|
| VanEck Morningstar Global Wide Moat | GOAT / GOGB | 0.52% | Analyst-judged moats + valuation overlay, 74 holdings, roughly equal-weighted |
| JPMorgan Global Equity Multi-Factor | JPGL | 0.19% | Value/momentum/low-vol/size, region- and industry-neutral, 535 holdings |
| Fidelity Global Quality Income | FGQI / FGQD | 0.40% | Quality + high-yield screen, tilts to mature cash-returners |
| WisdomTree Global Quality Dividend Growth | GGRP / GGRA | 0.38% | Dividend-payers only, weighted by dividend stream, 491 holdings |

---

## 6. Bottom line

The quality factor is academically well-supported. The MSCI World Sector Neutral Quality Index is a diluted implementation of it — two of its three screens lack a documented premium, its premium sits mostly in a short leg a long-only fund can't access, and its defining feature (sector neutrality) halves whatever remains. Over its live decade it has underperformed plain MSCI World with no Sharpe improvement, ten times the turnover, and a higher fee.

The honest case for it today is valuation-based mean reversion, which is a forecast rather than a record. Anyone buying it should know they are buying the constrained version because the unconstrained one isn't listed in the UK, and should probably buy XDEQ rather than IWQU.

The general lesson generalises past this fund: **an index whose screens read like your investment thesis is not the same as an index that has worked.** Thesis-fit is a marketing property. Realised returns are the test.

---

## Verified vs uncertain

**High confidence:** all index-level returns and risk metrics (MSCI factsheets); fund-level returns and tracking (iShares factsheet); benchmark identity; index methodology; MSCI's 189bps vs 96bps sector-neutrality figure; Hsu et al. findings; TER and tracking differences.

**Gaps:** no published 10-year return or Sharpe for the fund itself (index used as proxy); no verified peak-to-trough 2022 USD drawdown for IWQU; 2026 YTD relative performance unresolved between USD and EUR data sources; the methodology document retrieved was the May 2022 version — a May 2025 revision exists but every direct link failed, so rule changes since cannot be ruled out; the ROE-mechanics critique in §3 is analytical inference from verified methodology rather than a located published critique.

---

## Sources

- MSCI — [World Sector Neutral Quality Index factsheet](https://www.msci.com/documents/10199/255599/msci-world-sector-neutral-quality-index-usd-net.pdf) · [World Quality Index factsheet](https://www.msci.com/documents/10199/255599/msci-world-quality-index.pdf) · [World Index factsheet](https://www.msci.com/documents/10199/255599/msci-world-index.pdf) · [Quality Indexes Methodology](https://www.msci.com/eqb/methodology/meth_docs/MSCI_Quality_Indexes_Methodology_May2022.pdf) · ["Quality Time: Understanding Factor Investing"](https://www.msci.com/documents/10199/4c5bd381-5b29-453e-ad73-6df24290a172)
- iShares — [IWQU product page](https://www.ishares.com/uk/individual/en/products/270054/ishares-msci-world-quality-factor-ucits-etf)
- [Asness, Frazzini & Pedersen — "Quality Minus Junk"](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2312432)
- [Hsu, Kalesnik & Kose — "What Is Quality?" (FAJ 2019)](https://www.researchaffiliates.com/publications/journal-papers/717-what-is-quality)
- [WEDGE Capital — "Reviewing the Quality Factor"](https://d1d5ya166a68mj.cloudfront.net/resources/202106_Quality_Factor.pdf)
- [J.P. Morgan Asset Management — Factor Views 2Q 2026](https://am.jpmorgan.com/us/en/asset-management/institutional/insights/portfolio-insights/asset-class-views/factor/)
- [Parametric — Factor Investing Endures Despite Tough 2025 for Quality](https://www.parametricportfolio.com/blog/factor-investing-despite-quality-stocks-tough-2025)
- justETF — [IWQU](https://www.justetf.com/uk/etf-profile.html?isin=IE00BP3QZ601) · [XDEQ](https://www.justetf.com/en/etf-profile.html?isin=IE00BL25JL35)
- trackingdifferences.com — [IWQU](https://www.trackingdifferences.com/ETF/ISIN/IE00BP3QZ601) · [XDEQ](https://www.trackingdifferences.com/ETF/ISIN/IE00BL25JL35)
- [Trading 212 Help Centre — FX fee](https://helpcentre.trading212.com/hc/en-us/articles/360018909758-What-is-the-FX-fee-Invest-Stocks-ISA)
