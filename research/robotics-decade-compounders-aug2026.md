# Robotics for the Next Decade — Where the Moats Actually Are
**Research date: 15 August 2026 · Cowork deep-dive (7 parallel research agents; all figures sourced, key claims double-checked) · Universe: anything buyable on Trading 212 (US/UK/EU main listings) · Companion to portfolio-register.md §2b and the exponential watchlist**

*Informational only, never buy/sell instructions. Decisions stay with Jude. Per wealth-plan rules, any individual-stock money is capped satellite money — see the flags in §8.*

---

## 1. Executive summary

You asked for the Eatons of robotics: vertically integrated picks-and-shovels compounders with hyperscaler-grade moats, backed by the right AI capital. After sweeping the component, compute, OEM, deployment and software layers, the honest headline is uncomfortable in a useful way:

1. **The purest robotics toll-booths are unbuyable on T212.** The reducer/actuator/vision franchises with Eaton-like economics are Tokyo-listed (Keyence, FANUC, Harmonic Drive, THK, Nabtesco, Nidec) or Shanghai-listed (Sanhua, Tuopu, Green Harmonic). No clean Western proxy captures them.
2. **China is commoditizing the mechanical layer.** Harmonic-reducer prices are down 30–40%; the Chinese share of that market roughly doubled in two years (15%→~38%); ~70% of Optimus Gen3 components are China-sourced. The "own the gears" thesis is being deflated in real time — the opposite of Eaton's dynamic in electrification.
3. **Where moats survive is where the part is NOT the commodity:** test (Teradyne), calibrated sensing (Novanta's ATI force/torque, Teledyne's FLIR), spec lock-in connectors (TE, Amphenol), geopolitically protected magnets (MP Materials), the surgical installed base (Intuitive), and the training/simulation compute stack (NVIDIA).
4. **The humanoid OEM layer is private.** Figure ($39B), Skild (>$14B), Physical Intelligence ($5.6B+), 1X (~$10B target), Apptronik ($5B) — none buyable. Tesla's Optimus had **zero verified production units** as of the July 2026 earnings call. The listed routes (Agility's SPAC, XPEV, the LSE-listed KOID ETF) are covered in §5.
5. **NVIDIA is the closest thing to "the hyperscaler of robotics"** (training→simulation→Jetson deployment loop, 2M+ developers), but robotics-adjacent revenue is ~1% of NVDA's P&L — you already own the option via both pies.
6. **Your proposed robotics sleeve mostly survives contact with the research.** ISRG's moat holds (the key single verdict — §7). TER is validated but you're buying an AI test cycle at 57x. AME is the weak link *as a robotics slot*. SYM's 5-Aug print resolves open item ③ with a "speculative at most, 4% cap" answer.
7. **Quantum: the 5-Aug verdict stands** — skip, or max one IONQ slot. IonQ's Q2 beat-and-raise strengthens the "if any, IonQ" leg but entry is now *worse* (price ~60% off July lows); IBM is not a quantum play ($1B cumulative quantum bookings vs $17.2B revenue per quarter); Rigetti at ~470x sales is a venture bet.
8. **SPCX: DCA at ~$140 is defensible** (≈ IPO price, first-and-largest lockup tranche absorbed, Q2 revenue +92%, Starlink subs doubled to 12M) — with eyes open: ~59x annualized revenue, launch and AI segments both loss-making, further lockup tranches into 2027. Keep the 8% cap.
9. **Watchlist fed:** five new names evaluated and benched (TDY 71, NOVT 67, AMBA 61, HSAI 57, RRX 45). None cleared the bar — the robotics rail now has its own standing finding, mirroring energy's: *the buyable names are fit-limited diversifieds; the pure plays are unbuyable or below bar.*
10. **None of this outranks the DCA flip.** Open item ⑤ (£360/mo still 100% pies, £0 VWRP) remains the single highest-value action available — worth more than any name on this list.

---

## 2. The lens: what "Eaton of robotics" actually requires

Eaton works in electrification because (a) electrical content per unit of GDP is rising for decades, (b) the product is spec-locked into installations with brutal switching costs, and (c) nobody is deflating switchgear prices 30% a year. Applying that test to robotics:

**Where the humanoid BOM value sits** (BofA, Mar 2026): linear actuators ~27%, rotary actuators ~24%, dexterous hands ~19%, controls ~10%, vision/sensing ~4%. Motion control is 40–60% of BOM by most teardowns. BOM cost is falling ~$35k (2025) → <$17k (2030) on unit forecasts of 20k (2025) → ~1.2M (2030) → ~10M (2035). So the biggest BOM prize (actuators/reducers) is exactly where Chinese cost-down is fiercest — big revenue pool, evaporating margin pool. The Eaton test fails there.

**It passes where physics meets lock-in:**

| Moat type | Why it survives cost-down | Buyable expression |
|---|---|---|
| Test & measurement | Every chip and every robot must be tested; duopoly (TER/Advantest); design-in switching costs | **TER** (held on watchlist, 88) |
| Calibrated force/torque + encoders | Calibration and certification create switching costs; not a commodity gear | **NOVT** (ATI) |
| IR / autonomy sensing | FLIR is a near-monopoly in defence/commercial infrared; drone war pulling demand | **TDY** |
| Connector spec lock-in | Designed into the harness; humanoid = free option on AI-datacenter core | **TEL, APH** |
| Rare-earth magnets | ~3.5kg NdFeB per humanoid; China 85–90% supply, export-restricted → the West pays a premium for MP's DoD-backed capacity | **MP** (commodity economics + political moat) |
| Surgical installed base | 11,710 systems, 80k+ trained surgeons, 76% recurring revenue | **ISRG** (held) |
| Training/sim compute | CUDA + Omniverse/Isaac + GR00T; 2M developers | **NVDA** (held, both pies) |

---

## 3. Layer-by-layer map

### 3a. Components (the picks-and-shovels layer)
- **Unbuyable toll-booths:** Harmonic Drive (~85% strain-wave share historically, now dual-sourced by Tesla with China's Green Harmonic; trailing P/E ~422), Nabtesco (~60% of RV reducers), THK (linear motion), Keyence (54% op margins — top score on your watchlist at 89), Nidec (Optimus motors). All Tokyo. Sanhua (linear-actuator Tier-1, reported $685M Optimus order) and Tuopu — Shanghai.
- **Buyable, evaluated today:** TDY 71, NOVT 67, RRX 45 (details §6 and the watchlist register). Also of note: **Moog** (reported Optimus precision-actuator supplier, but A&D is the P&L and it's doubled on that cycle), **Timken** (only scaled US harmonic-gearing supplier via Cone Drive; +98% in a year, upside largely priced), **Schaeffler** (Xetra; the most aggressive Western bearings-to-actuator pivot — Hexagon partnership, 1,000-robot deal with Humanoid — on an auto-supplier balance sheet), **TE/Amphenol** (humanoid connector lines as a free option; APH Q2 +55%).
- **The chokepoint nobody prices as robotics:** rare-earth magnets. **MP Materials** — DoD partnership, $500M Apple deal, $1.25B magnet campus. A geopolitical toll-booth rather than a business-quality one.

### 3b. Compute & semis (the "robot brain")
- **NVIDIA** owns training + simulation + premium edge inference (Jetson Thor GA Aug 2025; GR00T N2 due end-2026; Figure, Agility, Boston Dynamics, Amazon, Caterpillar, Medtronic all on the stack). But "Automotive" (where robot silicon sits) was **$2.3B of $215.9B FY26 revenue (~1.1%)**. Robotics reinforces the datacenter core; it does not diversify you. The edge socket is contestable: Tesla's AI5 (2027), Google's chip-agnostic Gemini Robotics 2 (demoed on Apptronik Apollo, Jul 2026), Qualcomm's Dragonwing with Figure as launch partner, Chinese domestic chips.
- **Non-redundant pure-ish plays:** **AMBA** (80% edge-AI revenue; NXP takeover talks reported 31 Jul–2 Aug 2026 — now event-driven, benched 61), **HSAI** (the only profitable lidar maker on earth; robotics lidar +138% YoY units; benched 57 — the ILMN/FSLR "curve commoditizes the enabler" risk is live), **Lattice** (per-joint/per-camera FPGA content, ~49x forward), **Infineon** (Xetra; deepest NVIDIA humanoid partnership on motion control/power — the quiet BOM winner among analog names), **Micron** (held in Bankers — humanoids carry ~10x the memory of an L2+ car per Micron's own framing).
- Lidar reality-check: Tesla/Figure are cameras-only; Omdia sees just ~400k humanoid lidar units by 2030. Lidar's robotics bull case is AMRs/industrial, not humanoids. Luminar's equity went to zero in April — the sector's memento mori.

### 3c. Humanoid OEMs & the AI capital map
Who the right money is backing (2024–26): **NVIDIA** → Figure, Skild, Field AI, Wayve (~$53B cumulative startup spree). **OpenAI** → 1X, Physical Intelligence, then split from Figure (Feb 2025, "we're going to be competitors") and relaunched an in-house robotics division (May 2026). **Google** → Apptronik ($935M raised, $5B val) + Gemini Robotics 2 + non-exclusive Boston Dynamics deal — the "Android of robotics" strategy. **Amazon** → Agility (early investor; Digit at GXO on the first humanoid RaaS contract), Covariant acqui-hire. **Bezos personally** → Figure, Physical Intelligence, Skild. **SoftBank** → Skild ($1.4B lead), ABB Robotics ($5.375B, closing H2 2026).

Deployment reality: Figure 02/03 at BMW Spartanburg (90k+ parts, 40 units on site), Agility 65k+ operating hours across nine sites, Apptronik at Mercedes. **Tesla Optimus: zero verified production units**; "volume production" language removed from the Q2 shareholder letter; Musk calls it "the hardest product to scale manufacturing that we've ever made." Hyundai/Boston Dynamics is the credible scaling story (production Atlas 2026, ~30k/yr capacity planned by 2028, 25k units committed across Hyundai/Kia plants) — but Hyundai is Korea-listed (unbuyable; there's an LSE GDR, HYUD, to check in-app if ever wanted).

Listed access: **TSLA** (held twice — the proposal already de-duplicates it), **Agility via Churchill Capital XI** (→ AGLT, ~$2.5B EV, closing end-2026: first US-listed pure humanoid OEM; ~$100M/yr burn, >$300M committed orders, no disclosed revenue — SPAC caution warranted), **XPEV ADR** (IRON humanoid mass production targeted end-2026), and **KOID** — KraneShares' humanoid/embodied-AI UCITS ETF, LSE-listed Oct 2025 (holds Tesla, NVIDIA, UBTech, Horizon Robotics, RoboSense): the only practical route to the Chinese OEMs that actually have paid orders (UBTech: Walker S2 in mass production, >RMB800M orders, Airbus deal). Check T212 carries it before relying on that.

### 3d. Deployed-today automation
- **SYM** — full verdict in §7 (open item ③).
- **AutoStore** (Oslo): the best pure-play economics in warehouse robotics (Q2 +43%, record backlog, new Amazon supply agreement) — **Oslo isn't on T212**. Noted and let go.
- **Rockwell**: the cleanest US factory-automation compounder (Q3 +10% organic, software/control margins 34.8%) — GDP+ quality, not exponential.
- **Zebra**: record Q2, +29% post-print — warehouse *digitization*, robotics is a rounding error.
- **Kion** (Xetra): Dematic is real (#1/#2 warehouse automation, +18% H1) on a low-margin forklift-cyclical group — value, not a compounder. **GXO/Jungheinrich**: pass. **Honeywell/ABB are both exiting** robotics (Intelligrated being sold; ABB Robotics → SoftBank).
- Japan giants (FANUC — on your watchlist at 81 via FANUY, but OTC = unbuyable; Yaskawa; Daifuku): what a decade holder misses is the installed-base service annuity; nearest listed cousins are TER (cobots) and SIE (factory software, already held).

### 3e. Software & simulation
No public company besides NVIDIA owns a robotics software toll-booth. The model layer (Physical Intelligence, Skild) and the observability layer (Foxglove — literally pitched as "Datadog of robotics") are private. Within listed names: **CDNS** (already on your watchlist, 78) bought Hexagon's MSC/Adams — the de-facto standard for robot motion simulation — explicitly "for Physical AI" (Feb 2026, $3.16B); **SNPS** (watchlist, 71) owns Ansys physics; **Siemens** (held) closed Altair and is co-building an "Industrial AI OS" with NVIDIA (first AI-driven adaptive factory launching 2026). Your existing positions already cover this layer about as well as a public-market investor can.

---

## 4. The froth ledger (names to ignore)

SERV (~55x sales, loses ~$20 per $1 of revenue, guide cut), Richtech RR (~82x sales, shrinking revenue), UMAC (~19x sales, tariff-momentum spike), ONDS (5 acquisitions in a quarter, $133M loss on $51M revenue), JOBY/ACHR (pre-revenue at ~53x hoped-for sales), NNDM (cash > market cap; a value trap, not a bargain). Anduril (~$100B raise talk) and Helsing ($18B) are real but private — if either IPOs, expect froth-zone pricing on day one.

---

## 5. The buyable decade shortlist, tiered

**Tier 1 — decade-compounder quality, buyable today:**

| Name | The case | The catch |
|---|---|---|
| **ISRG** (held, proposed 7%) | Moat survives (§7); 76% recurring revenue; cheapest forward multiple (~35x) in ~a decade | Procedure growth decelerating to ~13.5–15.5% |
| **TER** (proposed 6%; watchlist 88) | ATE duopoly + robot test + UR cobots; robotics turned (+33%, first $100M quarter) | You're buying the AI-test cycle at 57x after a ~4x run; robotics is only 8% of revenue |
| **TDY** (new; watchlist bench 71) | FLIR = IR toll-booth of the drone war; record quarters; ~31x forward, no froth | Conglomerate breadth; robotics/autonomy is a minority of revenue |
| **SIE** (held) | Factory software + automation + NVIDIA Industrial-AI OS; record orders, €132B backlog | Conglomerate dilution — already owned, no action |

**Tier 2 — quality with real robotics optionality (satellite-grade):**
**NOVT** (bench 67 — the purest T212-buyable humanoid-component play; ATI force/torque + first humanoid orders in Q2; ~105x trailing is the price of entry), **TEL/APH** (humanoid = free option on AI-datacenter connector franchises), **AXON** (bench 60→ fundamentals strengthening, counter-drone >$100M — a public-safety moat, not a robotics one), **MP** (geopolitical magnet chokepoint), **Infineon** (Xetra; humanoid BOM content via the NVIDIA partnership).

**Tier 3 — speculative / event-driven:**
**SYM** (§7), **HSAI** (bench 57), **AMBA** (bench 61; NXP bid pending), **AGLT** (when the Agility SPAC closes, end-2026 — watch, don't pre-commit), **KOID** (LSE ETF — the one-line answer to "how do I own the Chinese humanoid ramp without single-name risk").

---

## 6. Watchlist changes made today

Five names evaluated on the full company-health rubric v1.1 + thesis-fit tests and written to the register (engine-scored, no hand arithmetic): **TDY 71** (Strong; fit medium — fails core-not-adjacent), **NOVT 67** (fit medium; clearest promotion path: humanoid orders converting to production revenue), **AMBA 61** (fit medium; event-driven on the NXP talks), **HSAI 57** (fit medium; moat-on-curve unproven mid price-war), **RRX 45** (fit low; humanoid narrative outruns a 4%-growth, 3x-levered P&L). **None cleared the bar** — no changes to the list proper (TER 88 and FANUY 81 remain its robotics representation). SYM and AXON already carried their 5-Aug prints from the 7-Aug build; no re-score was due. A new standing finding was logged for the robotics rail (the §1.1–1.3 story), mirroring the energy rail's: an empty rail column doesn't mean the rail is wrong — it means the clean expressions are either already held (NVDA, MU, SIE, ETN-adjacent), unbuyable (Tokyo/Shanghai), or below bar.

Register + log committed; the daily 08:15 artifact refresh will pick the new bench up tomorrow morning.

---

## 7. The pie verdict (proposed §2b sleeve, slot by slot)

**ISRG 7% — keep. The moat survives the decade.** This was the single verdict that mattered most. Q2 2026 ([reported 16 Jul](https://isrg.intuitive.com/news-releases/news-release-details/intuitive-announces-second-quarter-earnings-6)): revenue $2.89B +19%, procedures +15%, installed base 11,710 (+12%), DV5 now the majority of placements, non-GAAP EPS $2.80. The competition finally arrived — J&J's Ottava got FDA de novo authorization on 22 Jul 2026, Medtronic's Hugo is cleared for urology — and the sell-side read (Stifel, J.P. Morgan) is "deliberate, phased, very modest share loss." 80k+ trained surgeons, 7-year system lifecycles and 76% recurring revenue mean rivals grow the market before they dent the base. China is being lost to MicroPort's Toumai — accept that (~mid-single-digit % of revenue). At ~35x forward (vs 45–70x historical) the derating you're sitting on (−23%) reads as entry opportunity, not thesis break. Watch procedure growth: below ~10% is the number that would actually kill it.

**TER 6% — keep, sized with eyes open.** The research validates it twice over (watchlist 88; robotics segment turned; humanoid angle via NVIDIA-accelerated UR). But be honest about what the slot owns: ~84% semi-test at 57x earnings after a monster run. It will draw down hard when the AI test cycle breathes. Fine at 6% satellite; don't let it creep.

**AME 7% — the weak link as a robotics slot; decide what the slot is for.** AMETEK is a fine compounder (record Q2, 37x), but the robotics story is thin: Haydon Kerk/Dunkermotoren are real yet small, automation is likely <15% of revenue, and no humanoid design wins are disclosed. Your own watchlist already called it "M&A compounder, not a curve" (benched 76, fit-limited). Options, decision yours: (a) keep AME and own it as *quality industrial compounding*, accepting the robotics label doesn't fit; (b) swap the slot to **TDY** (~31x forward, record quarters, drone-war IR toll-booth — the better *thesis* fit at a saner multiple than NOVT's ~105x); (c) split the difference and let the watchlist track NOVT for a future re-rate. On pure thesis-purity grounds the research leans (b); on business quality alone AME is unimpeachable.

**SYM 4% — open item ③ resolved: speculative at most, 4% is the ceiling, and skipping is equally defensible.** The 5-Aug print was fine on substance — revenue $720.8M +21.7% (beat), first meaningful GAAP profit ($55M), adj EBITDA doubled to $95M, backlog $22.5B — but EPS missed by 25%, the stock fell ~5% after hours, and the structural facts didn't move: >84% of revenue is Walmart, the backlog is mostly Walmart + a SoftBank-majority JV buying from itself, there's a 2024 restatement in the record, founder supermajority voting control, true float ~10–15% of economics, SoftBank actively selling, ~9.7x sales. That is not a decade-compounder profile; it's an option on SymMicro's ~400-system Walmart decision (~6 months out) and GreenBox third-party demand. If you want the option, 4% in the smallest slot is the right size. If you want the sleeve to be pure moats, fold the 4% into ISRG/TDY and let the watchlist bench (68) track it.

**SPCX 8% — proceed with the DCA, keep the cap.** Q2 (first public print, ~11 Aug): revenue $7.8B +92%, Starlink 12M subs (doubled YoY) at $4.3B revenue, adj EBITDA $3.5B, $14.1B contracted AI-cloud sales — against a $541M net loss, loss-making launch AND AI segments, and $18.4B of quarterly capex. At [$140](https://stockanalysis.com/stocks/spcx/) you're paying ≈ IPO ($135), 38% below the $225 post-IPO peak, and the first (largest) lockup tranche was absorbed 6 Aug — but further tranches unlock into 2027 (first tranche alone was 911.5M shares vs <280M float), so supply keeps coming: that's an argument *for* DCA over lump-sum, which is exactly your plan. Anchors: Morgan Stanley $300 / HSBC $115 / consensus ~$231. ~59x annualized revenue means the register's own words still apply — "cap the weight, priced for perfection." Mars-window outcomes (Nov–Dec 2026, Musk: "50/50") are the next binary.

**Quantum (open item ④) — verdict stands: skip, or max one IONQ slot funded by dropping FCX.** Since 5 Aug: IonQ Q2 (12 Aug) was a genuine beat-and-raise — revenue $80.1M +287%, FY26 guide raised to $280–290M, $3.0B cash, Anduril/DARPA/NRO deals — but adjusted EBITDA burned $120M *in the quarter* (the −$310–330M FY burn thesis intact), growth is heavily acquisition-assembled, and the price has rallied to ~$46 vs sub-$30 July lows, so the entry is worse than when you decided to skip. Rigetti: $5.1M quarterly revenue against a $6.3B cap (~470x sales) — that's a venture bet wearing a ticker. IBM: quantum is ~$1B *cumulative* bookings since 2017 vs $17.2B revenue *per quarter* — buying IBM is buying a struggling infrastructure/software business with a free quantum option, not a quantum play. Nothing here overturns your 5-Aug decision; the credible quantum programmes you already own via Bankers (GOOGL/MSFT/AMZN/NVDA-NVQLink) remain the cheap exposure.

**One optional addition to consider (not in the proposal): KOID (LSE)** as a single capped slot if you want the humanoid OEM ramp itself — it's the only buyable wrapper holding UBTech/Horizon/RoboSense alongside TSLA/NVDA. Trade-offs: thematic-ETF fee drag, index includes froth, and it overlaps NVDA/TSLA you already hold twice. Verify T212 carries it. This is the one way to own "the robots" rather than "the suppliers"; everything else in this report deliberately owns the suppliers.

---

## 8. Plan flags (the candour section)

- **Satellite cap:** every name here is satellite money. The plan says pies ≤£100/mo combined from September and ≤10–15% of the ISA. A 16-slot pie rebuild plus an SPCX DCA plus anything from this report all lives inside that cap — not on top of it.
- **The DCA flip (open item ⑤) is still undone** per the register: £360/mo is flowing 100% to pies, £0 to VWRP. Executing that flip is worth more than getting any slot in this report right. It's five minutes.
- **Still open:** ① exact T212 transfer figure, ② VWRP buy confirmation. If the VWRP buy has executed, the register needs updating.
- **Correlation honesty:** career (agentic AI), Bankers (mega-cap AI), Exp. Convergence (AI infra), robotics (physical AI), SPCX (AI segment is 33% of its revenue growth story) — these are one macro bet with different tickers. The robotics sleeve diversifies your *theme*, not your *risk*. VWRP is what diversifies your risk.
- **Execution note if the rebuild proceeds:** after it lands, holdings-tickers.json needs the update (+VWRP/SPCX/±AME/TER/±SYM/−TMO/−DE) so the Mini agents track the new set — and if TER graduates to a holding, it leaves the watchlist per the exit rules.

---

## 9. Key sources

Component layer: [BofA humanoid BOM](https://institute.bankofamerica.com/content/dam/transformation/physical-ai-part-2.pdf) · [Morgan Stanley Humanoid 100](https://advisor.morganstanley.com/john.howard/documents/field/j/jo/john-howard/The_Humanoid_100_-_Mapping_the_Humanoid_Robot_Value_Chain.pdf) · [China reducer share/pricing](https://nextfinancial.substack.com/p/the-joint-problem-who-owns-the-most) · [Optimus supplier teardown](https://optimusk.blog/blog/tesla-optimus-suppliers/) · [MP/DoD](https://mpmaterials.com/news/mp-materials-announces-transformational-public-private-partnership-with-the-department-of-defense-to-accelerate-u-s-rare-earth-magnet-independence/)
Compute: [NVIDIA Jetson Thor](https://nvidianews.nvidia.com/news/nvidia-blackwell-powered-jetson-thor-now-available-accelerating-the-age-of-general-robotics) · [NVIDIA FY26 results](https://nvidianews.nvidia.com/news/nvidia-announces-financial-results-for-fourth-quarter-and-fiscal-2026) · [Qualcomm robotics CES 2026](https://www.automate.org/robotics/news/ces-2026-qualcomm-targets-nvidia-jetson-with-new-robotics-developer-platform) · [AMBA/NXP talks](https://finance.yahoo.com/markets/stocks/articles/ambarella-stock-surges-reported-nxp-195814306.html) · [Hesai Q1 2026](https://www.globenewswire.com/news-release/2026/05/19/3297198/0/en/Hesai-Group-Reports-First-Quarter-2026-Unaudited-Financial-Results.html)
OEMs/capital: [Figure $39B round](https://www.prnewswire.com/news-releases/figure-exceeds-1b-in-series-c-funding-at-39b-post-money-valuation-302556936.html) · [Skild $14B](https://www.skild.ai/blogs/series-c) · [Optimus zero-production](https://www.techtimes.com/articles/321012/20260720/tesla-optimus-production-count-remains-zero-q2-earnings-call-looms-wednesday.htm) · [Agility SPAC filings](https://www.geekwire.com/2026/digit-maker-agility-robotics-to-go-public-in-2-5b-deal-heres-what-the-filings-say-about-its-finances/) · [Boston Dynamics production Atlas](https://www.automate.org/robotics/industry-insights/boston-dynamics-to-begin-production-on-redesigned-atlas-humanoid-in-2026) · [KOID LSE launch](https://www.globenewswire.com/news-release/2025/10/09/3163870/0/en/KraneShares-Global-Humanoid-Embodied-Intelligence-Index-UCITS-ETF-KOID-Launches-on-the-London-Stock-Exchange.html)
Deployed/surgical/defence: [Symbotic Q3 FY26](https://ir.symbotic.com/news-releases/news-release-details/symbotic-reports-third-quarter-fiscal-year-2026-results) · [SYM ownership 13D/A](https://www.stocktitan.net/sec-filings/SYM/schedule-13d-a-symbotic-inc-amended-major-shareholder-report-d08502ee43eb.html) · [Teradyne Q2 2026](https://investors.teradyne.com/news-events/press-releases/detail/445/teradyne-reports-second-quarter-2026-results) · [ISRG Q2 2026](https://isrg.intuitive.com/news-releases/news-release-details/intuitive-announces-second-quarter-earnings-6) · [Ottava FDA authorization](https://www.jnj.com/media-center/press-releases/johnson-johnson-receives-fda-market-authorization-in-the-u-s-for-its-ottava-robotic-surgical-system) · [Ottava analyst read](https://www.medtechdive.com/news/jj-gets-fda-authorization-for-ottava-robot-teeing-up-competition-with-int/825905/) · [Teledyne Q2 2026](https://www.stocktitan.net/sec-filings/TDY/8-k-teledyne-technologies-inc-reports-material-event-44d37125e0ab.html)
Software: [Cadence/Hexagon D&E close](https://www.cadence.com/en_US/home/company/newsroom/press-releases/pr/2026/cadence-completes-acquisition-of-hexagons-design-and-engineering.html) · [Siemens–NVIDIA Industrial AI OS](https://nvidianews.nvidia.com/news/siemens-and-nvidia-expand-partnership-industrial-ai-operating-system)
Refreshes: [IonQ Q2 2026](https://www.ionq.com/news/ionq-announces-record-second-quarter-2026-revenues-growing-287-yoy) · [Rigetti Q2 2026](https://www.stocktitan.net/news/RGTI/rigetti-computing-reports-second-quarter-2026-financial-i812eesegntu.html) · [IBM quantum materiality](https://thequantuminsider.com/2025/02/05/ibm-has-earned-1-billion-from-quantum-cnbc-reports/) · [SPCX Q2 8-K](https://www.sec.gov/Archives/edgar/data/1181412/000162828026052515/earningsreleaseq22608042.htm) · [SPCX lockup](https://www.cnbc.com/2026/08/06/spacex-faces-test-as-shares-unlock-allowing-early-investors-cash-out.html) · [SPCX price](https://stockanalysis.com/stocks/spcx/)

*Full per-company sourcing lives in the watchlist register entries. Generated by a 7-agent Cowork research sweep, 15 Aug 2026. This is a planning input, not financial advice.*
