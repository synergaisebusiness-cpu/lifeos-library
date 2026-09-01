# Lloyds — Knowledge Base

Everything known about Lloyds Banking Group as an organisation: structure, strategy, numbers, people,
systems, the graduate scheme, and the employment contract. **Reference material — read the section
you need, not the whole file.** The operational plan (what Jude studies and when) lives separately in
[lloyds-study.md]; this file is what that plan is built on.

Sources: Summer Welcome, 29 July 2026 (27 slides archived in `summer-welcome-2026-07-29/`); the
offer letter and Contract of Employment (`Grad-Offer-Letter-v7-20260310.pdf`); the Get Work Ready
onboarding briefing (`get-work-ready-2026-08-28/`); public record
research, 28 July 2026. Where something is inferred rather than stated, it says so.

## Index

- **Who they are** — Group structure (3 divisions, 5 business units) · Group Functions · Technology
  Strategy · the enterprise platform map · what a Platform is.
- **What they're doing with AI** — "AI for All" strategy · the Big Bets (incl. Agentic BI) · the
  value picture (£50m+ in 2025, £100m+ target 2026) · frontier-lab partnerships · the transformation
  stack (Platform 3.0, GCP, Vault, Athena, Prosper).
- **How they build and grow people** — the delivery model · upskilling and the AI Academy · why the
  scheme exists · the visibility machine (Data Awards, external comms).
- **The scheme itself** — scheme card · the DS&AI learner journey and the Cambridge Spark bootcamp
  in detail · tooling.
- **People** — keynote speakers and who to seek out.
- **The contract** — full read of the offer letter and Contract of Employment, including Clause 15
  (other employment), Clause 24 (IP), Clause 12.1 (the Qualification and its clawback).
- **Housekeeping** — what source documents exist and what is still missing.

## Team intel (public record, researched 2026-07-28)

- The lab's two halves are both publicly documented: **SaaS** = Power BI Copilot rollout (2025:
  "tens of thousands of dashboards" → conversational analytics across Finance/Marketing/HR; claimed
  32% faster time-to-insight, 58% more users getting correct answers; expanding via Fabric Data
  Agents in 2026) and **bespoke** = "Dialogue with Data" (DwD) — in-house text-to-SQL on GCP, the
  NPD workstream.
- **Sean Hughes (LM) co-presents the Copilot story at SQLBits 2026** (with Andrew Herman). His
  public vocabulary: executive backing, phased rollout, governance, trust/adoption. Speak that
  language even from NPD — "an agent people trusted enough to use" beats "an agent".
- DwD published findings: tested Claude 3.5 Sonnet / GPT-4o / Gemini / specialist SQL models;
  **80% exact-match ceiling broken by a semantic layer + schema enrichment → 86.1%**; named open
  problems: ambiguous natural-language questions, subjective ground truth, benchmark-vs-production
  gap; human-in-the-loop central. This is the team's technical frontier — the capstone should
  mirror it (semantic layer as first-class topic; eval measures the benchmark-vs-real-world gap).
- Big 10 Bet = one of Lloyds' flagship strategic bets → exec visibility by default.
- Skill decode of the NPD line: "AI Context" = context engineering (schema/semantic layer/RAG/
  memory in the window); "trade-offs" = cost·latency·accuracy, frontier-vs-small, prompt-vs-tune;
  "reliability" = evals, golden sets, guardrails; "observability" = tracing, cost monitoring,
  feedback loops; "etc" = LLMOps tail (prompt-injection/PII security, human-in-the-loop, CI for
  prompts/agents). Tech etc: BigQuery, semantic layers, RAG/embeddings, ADK/Agent Builder.

## Summer Welcome, 29 July 2026 — source material

Original slides archived at `library/lloyds/summer-welcome-2026-07-29/`. Everything below marked
"(Summer Welcome ... 29 Jul 2026)" is transcribed from these; go back to the images if any figure
needs checking.

`01-cohort-numbers` · `02-group-divisions` · `03-group-functions` · `04-keynote-speakers` ·
`05-ai-for-all` · `06-50m-value-pillars` · `07-impact-metrics` · `08-big-bets` (+ `08b` fullscreen)
· `09-scalable-delivery-model` · `10-upskilling`

Spoken remarks captured (not on slides): Katie Adams — "grads are at the heart of this strategy";
2026 target of **£100m+ of value**, "and that number will grow over the coming years".

## Group structure (Summer Welcome slide, 29 Jul 2026)

Three customer-facing divisions plus one horizontal:

- **Retail** — **CL** Consumer Lending (mortgages, credit cards, personal loans, motor finance) ·
  **CR** Consumer Relationships (current accounts, savings, mass affluent).
- **Insurance, Pensions & Investments** — **IP&I** (home/motor/pet insurance, protection, workplace
  and direct pensions, retirement, ready-made investments, sharedealing).
- **Commercial Banking** — **BCB** Business & Commercial (SMEs, business accounts/loans, card
  payments, working capital) · **CIB** Corporate & Institutional (large corporates, rates and FX
  risk, government/public sector).
- **GCOO** (Group Chief Operating Office) — runs Group operations, technology, security and
  infrastructure; **provides Platform teams to the Business Units and Group Functions.**

**Hypothesis (high confidence, confirm with Sean in week one):** the Agentic & AI Services Platform
lab sits under GCOO, i.e. the horizontal that serves the verticals rather than inside a business
unit. If true: (a) the GenBI "customers" are internal colleagues in CL/CR/IP&I/BCB/CIB, which
matches the Copilot rollout going to Finance/Marketing/HR; (b) the week-one question "which GenBI
pain point costs the most colleague-hours" must be aimed at a business unit, not at GCOO itself;
(c) the horizontal gives exposure across all three divisions — good for the rotation plan.

**Group Functions (second slide):** GCA Corporate Affairs (reputation, media, internal/external
comms) · GF Group Finance (financial planning, performance, reporting) · GA&CI Group Audit &
Conduct Investigations (independent oversight, audit, conduct) · L&S Legal & Secretariat
(governance and regulatory requirements) · P&P People & Places (HR, culture, workplaces, DE&I) ·
Risk (identifies, manages and reports risk — "keep the bank safe and resilient") · GSB Group
Sustainable Business. Structure resolves as **3 divisions containing 5 business units, plus 7 Group
Functions, with GCOO the technology horizontal serving both.**

**Two things this makes concrete.** First, **the governance path has a name: Risk**, with GA&CI for
independent audit and L&S for regulatory. Any model going to production travels that route — the
90-day arc's "learn the governance path" now has an owner to ask about, and it is the same
vocabulary Sean uses publicly (governance, trust, adoption). Second, **the GenBI users have names**:
the published Copilot rollout went to Finance, Marketing and HR — which on this slide are **GF,
GCA and P&P**. GF in particular (financial planning, performance and reporting) is exactly the
colleague-hours-heavy reporting work conversational analytics targets. Sharpen the week-one
question accordingly: *which Group Function or business unit has the most unmet GenBI demand, and
what does it cost them today?*

**Reading of the slide for the NIM checkpoint (21 Aug):** CR takes deposits, CL lends them out —
the spread between those two is net interest margin, the core of how the Group earns. IP&I is
largely fee and premium income rather than NIM. BCB/CIB do both, plus rates/FX. That single
paragraph is most of the bank-context L0 checkpoint arriving early and free.

**Rotation strategy made concrete:** the plan's "placement 2 = somewhere with £-measured impact"
now has named candidates — CL for credit risk and lending decisions, CR for deposits/pricing,
BCB/CIB for commercial and payments.

## "AI for All" — the Group AI strategy (Summer Welcome, 29 Jul 2026)

Stated framing: *"Reimagine our business, and enable customers and colleagues to fully embrace AI."*
Two halves — **reimagine** (AI applied to how the bank works) and **enable** (adoption and literacy
for customers *and colleagues*). GenBI, a Big 10 Bet, sits under this umbrella.

Why it matters for the plan: the second half puts colleague adoption at the level of stated Group
strategy, not as a nice-to-have. That is direct top-cover for the capstone's trust/eval framing —
"an agent people trusted enough to use" is not a personal preference, it is the Group's own
sentence. Use the phrase **"AI for All"** in week one: positioning GenBI as how AI for All shows up
in analytics places the work inside the Group narrative rather than as an isolated project. This is
precisely the commercial-framing edge described in "The edge" below.

## Big Bets — and a naming correction (Summer Welcome, 29 Jul 2026)

Three Big Bet groupings "which will move the dial for AI at LBG":

- **Customer Interactions** — Customer Super Agent · Contact Centre Reimagined.
- **Operations** — Agentic Operations · Fraud & Financial Crime · Intelligent Pricing & Risk
  Orchestration · Client Onboarding / KYC / ODD · Lending Origination & Credit Assist ·
  Relationship Manager & Sales Assist · Cyber Security.
- **Colleague Productivity** — Colleague Super Agent · SDLC & Engineering · **Agentic BI**.

**NAMING: the deck says "Agentic BI", not "GenBI".** The team email (Jul 2026) called the Big 10 Bet
GenBI; the Summer Welcome deck (29 Jul 2026) lists **Agentic BI** under Colleague Productivity.
Unclear whether this is a rename or two names in circulation — **use "Agentic BI" and confirm with
Sean in week one.** Using the current internal name from day one is free credibility; using a
superseded one is a small, avoidable tell. This file otherwise still says GenBI where it quotes the
original email — deliberately, so the two sources stay distinguishable.

**2026 target (spoken, Katie Adams): £100m+ of value in 2026, "and that number will grow over the
coming years."** A doubling of the 2025 £50m+, in the year Jude joins.

Three things that follow.

- **It calibrates what a credible win is worth.** £50m across 57 new use cases in 2025 is roughly
  **£0.9m of benefit per use case**. Hitting £100m at that rate needs ~114. So the plan's scorecard
  item — "ship ≥1 production agent, quantified for the CV" — should be aimed at something in the
  **high-six-figure to ~£1m** range. Not £20k (invisible), not £10m (not a graduate's first
  project). That is a target Jude could not have guessed and can now aim at deliberately.
- **The timing is unusually good.** Starting 3 Sept leaves four months of a year in which the Group
  is chasing a doubled target. Appetite for anything that adds measurable benefit will be high, and
  the benefit-attribution process will be running hot — which makes it *easier*, not harder, to get
  a number formally attributed to your work. Reinforces the priority of the week-one question about
  how benefit is calculated and signed off.
- **There is runway past 2026**, which matters for a two-year scheme with three placements.

**Placement-2 shopping list, now with official names.** The rotation plan wanted "somewhere with
£-measured impact (fraud/credit risk/payments)". The Operations bets name exactly that: **Fraud &
Financial Crime**, **Lending Origination & Credit Assist**, **Intelligent Pricing & Risk
Orchestration**. The instinct was right; these are the things to ask for by name. (KYC = Know Your
Customer; ODD = ongoing due diligence — the periodic re-checking of existing clients.)

**"Agentic Operations" leads the Operations list.** Agentic is the through-line across the whole
Group strategy, not a quirk of one lab — which means the discipline being built in this plan is
aimed at the direction the Group is already moving, and the capstone's vocabulary travels beyond
the immediate team.

**Colleague Productivity placement confirms the framing** from the value slide: Agentic BI is
colleague-facing and internal. Alongside it sit Colleague Super Agent and SDLC & Engineering.

## Frontier-lab partnerships (spoken, Summer Welcome 29 Jul 2026)

Lloyds gets **early access to tooling from Anthropic and Google as a trusted partner**, framed
around building securely. Google was already visible in the stack (Vertex AI, BigQuery, Gemini, and
the DwD work on GCP); **Anthropic is new information**, though the DwD article did report testing
Claude 3.5 Sonnet among the candidate models.

Three consequences.

- **Early access creates an evaluation need — which is exactly this plan's skillset.** If new models
  arrive before general release, somebody has to decide whether they are good enough and safe enough
  to put in front of colleagues. That is eval harnesses, golden sets, guardrails and the
  benchmark-versus-production gap: the capstone's entire syllabus, and Applied R&D's stated remit.
  **Week-one question: is there an internal process for evaluating new models, and who runs it?**
  A grad who can build an eval suite is scarce in a place that receives pre-release models.
- **Small curriculum change (recorded against GenAI L4 above):** do function calling once in Gemini
  and once in Claude. One extra hour, and it makes the skill provider-agnostic rather than
  SDK-specific.
- **CV angle.** "Worked with pre-release frontier tooling inside a regulated enterprise" is close to
  the exact scarcity this plan is aimed at — agent depth *plus* regulated context. Most people with
  frontier-model access do not have the regulatory half; most people in banks do not have the
  frontier half.

**Question worth asking rather than assuming:** what "early access" means in practice — which tools,
which teams, and whether an NPD graduate can actually use them.

## Transformation slide — the internal stack, named (29 Jul 2026)

**Classification note: this slide is marked "Limited."** Keep the archive inside LifeOS and do not
forward it. Also a live example of the data-classification concept in the 22 Aug governance session.

- **People:** +1,500 colleagues recruited into strategic hubs · **31,000+ in Data Summer School** ·
  22,000 completed PCF & JIRA training · 6,443 Time to Grow attendees · 10,496 Reboot learning hours.
- **Process:** transition to **Platform 3.0** (the named operating model) · standard new way of
  working · JIRA suite across platforms · **single CI/CD pipeline** · **Harness** migration.
- **Technology:** Merit migrated to **GCP** · 500 applications decommissioned · Broadcom Web
  Isolation · **unstructured data store launched** · implementation of **Vault**.
- **Customer outcomes:** change of name live · Black Horse website search · Trusted Party Alerts for
  vulnerable customers · Homes journey · Fraud Self-Serve (UK bank first) · deposits digitisation
  for BCB · ID&V in the IP&I mobile app · mobile-first lending for business bank accounts.

**Three bridges to the ladders.**

- **Vault is the real-world version of the Python L5 checkpoint** ("never hard-code a key"). In
  September secrets will come from Vault rather than a `.env` file — same principle, industrial
  plumbing. Mention it at the L5 session (10 Aug) so the habit is learned with the right destination
  in mind.
- **Single CI/CD pipeline + Harness** gives "CI for prompts/agents" (in the LLMOps skill decode
  above) a concrete home. Python L4 — tests, git, a repo — is the entry ticket to that world.
- **GCP confirmed as the platform**, which validates the Vertex/BigQuery/`google-genai` choice
  running through the GenAI ladder. The **unstructured data store** is where RAG-shaped work would
  live.

## What a Platform actually is — the org shape Jude joins (29 Jul 2026)

A Platform reports **jointly** to the **Group COO CIO** (technology line) and a **Business Unit
Leader** (business line). It is led by a **pair**: a **Technology Platform Lead** and a **Business
Platform Lead**. Beneath them sit repeated **Engineering Lead + Product Owner** pairs, each with
delivery teams, plus Platform support functions. Stated purpose: *"brings technology and business
experts closer together."*

**This is "The edge" made structural.** That section below argues Jude's asset is converging from
the commercial side toward a technical spine, in a lab whose product serves business users. This
slide shows the organisation is *designed* around that seam — every platform has a business half and
a technology half, and they are peers, not a hierarchy. Someone fluent in both is not a
nice-to-have in this model; they are what the model is built to need. **It also names a long-term
destination the plan never had: Business Platform Lead** — a role a Business & Management graduate
with real engineering depth is unusually well shaped for. Not a five-week goal; worth knowing it
exists.

**The Product Owner is where the £ line comes from.** The plan's central question — which pain point
costs the most colleague-hours — has an owner in this diagram. Engineering Leads know how; Product
Owners know what and why, and hold the business case. In week one, the Product Owner on Jude's
delivery team is a more valuable half-hour than almost anyone else. Add to the people list above.

**Two definitions of success, deliberately.** Reporting into both GCOO and a Business Unit Leader
means the work is judged technically *and* commercially. Confirms the earlier GCOO hypothesis while
correcting it: the lab is not purely a horizontal — it is jointly owned.

## The enterprise platform map — where the lab actually sits (29 Jul 2026)

Four layers. **Customers**: the five BUs + Group Functions. **Business Unit Aligned Platforms**:
CL — Credit Cards · Loans & Affordability · Financial Wellbeing · Home · Transport. CR — Colleague
Channels · Consumer Servicing & Engagement · Core Banking · Economic Crime Prevention · Everyday
Banking · Personalised Experiences & Communications · Segments & Propositions. IP&I — Digital
Waterfront · General Insurance · Heritage · Protection · Retirement · Accumulation · D2C Investments
· Data Centre of Excellence. BCB — Business Transaction Banking · Client Data & Analytics ·
**Commercial Lending** · Client Servicing & Engagement. CIB — Markets. **Enterprise Platforms**:
Finance · People · Credit · Prudential & Analytics · Risk Foundations · Payment Services · Modern
Workplace. **Enabling Platforms** (also aligned to Group COO): Enterprise Data Provisioning ·
Customer Data Services · **Analytics & AI Services** · API & Digital · ID & Authentication · Chief
Security Office · Public Cloud · Private Cloud · Core Infrastructure · Engineering · Digital
Frameworks.

**The lab is almost certainly "Analytics & AI Services", an Enabling Platform.** That upgrades the
earlier GCOO hypothesis from a guess to a named box on the enterprise map. Three consequences.

- **The customers are the other platforms, not "colleagues" in the abstract.** Enabling Platforms
  serve the BU-aligned and Enterprise platforms. So Agentic BI's users have names: **Client Data &
  Analytics** (BCB — an analytics platform, the most obvious first customer), **Finance**, **Credit**,
  **Prudential & Analytics**, **Risk Foundations**. The pain-point hunt now has a target list rather
  than a category.
- **Neighbouring enabling platforms are the dependencies.** **Enterprise Data Provisioning** and
  **Customer Data Services** sit upstream of anything Jude builds — a semantic layer has to plug into
  them. **Chief Security Office** is the guardrail gate. Learn these three names.
- **The CRE lending agent probably lives in Commercial Lending — Dominic Adams' platform.** This
  deck is his ("an Architecture Roadmap for the Commercial Lending Platform, part of BCB, serving all
  BCB and CIB clients"), and Commercial Lending is highlighted on the map. The "5 mins to process
  commercial real estate lending decisions using agentic AI" figure is very likely his. **He is in
  the meeting: he is the person to ask about it.**

Also noted: **Economic Crime Prevention** (CR) is a further placement-2 candidate alongside Fraud &
Financial Crime.

## Technology Strategy — where Data & AI actually sits (29 Jul 2026)

House diagram: **Technology Strategy** → **Tech & Data Action Plan** → six pillars — Resilience ·
Security · Simplification & Modernisation · **Data & AI** · Talent & Resourcing · Operating Model —
all resting on **Business Outcomes**.

- **Data & AI is one pillar of six, and Resilience and Security are listed before it.** Useful
  corrective: in a bank those two gate everything, which is precisely why 800+ models in production
  is impressive rather than routine. The capstone's guardrails session (27 Aug) is where this work
  meets the Security pillar — read-only credentials, allow-lists and injection defence are not
  polish, they are the entry fee. Saying so out loud in week one reads as sensible rather than naive.
- **Business Outcomes is the base everything rests on.** The 1 Sept business brief should therefore
  open with the outcome and the number, not the architecture. Semantic layers and eval harnesses are
  how it was achieved, not what it was for.
- **"Tech & Data Action Plan"** is a named programme worth knowing — the cohort was recruited across
  "Tech & Data pathways", so this is the umbrella. **Talent & Resourcing** appearing as a pillar is
  the third place today the grad scheme shows up at strategy level.

## The delivery model — "strong central enablement with decentralised delivery" (29 Jul 2026)

Hub and spoke: a central function builds capability, the business units deliver with it. Enabled by
three named levers:

- **Building Capability** — Upskilling · **Next Gen Talent** · Partnering.
- **Shared Best Practice** — **Forward Deployed AI Specialists** · **AI Pattern Store** ·
  **Delivery Playbooks** · **Communities of Practice**.
- **Applied R&D** — *"delivering solutions for system evaluation, guardrailing, agent design…"*

**Applied R&D's remit is, word for word, the capstone's syllabus.** System evaluation = the eval
harness (28 Aug). Guardrailing = read-only, allow-lists, injection (27 Aug). Agent design = the
whole build. This is the strongest evidence yet that the plan is aimed correctly: the capstone is
not an approximation of the job, it is a miniature of a named Group function. Find out in week one
whether Applied R&D is a team with a door on it, and if so, get in front of it.

**"Next Gen Talent" is a named enabler of the delivery model** — and it is the same name the offer
and team email came from. That is the structural version of "grads are at the heart of this
strategy", and it is much better evidence than the spoken line: the grad scheme is listed as one of
three levers for scaling AI delivery, not as HR overhead.

**Two pieces of free credibility.** (1) **AI Pattern Store** — asking "is there a pattern for this
already?" before building sounds like someone a year in; contributing one later is high-leverage
and visible. (2) **Communities of Practice** — join in week one, it is the cheapest network in the
building.

**"Forward Deployed AI Specialists"** is the mechanism connecting the centre to the business units —
central specialists embedded where delivery happens. Worth asking about as a career shape: it is
the role that sees the £-measured problems up close, which is exactly what placement 2 is for.

## Upskilling — the internal training track (29 Jul 2026)

Three personas: **Leaders** (Leading with AI for the SLT; **AI Ninjas** = reverse mentoring, AI
experts mapped to Exec), **Practitioners** — Jude — and **All Colleagues** (AI tools for personal
productivity). Under Practitioners:

- **Next Generation Talent** — *"deliver AI talent via our graduate and apprentice schemes,
  **injecting AI skills into Business Units**."*
- **Community of Practice** — *"**structured job families, skills and proficiency levels**. An
  engaged practitioner community."*
- **AI Academy**, Practitioner stream — *"**accredited** Builder/Enabler persona, delivering
  technical and hands-on training aimed at developing AI / agentic systems."*
- **Flagship AI learning interventions** — targeted initiatives for priority roles, e.g. an
  **AI summer school**.

**Three consequences.**

1. **"Injecting AI skills into Business Units" is the stated purpose of the grad scheme.** Jude is
   not there primarily to be trained; he is the mechanism by which central capability reaches the
   business units. That fits the central-enablement/decentralised-delivery model exactly, and it
   reframes the rotations: each placement is a capability transfer, not a tour.
2. **There is already an official ladder.** "Structured job families, skills and proficiency levels"
   is a formal skills framework — the institutional version of the L0–L5 ladders in this file.
   **Week-one action: obtain it and map the ladders onto it**, so progression is aimed at the
   framework the bank actually promotes against rather than at a home-made proxy.
3. **The AI Academy Builder/Enabler persona is *accredited*** — an internal credential aimed
   specifically at building agentic systems. **This must be understood before committing to the
   Stanford January cohort.** The plan currently reads: professional qualification (offer letter) →
   Ng Coursera bridge → XCS229 in Jan, with "while a course runs, the course IS the 15 h/wk study
   plan". If AI Academy accreditation, the professional qualification, or an AI summer school lands
   in the same window, that is a direct collision. **Do not commit to the January cohort until the
   internal training calendar is known.** Week-one question set: how do AI Academy accreditation,
   the scheme's professional qualification, the Google Cloud certs and the Stanford funding relate
   to one another, and what lands when?

**AI Ninjas** (reverse mentoring, experts mapped to Exec) is worth knowing about as a visibility
route — the plan already values the exec exposure that comes with a Big Bet. Probably aimed at
established experts rather than grads; worth asking what qualifies someone.

## The value picture — "£50m+ of benefit with Gen AI in 2025" (Summer Welcome, 29 Jul 2026)

Five value pillars, with the Group's own example use cases:

| Pillar | What it is | Named example |
|---|---|---|
| Customer Interactions | GenAI to improve customer experience | In-app search, awarded "Best AI use in Finance" |
| Customer Operations | Back-office efficiency | Complaints handling and automation |
| Frontline & RM Support | Help colleagues meet customer needs | Knowledge management tool, **>20k colleagues** |
| **Colleague Assistants** | **Interfaces giving colleagues easy access to information** | HR assistant, group-wide |
| Engineering Support | Faster, more modern code | **~5k engineers** on GitHub Copilot |

**The single most useful fact here: the Group already measures GenAI benefit in £ and publishes the
number.** That means there is an existing method for attributing and signing off value — so the CV
line "built X → saved £Y → adopted by Z" does not need a home-made measurement. **Week-one question,
high priority: how is the £50m calculated, who signs a benefit off, and what evidence does a claim
need?** Plug into that machine rather than inventing one; a number the Group's own process blessed
is worth more than one Jude computed.

**Capstone framing:** conversational analytics sits under **Colleague Assistants** — "interfaces to
give colleagues easy access to information" is a text-to-SQL agent described in the Group's own
words. Frame the capstone and the 1-page business brief (1 Sept session) in these pillars and in
these units: £ benefit plus colleague adoption counts. Scale expectations are visible too — >20k
colleagues on the knowledge tool, ~5k engineers on Copilot.

**Scale and named systems (second value slide).** 800+ AI models in production across the Group ·
57 new GenAI use cases into production in 2025 (~one a week) · **Athena**, the knowledge management
tool, used by 30,000 customer-facing colleagues · **Prosper**, the HR solution, 4,000 working days
saved · 97% active usage of Microsoft Copilot · 4m LLM-enabled in-app searches per month · 11,000
lines of legacy code converted via GitHub Copilot · 1 min to examine 1,000+ audits via a GenAI
chatbot · **5 mins to process commercial real estate lending decisions using agentic AI.**

- **Learn the proper nouns before day one: Athena and Prosper.** Cheap credibility, and Athena
  (colleague-facing information retrieval at scale) is the closest existing analogue to the
  capstone.
- **The CRE lending agent is the template for Jude's own CV line** — agentic AI, in lending, in
  production, with a before/after time metric, in exactly the placement-2 territory the rotation
  plan targets. Week-one action: find out who built it and ask to see it.
- **How value is actually expressed here — and what it changes about the eval harness.** Every
  figure is either time-to-complete (1 min, 5 mins), working days saved (4,000), or adoption
  (30,000 colleagues, 97%, 4m searches/month). So the £50m is built from *time saved × people ×
  rate*. **The eval design (28 Aug) currently measures execution accuracy, hallucination/refusal,
  latency and £/query — it is missing the metric the bank actually converts into money: time-to-
  answer versus the manual baseline.** Add to the golden set: for each question, how long would an
  analyst take to answer it by hand? That single column is what turns "86% accurate" into "£X".

**"Grads are at the heart of this strategy" (Katie Adams, spoken).** Taken honestly: it is a welcome
event and that is a thing said at welcome events — but it is consistent with a 1-in-202 selection
rate, so treat it as genuine *intent* rather than a guarantee of access. What converts the sentence
into something true for Jude specifically is a quantified win inside the benefit process above.
That is what the plan is already aimed at; this slide confirms the aim, it does not shorten the
distance.

## People to know (Summer Welcome keynotes, 29 Jul 2026)

- **Katie Adams — Head of AI & Data Culture.** (Teams display name shows her under a truncated
  "Chief Data & …" org — likely the Chief Data & Analytics Office. Confirm rather than assume.) Owns adoption and data literacy across the Group.
  This is the *trust/adoption* half of GenBI, and it is the exact vocabulary Sean Hughes uses
  publicly. The capstone's framing — "an agent people trusted enough to use" — is her subject.
  Highest-value keynote for this plan.
- **Dominic Adams — Lending & Working Capital Technology Platform Lead.** A Platform lead in the
  GCOO horizontal serving Consumer Lending and BCB working capital — i.e. the structural analogue
  of Jude's own role, in the exact territory the rotation plan names for placement 2 (£-measured
  impact: credit risk, lending, payments). Useful model for how a platform team engages business
  units and gets impact measured.
- Questions to carry: how does a platform team prove value to the business unit it serves; how is
  adoption measured for an AI tool once it ships.
- **Dominic Adams' "My First Day" talk (29 Jul):** overwhelmed by jargon and new terminology;
  worried about making mistakes and fitting in; sent an email to the wrong group; realised everyone
  feels this at first. Spoken: *"as you join, don't be afraid of this stuff."* Filed as evidence,
  not comfort — a senior Platform Lead naming the same feelings the ladder system was built to
  treat. Note that jargon, the first thing he names, is the one Jude is already actively solving:
  Agentic BI, Athena, Prosper, Applied R&D, AI Pattern Store, Forward Deployed AI Specialists,
  KYC/ODD and the five business units were all unknown this morning.

**TIME-SENSITIVE — spotted on Katie Adams' video background, 29 Jul:** *"Summer School is back!
Hackathon registrations now open."* This is the "flagship AI learning intervention / AI summer
school" from the upskilling slide, and registration is open **now**, before the 3 Sept start date.
A hackathon is the fastest route to a visible, quantified artefact with colleagues who already work
there. **Action: ask Next Generation Talent whether September joiners can register or attend.**
Worst case is a no; best case is a built thing and a network before day one.

## Tooling — confirmed in the Welcome Q&A (29 Jul 2026)

Question asked: *is GitHub Copilot available for Data Science and AI graduates, and are other tools
such as Claude available?* Answer: **"yes, we have access to a VS Code extension with all LLMs."**

- **Editor decision made: VS Code**, set up at Python L2 on 6 Aug. Same environment as September.
- **An internal multi-model gateway is how a regulated bank grants model access safely** — routed,
  logged, controlled, nothing leaving the perimeter. Worth understanding as an example for the
  governance session (22 Aug), and it explains how "early access from Anthropic and Google" reaches
  an engineer's desk in practice.
- **It makes the trade-offs session (29 Aug) immediately practical rather than theoretical.** If one
  extension exposes several models, choosing between them on cost, latency and accuracy is a daily
  decision from week one, not an abstract topic. Reinforces doing GenAI L4 in both Gemini and Claude.

## The DS&AI Learner Journey — full detail (29 Jul 2026, "dates indicative")

**Launch & set-up, 3–15 Sept.** 3 Sept day 1 welcome · **4 Sept IT onboarding + "How a bank
works"** · w/c 7 Sept: IT mop-up, **scheme sponsor welcome and Q&A**, data management scheme
overview, self-learning Microsoft packages, **"ask us anything"**, **performance management**,
wellbeing & neurodiversity · 15 Sept activation event.

**Bootcamp, 21 Sept – 13 Nov, delivered by CAMBRIDGE SPARK** — "hands-on applied learning,
specialist deep dives".

**Additional data sessions, 17 Nov – 11 Dec.** 17 Nov **Skills Based Organisation** · 18 Nov
**Hype to Impact: AI-ready organisation** · 19 Nov Networks. *Capability development:* 20 Nov
**Product Management for AI** · 27 Nov **Agentic Systems & Orchestration** · 4 Dec **ML in
Production** · 11 Dec **Software Engineering for Data Scientists**.

### What Cambridge Spark bootcamps actually cover (researched 29 Jul)

Their published bespoke-enterprise curriculum: Python programming and machine learning · exploratory
data analysis · supervised and unsupervised ML · model building (regression, classification) ·
explainable AI · **SQL and database management** · big data and advanced analytics · **statistical
methods and probability** · data visualisation and storytelling · **software engineering practices**
· time series. Eight weeks, blended (live virtual, in-person tutor-supported, self-directed),
assessed continuously via their EDUKATE.AI platform with work-based projects.

**CORRECTED 29 Jul — see the actual 2026 syllabus below.** The generic curriculum above led to a
confident and wrong conclusion, recorded here rather than deleted: it said the bootcamp "contains no
agents, no LLM engineering, no evals, no guardrails" and that Jude's territory would be *orthogonal*
to it. **The real Lloyds 2026 syllabus covers all of it.** Lesson for this file: a provider's
marketing page is not the client's actual programme.

- **The ladders overlap with the foundations, and that is the point.** Python, SQL, statistics and
  software engineering practices are all in the bootcamp. Arriving with Py L5 / SQL L5 climbed means
  spending those eight weeks *extending* rather than surviving, in a cohort of ~90 with wildly
  varied starting points.
- **The Andrew Ng bridge is very likely redundant.** Supervised/unsupervised ML, regression and
  classification are the Ng ML Specialization's content, delivered here in work hours and funded.
  Phase B should probably drop the Coursera bridge and go bootcamp → Stanford. Confirm the syllabus
  in September before deciding.
- **New ground Jude will meet fresh:** time series, explainable AI, unsupervised methods. Not in the
  pre-start plan and no need to add them — better met in a taught setting.

### THE ACTUAL 2026 BOOTCAMP SYLLABUS (slide, 29 Jul) — supersedes the generic version above

Preceded by **introduction and pre-bootcamp online learning**. Eight modules, one per week, each
with a **Group Assignment Day**; **tutor office-hours support every week**; a **Group Capstone
Project** running throughout and presented in week 8.

| Wk | Module | |
|---|---|---|
| 1 | **Foundations & Product-led thinking** | *new for 2026* |
| 2 | Foundations of Machine Learning | |
| 3 | **Ensembles & Model Tuning** | *new* |
| 4 | Neural Networks and Language Models | *updated* |
| 5 | **LLMs: customisation, managing state & RAG** | *new* |
| 6 | **Agentic AI** | *new* |
| 7 | Responsible AI | |
| 8 | **Production Engineering & Capstone** | *new* |

**What this changes.**

- **Modules 5–8 are this plan's territory, taught directly.** LLM customisation and RAG, agentic AI,
  responsible AI (guardrails and governance) and production engineering. The pre-start work is
  therefore a **head start**, not an orthogonal specialism — a less exotic claim but a more useful
  position, because it lands exactly where the programme is heading.
- **The bootcamp ends with a GROUP capstone project, presented in week 8 (~13 Nov).** The person who
  has already built an agentic text-to-SQL system end to end, with evals, is the natural technical
  lead of that group — in front of tutors and the cohort. **That is the real return on August**, and
  it is a bigger stage than showing Sean a repo in September. Plan for it.
- **Module 1 is "Foundations & Product-led thinking"** — product judgement taught as the foundation,
  before any ML. The commercial half of "The edge" is module one of the syllabus.
- **Module 7 Responsible AI ≈ the 27 Aug guardrails session**; **module 8 production engineering ≈
  the 31 Aug packaging and observability work.** Direct preparation, not adjacent.
- **New ground the ladders do not cover:** foundations of ML, ensembles and model tuning, neural
  networks. Complementary rather than overlapping — no need to add them pre-start; better met taught.
- **Pre-bootcamp online learning exists.** Ask when access opens — if it lands in the 3–21 Sept
  window it should be folded into that plan.
- **Weekly tutor office hours and group assignment days** — support is structured in, which is
  relevant context for the Clause 12.1 anxiety above.

### Bootcamp week 1, in detail (slide 29 Jul; "representative… subject to change")

**Format:** Mon–Thu **virtual** — live lectures 09:30–12:30 with expert trainers and tutors, then
self-study exercises and assignments 13:30–17:00 with online tutor support. **Friday is an in-office
day at the regional hubs with live tutor support.**

**Week 1 content.** Mon AM: intro to product-led AI development and the product life cycle · SDLC ·
architectural thinking · **responsible data/AI and the regulatory environment** · intro to Git.
Mon PM: Git practical, essential and advanced Git. Tue AM: **intermediate SQL, advanced SQL**.
Tue PM: relational databases, optimising queries. Wed AM: NoSQL — key-value, wide column,
document-oriented, graph · **intro to vector DBs**. Wed PM: **"mobbing" session with the previous
cohort**. Thu AM: document-oriented databases. Thu PM: SQL in the real world · data modelling and
E–R diagrams. **Fri: tutor-led assignments + CAPSTONE KICK-OFF — team formation, problem scoping,
initial product vision, source data from DB.**

**The date that actually matters is Friday 25 September, not week 8.** The group capstone kicks off
on day five with **team formation and problem scoping**, and runs the full eight weeks. Informal
leadership gets allocated in that room. Walking in having already built an end-to-end agentic system
over a real database — with a semantic layer and an eval harness — is unusual authority at exactly
the moment scope and roles are decided. Everything in August points here.

**Week 1 is SQL and Git — i.e. this plan's drills and Python L4.** "Intermediate SQL, advanced SQL"
in a single Tuesday is the SQL ladder L1–L4 compressed; Jude will have spent five weeks on it. Same
for Git on the Monday. Arriving with SQL L5 and a GitHub repo makes week 1 consolidation rather than
catch-up, and frees attention for the capstone scoping on the Friday.

**Also worth noting.** Monday's "responsible data/AI and the regulatory environment you're building
in" is what the 22 Aug governance session prepares. **Wednesday's mobbing session with the previous
cohort is an intelligence opportunity** — they have done placements, know which teams are good and
which pain points are real; ask them, not just the tutors. And **new ground**: NoSQL, document
databases, vector DBs and E–R modelling are not in the pre-start plan; vector DBs connect forward to
module 5's RAG.

**Jude's note (29 Jul): the group capstone is to "build models to a specific use case."** Not
identical to the personal capstone (agentic text-to-SQL), so do not overclaim — but problem scoping,
sourcing data from a database, evaluation and production engineering all transfer directly.

### EDUKATE.AI — the platform, and why it matters more than it looks (29 Jul)

Cambridge Spark's learning environment: browser-based, all technologies pre-installed, no downloads.
24/7 AI-powered feedback on code and explanations of mistakes. Industry-simulated environment with
sample datasets specific to the field. Knowledge Base forum for peer learning. 20,000+ users,
1,000,000+ code submissions; CogX 2023 Best AI Education Tool.

**The screenshot is the interesting part.** A submission gets an **overall score as a percentage**,
a two-stage pipeline — **Validation → Evaluation** — and a panel of individual checks ("checks that
division…", "checks that floor…", "checks that remainder…") each marked pass, *Issues* or *Not
Implemented*.

**That is an eval harness.** Golden set of cases, automated scoring, per-case pass/fail, one headline
accuracy number. Structurally identical to what the capstone is building in the last week of August —
except KATE evaluates a student's Python and the capstone evaluates a model's SQL. Two consequences:
Jude will spend eight weeks experiencing from the inside the exact mechanism he is constructing; and
it hands him vocabulary for tutors and teammates — *"same idea as KATE's evaluation checks, applied
to model output instead of student code."* Note the Validation/Evaluation split too: it mirrors the
distinction between *did the SQL run* and *did it return the right rows*.

**Practical.** The environment is cloud-based with nothing to install, so the local setup (uv, VS
Code, Python 3.13) is for Jude's own work, not a bootcamp dependency — no install fights in week one.
Continuous formative feedback also means standing is visible daily rather than at an exam, which is
the honest counterweight to the Clause 12.1 anxiety above. A 25% first score appears in Cambridge
Spark's own screenshot: low first submissions are the norm, the loop is iterative.

**ANSWERED (slide, 29 Jul): EDUKATE login details arrive in early September.** The pre-learning
materials then cover *"core coding **and mathematical** concepts"* and **must be completed by the
first full programme week, 21 September.**

- **Mathematics is explicitly examinable ground before the bootcamp starts.** This is the clearest
  possible validation of promoting maths to a full L0–L5 ladder starting in July rather than
  September — and it now has a real deadline rather than an abstract Stanford-prerequisite one.
- **Note the word "revisiting".** It assumes prior exposure. For a Business & Management graduate,
  "revisiting" would have meant "meeting for the first time, at speed, during onboarding week."
  Starting eight weeks early converts that into revision, which is exactly what it is supposed to be.
- **The 3–21 Sept window now has mandatory homework in it**, so it is not purely capstone-showcase
  and people time. Arriving with Python L5, SQL L5 and maths L0–L2 done should make the pre-learning
  quick — which is what buys the window back for the things that actually differentiate.

### "Look at regression and classification" (Cambridge Spark, spoken 29 Jul)

Direct pre-learning guidance, and it names ground **this plan does not currently cover at all**. The
four ladders are Python, SQL, GenAI/agents and maths; supervised ML was deliberately deferred to the
bootcamp and Phase B. Regression and classification are bootcamp modules 2–3, i.e. weeks 2–3.

**Recommendation: do not add a fifth ladder.** The plan is already at ~24.5 h/wk and the capstone is
the differentiator; ML added now would come out of it. Two cheaper moves instead.

1. **Re-aim the maths ladder at regression — costs nothing, because it was already going there.**
   L3's checkpoint is "explain gradient descent in plain English", which *is* how a regression line
   gets fitted. L1's variance work underpins squared error. Both checkpoints amended above to land on
   regression rather than float free of it. This turns the maths ladder from prerequisite-chasing
   into direct preparation for module 2.
2. **Let the EDUKATE pre-learning be the vehicle.** It arrives early September, is scoped by the
   people teaching the modules, and is the authoritative version of exactly this instruction. Doing
   a home-made version in August risks preparing the wrong thing.

**If Jude wants a taste before September, make it conceptual, not code:** what regression predicts
(a number) versus classification (a category); line of best fit and why squared error; logistic
regression for yes/no; train/test split and overfitting; accuracy, precision, recall and the
confusion matrix. Half a session, no implementation — coding it before the maths lands would be
cargo-cult. Reconsider properly once the pre-learning materials are in hand.

### The actual entry bar (Cambridge Spark, spoken 29 Jul)

*"Brush up on basic coding — be comfortable with key basic syntax, simple functions and methods, and
you'll be at the level you need to start the programme."*

**That is roughly Python L0 plus a little of L1 — a bar Jude will clear by mid-August, not
September.** L0.1 was taught on 29 July; control flow and functions follow on the 30th and 31st. The
anxiety about arriving behind can come down accordingly: the programme is designed to start from
here.

**But it reframes the ladder, and the distinction is worth holding.** Everything from L2 upward is
not entry-critical — it is capstone-critical. Two different bars:

- **L0–L1 (syntax, functions, methods, lists/dicts): "don't drown."** Satisfied by mid-August.
- **L2 (imports, virtual envs) and L5 (APIs, JSON, secrets): capstone-critical.** Without these the
  agent cannot be built at all, and the capstone is the entire differentiator.
- **L3 (type hints, dataclasses) and L4 (pytest, git): the professionalism layer.** Genuinely
  valuable and the right thing to show, but the **first candidates to compress** if August tightens.

**Revised cut order** (supersedes the one in "Honest flags" below): fewer golden questions →
platform-literacy read → compress Python L3/L4 → Sunday build blocks. **Never the eval harness.**

**The important caveat, stated plainly.** "The level you need to start the programme" is not the same
bar as the one Jude is actually aiming at. Starting the programme is a low bar by design — a cohort
of ~90 from mixed backgrounds. **Walking into capstone team formation on Friday 25 September with a
working agentic system is a completely different bar**, and nothing said today lowers it. The entry
requirement is permission to relax about drowning, not about the goal.

**It also validates the pace change made this morning.** If the entry bar is genuine comfort with
basics, then one concept per session with real checkpoints is exactly right. Depth on the basics
beats breadth across syntax you half-recognise.

### What the group capstone actually is (Jude, 29 Jul)

**Lloyds provides an example dataset and asks the cohort to create an approach meeting a specific
criterion.** Three consequences worth planning around.

- **The data is given, so data-finding is not the challenge — the approach is.** The deliverable is
  design and judgement: what the criterion actually means, whether the data is fit for purpose, what
  the simplest thing that could work is, and how anyone will know if it worked. That is LBG's own
  *foundational* rung ("understand the data needs and if fit for purpose") and it is a
  business-judgement task, not a coding one.
- **Module 1, "Foundations & Product-led thinking", is therefore the load-bearing week for the
  capstone — not the ML weeks.** And the kick-off is that Friday, 25 Sept.
- **The likely differentiator is the eval instinct, again.** Most teams will build something and
  report accuracy at the end. A team that defines success numerically *before* building, checks the
  data against the criterion, and measures the gap between benchmark and messy reality will look
  different — and Jude will have spent late August doing exactly that.

**Cheap preparation that is not over-preparation:** arrive with a repeatable set of scoping
*questions*, not a framework. What does the criterion actually mean, and how will it be judged? What
does success look like as a number? Is this data fit for that purpose, and how would we know? What
is the simplest thing that could work? How will we evaluate it? What would make this fail quietly?

**Honest caution.** In a team-formation room, someone who arrives with a rigid methodology and tries
to impose it reads as overbearing and gets ignored. Someone who asks the sharpest question in the
first ten minutes ends up leading by default. **Bring the questions, not the answers.**

### What the weekly Group Assignment Days are (Jude, 29 Jul)

Practical, hands-on, one per week. Machine learning weeks are coding; AI weeks vary — prompting
challenges and similar. Geared around doing rather than writing.

- **Practical and timed rewards fluency, not knowledge.** Which is precisely what 36 days of daily
  drills buys: SQL you can write without stopping to think beats SQL you can reason about slowly.
  Second strong validation of the drill structure today.
- **Know where to lead and where not to.** Weeks 2–3 are classical ML coding — ground the pre-start
  plan does not cover, where Jude will be at cohort level. Weeks 5–6 (LLMs, RAG, agentic AI) are
  where he should be visibly ahead. **Trying to lead every week would be exhausting and would read
  badly.** Being a good teammate in weeks 2–3, and letting people who are strong there lead, buys
  the credit that makes leading weeks 5–6 welcome rather than resented.
- **Git competence is social capital in group coding.** Being the person who unpicks a merge conflict
  at 4pm is disproportionately appreciated and costs nothing to prepare. Python L4 (8 Aug) is worth
  more than its position on the ladder suggests.
- **Prompting challenges map straight onto GenAI L1** (12 Aug) — the checkpoint is already "same
  question, three prompts, explain why the outputs differ".

### Calendar consequences

- **"How a bank works" is day 2 (4 Sept)** — the 21 Aug bank-context session is direct priming for
  it. Turn up already knowing NIM.
- **The scheme sponsor Q&A and "ask us anything" (w/c 7 Sept) are the venues** for the questions
  held for week one. Prepare them properly rather than improvising.
- **The performance management session (w/c 7 Sept) is how objectives get set** — the mechanism the
  entire quantified-win plan depends on. Ask directly whether a delivered, attributed benefit can be
  a formal objective.
- **17 Nov "Skills Based Organisation" delivers the official skills framework** — the job families
  and proficiency levels flagged earlier. It arrives; no need to chase it.
- **27 Nov "Agentic Systems & Orchestration" is where Jude's world shows up on the curriculum.**
  By then he should have built one, twice.

## The visibility gap — and the machine that closes it (29 Jul 2026)

The Data Culture Engine slide states two goals: **(1) become the most data-literate bank in the
world, (2) rank as a Top 10 Data & Analytics employer of choice.** Intake routes (graduate schemes,
apprenticeships, T-levels, industrial placements, schools engagement, talent partnerships, colleague
reskilling, TDR) converge through a **Single Hiring Mechanism** into a data-literate workforce, whose
outputs are **Business Data Literacy · Practitioner Data Capability · Data Communities**. Along the
bottom: Data & Analytics Culture Maturity · Culture Adoption · Helping Britain Prosper · **Data
Awards** · **Data&AI@LBG** · **External Comms Initiatives**.

**Goal 2 is the useful one, and it exposes a hole in this plan.** The plan's own objective is to
become one of the most attractive hires in the AI space — which depends on the work being *visible*,
not merely done. Yet everything in this file stops at "ship it and write the number down". Nothing
addresses who outside the team ever hears about it.

Lloyds has a stated ambition to be a top-10 data employer, and the slide names the vehicles for it:
**Data Awards**, **Data&AI@LBG**, **External Comms Initiatives**. In other words the bank *wants*
success stories and has a machine for amplifying them. A quantified win that stays inside a team
Slack channel wastes that.

**The precedent already exists in this file:** Sean Hughes co-presents the Power BI Copilot story at
**SQLBits 2026**. The line manager speaks externally about the team's work. So the path from "built
something with numbers" to "spoke about it publicly" is already trodden inside this specific team.

**Target worth naming out loud: build it, quantify it, then get it in front of people — an internal
Data Award entry, a Data&AI@LBG write-up, and eventually an external talk (SQLBits 2027 is the
obvious one).** That combination — shipped agentic work, in a regulated bank, with a £ number, told
publicly — is the exact profile "the goal this plan serves" describes. Ask in the summer or week one
how grad work gets published, and whether Data Awards accept first-year entries.

## Why the scheme exists — and the one line that matters (29 Jul 2026)

Stated purpose: a **pipeline of skilled, diverse and future-ready data and AI talent**. Then the
sentence worth underlining: **"Data Graduate schemes are the only schemes which span the Group."**

**That makes the cohort the only Group-spanning network in the building, and Jude is in it.** Around
90 people on Data Science & AI, spending eight weeks together in the bootcamp, then scattering into
CL, CR, IP&I, BCB, CIB and the Group Functions. Afterwards, whenever he needs to know how something
really works in Credit, Fraud, Finance or Risk, somebody he did the bootcamp with is sitting in it.
No team-level network can reach that far, and it explains the "injecting AI skills into Business
Units" framing precisely — the grad scheme is the only vehicle that touches everywhere.

Consequences: the bootcamp's eight weeks are a networking asset, not just a course; and **placements
2 and 3 can be scouted through cohort peers already inside those areas** rather than chosen blind.
This upgrades "build your squad" from generic advice to the cheapest strategic move available.

**LBG's own capability ladder** (bottom to top): *Foundational* — understand the data needs and
whether it is fit for purpose · implement data architecture for the model. *Modelling* — build the
model with features · **perform end-to-end testing**. *Analytics* — **monitor results** · insights.

Two observations. **The capstone spans the whole ladder** — question understanding and semantic layer
at the base, end-to-end testing in the middle (the eval harness), monitoring and insight at the top —
so it is not a narrow technical exercise in their terms either. And **the very bottom rung,
"understand the data needs and if fit for purpose", is a business-judgement task, not a technical
one.** The commercial instinct "The edge" describes is an asset at the foundation of their model,
not merely a garnish at the top.

## SCHEME CARD — the definitive summary (29 Jul 2026)

**Data Science & AI · 2-year scheme · 3 × 8-month placements.**
**Qualification: the Artificial Intelligence Professional Programme via Stanford University.**
**Bootcamp: 8 weeks, delivered by Cambridge Spark.**
**Job families placements can land in: Data & AI Data Scientist · Machine Learning & AI Engineering
· Data Engineering.**

### This resolves the collision flagged earlier — they are the same thing

Earlier today this file warned: *do not commit to the Stanford January cohort until the internal
training calendar is known*, on the assumption that the offer letter's "professional qualification"
and the Stanford courses were competing for the same hours. **They are not. The Stanford AI
Professional Programme IS the scheme's professional qualification.** Withdraw the collision warning.

Two things change as a result.

- **Stanford is not an optional perk to be negotiated for; it is the scheme's qualification**, and
  the offer letter's note that *failure has consequences* attaches to it. This file previously
  framed the three courses as an opportunity ("scheme includes up to 3 courses, Lloyds-funded").
  Reframe: it is expected, funded, and carries stakes. The Phase A → Phase B sequence (foundations
  to par, then cert prep) is therefore not optional preparation — it is preparation for a graded
  requirement.
- **The scheduling question stops being personal optimisation.** The right question is no longer
  "should I pick January or spring?" but **"when does the scheme enrol us, is it one course per
  placement, and who decides?"** Ask Next Generation Talent and Sean in the summer conversation.

### Job families — be deliberate about which one

Three named families. Mapping them honestly against the NPD role and the capstone: **Machine
Learning & AI Engineering** is the closest fit — building and shipping agentic systems, evals,
guardrails, production concerns. Data & AI Data Scientist leans to modelling and analysis; Data
Engineering to pipelines. The **17 Nov "Skills Based Organisation" session** will give the job
families with skills and proficiency levels — turn up knowing which one to be tracked into, because
that framework is what promotion is judged against.

## Housekeeping — source documents (29 Jul 2026)

**Offer letter + Contract of Employment now archived** at
`library/lloyds/Grad-Offer-Letter-v7-20260310.pdf` (24 pages, dated 10/03/2026) and read in full —
see the contract section below. **Still missing: the Next Generation Talent team email.** Put it in
`library/lloyds/` so the role description this plan was built from can be checked against source.

## THE CONTRACT — read in full 29 Jul 2026

*Offer letter + Conditional Contract of Employment, dated 10/03/2026, archived in
`library/lloyds/`. Notes below are a plain reading, not legal advice — on the Synergaise questions
in particular, a solicitor's half-hour would be money well spent before September.*

### Confirmed terms

Employer **Lloyds Bank plc**. Job title **Data Science & AI Graduate on the Graduate Scheme**.
Place of work **London, 10 Gresham Street**. Grade **MT = equivalent of Grade D**. Core **35-hour
week** (1,820 hrs/yr). Basic salary **£45,000**. **£5,000 settling-in payment**, paid the month
after starting. **28 days holiday** plus bank holidays. Private medical, flex benefits, life cover
4× salary, Group pension with salary sacrifice. Notice: **Jude gives 1 month**; the Company gives
1 week under 6 months' service, 1 month from 6 months to 4 years. Mandatory Training every quarter.
Offer conditional on references, right to work, and being "fit and proper" under FSMA.

### Clause 15 — Other Employment. Better than this plan assumed.

> *"You may not during Your employment without Your line manager's prior written consent, be in any
> way directly or indirectly engaged or concerned with any other business or employment. **Such
> consent will not be unreasonably refused.**"*

Three things matter. It is **the line manager's** consent — Sean, one person, not a committee.
**"Not unreasonably refused"** means the default posture is not "no"; a refusal needs a reason. And
the scope is broad — *"directly or indirectly engaged or concerned with any other business"* plainly
covers Synergaise. The Group Compliance Policy is also incorporated into the contract, so there may
be further rules underneath. **Week-one action stands: get written consent, and make it specific
about what Synergaise does.**

### Clause 24 — Intellectual Property. The real Synergaise risk, and this plan had missed it.

> *"You agree that the Company will own all intellectual property rights in or arising from work
> carried out by You **in the course of Your employment**… If You, individually or as part of a
> team, create or make any discovery or development, You shall immediately disclose full details to
> the Company."* Moral rights waived; the clause **survives termination**.

"In the course of Your employment" is the limiter, and it is doing a lot of work. Jude will be
employed to build AI systems while separately running an AI automation business — the subject
matter overlaps almost completely, which is exactly the situation this clause is written for.
Practical hygiene from day one: **Synergaise work never on Lloyds equipment, never in Lloyds hours,
never derived from anything seen at work, and kept in separate repositories and accounts.** The
Clause 15 consent should ideally describe Synergaise's scope, so there is a written record of what
was disclosed and permitted. This is the item worth paying a solicitor to look at.

### Clause 12.1 — the Qualification, and a funding clawback nobody had priced

> *"Whilst You are on the Graduate Scheme You may be expected to study for and achieve a
> Professional Qualification… In the event you fail to achieve the Qualification within a reasonable
> period of time… you will be managed in line with the Group performance management policies which
> may ultimately lead to the termination of your employment."*

**The contract does NOT name Stanford.** It says "a Professional Qualification relevant to the
Group's business and Your own particular role". The Stanford AI Professional Programme is named on
the Welcome scheme card, not in the contract — so treating them as the same thing remains a strong
inference, not a documented fact. Confirm with Sean.

**Reading the failure clause accurately (asked 29 Jul: "does failing mean I get fired?").** No —
not for failing an exam. The clause is triggered by failing *to achieve the Qualification within a
reasonable period of time*, and it explicitly contemplates **"exams and associated re-sits"**, so
retaking is part of the expected path. The stated consequence is being **managed under the Group
performance management policies** — a structured process with stages, designed to give a chance to
recover. Termination is the far end of that process ("**may** ultimately lead"), not its first step.
This is standard wording for professional-qualification schemes (accountancy, actuarial, law all
carry similar).

The likelier practical risk is not an exam result but the other trigger in the same clause —
**"not making sufficient progress"**, which is about disengagement rather than ability, and which
also switches on the funding clawback. Steady visible progress is the mitigation, and the ladder
system plus [study-log.md] is already exactly that: a dated record that surfaces slippage long
before an exam would. Ask Sean and Next Generation Talent what actually happens when someone
struggles — re-sit policy, tutoring, whether anyone has been removed for it. That answer will be far
more informative than the contract's worst-case language.

**OPEN AND UNRESOLVED (29 Jul): is the Stanford programme optional?** Jude's reading after the
Welcome is that it is. Three positions have been taken in this file today and only one can be right,
so it is recorded plainly rather than smoothed over:

1. Original: "scheme includes up to 3 courses, Lloyds-funded" — an opportunity.
2. Mid-afternoon (from the scheme card naming Stanford as "Qualification"): expected, funded,
   carries stakes. **Overstated — that was inferred from a slide label.**
3. Now: possibly optional.

**The contract supports ambiguity, not certainty.** Clause 12.1 says *"You **may** be expected to
study for and achieve a Professional Qualification"* — conditional, and it never names Stanford.
Everything downstream (failure → performance management; the funding clawback) only bites **if a
Qualification is actually required of Jude and its funding is taken.**

**If optional, what changes:** the termination exposure largely disappears, and the clawback only
applies to funding actually drawn. **What does not change:** doing all three is then a
differentiator rather than a baseline, because most people will not — and the courses still serve
the stated goal directly. Phase A (foundations to par) remains right either way: the maths ladder
serves the job whether or not it serves an application.

**This is now the single most consequential open question in the plan. Resolve it with Sean or Next
Generation Talent in the summer conversation** — is the Stanford AI Professional Programme the
"Qualification" referred to in Clause 12.1, is it required or opt-in, and what funding is attached?

**Funding repayment table (Clause 12.1):**

| Leaving… | Repayment |
|---|---|
| During the study programme | 100% |
| Within 6 months of completing | 100% |
| Within 12 months | 75% |
| Within 18 months | 50% |
| Within 24 months | 25% |

Repayment is triggered not only by leaving or giving notice, but also by **choosing to stop the
studies** or by it becoming apparent on review that **"You are not making sufficient progress"**.

**Why this matters to the wealth plan.** That plan's thesis is that Lloyds is the launchpad and the
money comes at the jump. This clause does not block the jump — it **prices** it, with a 24-month
tail after the qualification completes. Three Stanford courses at ~$1,950 is roughly £4.5k of
funding at stake if the jump comes early. Worth modelling deliberately rather than discovering.

### Clause 12.2 and the settling-in payment — two more retention hooks

Clause 12.2: performance is monitored throughout, and the Company **reserves the right to remove
Jude from the Graduate Scheme or terminate employment within the first 2 years** if performance
does not meet Management Trainee standards. And the **£5,000 settling-in payment is repayable in
full if he leaves or gives notice within the first 12 months.** So there are three separate
financial/positional hooks: a 12-month cliff on £5k, a 24-month taper on qualification funding, and
a 2-year performance right.

### Clause 22 — post-termination restrictions are mild

**Three months** from termination (less any garden leave). Non-solicitation of customers and Key
Personnel, and no dealing with Restricted Customers in competition with a Relevant Business.
Explicit carve-outs: shareholdings under 5%, and business in areas Jude did not deal with **or which
is not in competition with any Relevant Business**. For a jump into AI work outside retail/commercial
banking, this is not a serious constraint.

### Clause 16 — confidentiality. Directly relevant to today's habit.

> *"You are not permitted to make any copy, abstract, summary or précis of the whole or part of any
> document belonging to the Company or the Group except where expressly authorised to do so in the
> proper performance of Your duties."*

Today's practice — screenshotting internal decks (one marked **Limited**) and transcribing them into
personal files — is fine now, because Jude is not yet an employee and the material was sent to him
as a candidate. **From 3 September it would not be.** The habit stops at the door. The Company also
reserves the right to monitor messaging systems and to review all information held on his PC.

### The Conduct Rules — free material for the 22 Aug governance session

The Appendix sets out the **Individual Conduct Rules** that apply: act with integrity · act with due
skill, care and diligence · be open and co-operative with the FCA, PRA and other regulators · pay
due regard to the interests of customers and treat them fairly · observe proper standards of market
conduct · **act to deliver good outcomes for retail customers** (the Consumer Duty rule). The
contract also confirms the regulatory frame: **FSMA**, regulated by the **PRA and FCA**, with the
**Senior Managers and Certification Regime (SMCR)** defining Certification and Senior Management
Functions. That is the governance session's syllabus, sourced from his own contract rather than
from the internet.

### What to do with this

1. **Clause 15 consent — week one, in writing, specific about Synergaise.**
2. **Clause 24 — get a solicitor's view before September**; put the IP hygiene rules in place now.
3. **Model the two clawbacks into the wealth plan** (£5k at 12 months; qualification funding on a
   24-month taper). Numbers only — the strategy stays Jude's.
4. ~~Confirm with Sean whether "the Qualification" is the Stanford programme.~~ **RESOLVED 1 Sept
   2026 — the Summer Welcome DS&AI scheme slide states it: Artificial Intelligence Professional
   Programme via Stanford University.**
5. **Stop the screenshot-and-transcribe habit on 3 September.**

## Get Work Ready briefing — onboarding logistics (deck 28 Jul–Aug 2026, filed 1 Sept 2026)

Full decode in **`get-work-ready-2026-08-28/notes.md`** (deck: `Get_Work_Ready_2026.pdf`). Jude
missed the live session; this was reconstructed from the deck plus the NGT summary email. The
operational detail lives in that file — what matters here:

- **Day 1 and 2 (3–4 Sept) are both at 10 Gresham Street**, with the London hub's 106 joiners (98
  graduates, 8 apprentices) out of **470 NGT joiners across five hubs**. Day 1 is passes, cohort
  networking, a senior leader, and a **"Laying the Groundwork" session facilitated by Fitch**. Day 2
  is IT onboarding with the **Modern Workplace team** plus **"How the Bank Makes Money"** — which is
  the session the 21 Aug NIM prep was aimed at.
- **The Activation Event is in MANCHESTER** — Tue 15 Sept, Victoria Warehouse, travel and hotel
  arranged by NGT via Inntel. The KB previously recorded only the date. **Registration closed 28
  August and travel forms were due before that**; whether Jude completed either is unconfirmed as of
  1 Sept and is the single time-critical item in the pack.
- **Anchor days are explicitly designated a line-manager conversation** by the Group's own
  onboarding material, twice. The week-one question held since 29 July is the sanctioned route, not
  an imposition — asking Sean about it before starting is exactly what the deck tells joiners to do.
  Office floor is **at least 2 days/week** (the NGT summary words it as **40%**, any LBG office
  counting); core hours **9–5**; **office travel is unpaid and in your own time**; desks via
  **Condeco**; dress **smart casual**.
- **AI Basecamp (18 Sept – 6 Nov, Friday mornings) is mandatory for graduates — except data
  graduates**, who do the Cambridge Spark bootcamp instead. ⚠️ Confirm: those Friday mornings would
  otherwise collide with the bootcamp's Friday in-office hub day. One question to Sean or NGT.
- **Blueprint** (Q1 2027) is the NGT development programme proper — quarterly themes, one mandatory
  personal-skills course per quarter for graduates, plus an optional leadership workshop capped at
  150 places. Worth knowing the cap exists before the Q1 sign-up opens.

## Summer Welcome source deck filed + what it settles (1 Sept 2026)

The original PDF of the 29 July DS&AI Virtual Summer Welcome is now in
`summer-welcome-2026-07-29/Virtual_Summer_Welcome_Data_Science_AI_Graduates.pdf`, alongside the 27
screenshots taken from it at the time. **The screenshot-and-transcribe habit can stop.** Four things
the full deck settles that the screenshots did not:

- **"The Qualification" IS Stanford.** The DS&AI scheme slide states it outright: *"Qualification:
  Artificial Intelligence Professional Programme via Stanford University."* This closes open
  question 4 in the contract section — no need to ask Sean. It also means the offer letter's
  professional-qualification clause and its 24-month funding taper attach to the Stanford
  programme, and that the Phase B plan's "Stanford route" is not an ambition Jude has to argue
  for; it is the scheme.
- **Scheme shape confirmed: 2 years, three 8-month placements.** Job families a DS&AI grad can be
  placed into: **Data & AI Data Scientist · Machine Learning & AI Engineering · Data Engineering.**
- **Two gaps in the timeline the screenshots missed.** **Week 2 (w/c 7 Sept) is labelled "Team
  Time"** — induction activities, software downloads and bonding with the new team, i.e. there IS
  team contact before the bootcamp. And **Fri 18 Sept is a virtual "Bootcamp Induction Session"**,
  not just the start of AI Basecamp. **16 Nov is also "Team Time"** — the point at which you "fully
  join your placement one team". The 90-day clock starts there.
- **Direct contacts, from the closing slide:** `nextgenerationtalent@lloydsbanking.com` for
  programme-specific queries (Activation event, bootcamp, schedule) and
  `nextgenerationrecruitment@lloydsbanking.com` for vetting, references and start date. **These are
  the addresses for chasing the missed Activation registration.**

**The merged, detailed day-by-day now lives in `timeline-2026.md`** — that file, not this section,
is the thing to open when the question is "what happens when".
