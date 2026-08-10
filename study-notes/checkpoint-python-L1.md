# Python L1 CHECKPOINT — Lists & Tuples, Dicts & Sets, Comprehensions, Files & Exceptions

*Monday 10 August 2026 · cold · unassisted*

Covers L1.1 (3 Aug), L1.2 (4 Aug), L1.3 (6 Aug — already rep-checked and **CLIMBED 7 Aug**, 6/6
clean, so this touches it lightly rather than re-litigating it), and L1.4 (7 Aug — **taught, not
climbed**: exercises were skipped and the model-check left two misses live). This absorbs the L1.4
exercises that never got done and the two Friday retests, the same way the L0 checkpoint absorbed
the unmarked L0.3 rep sheet.

**Where this sits.** Sat 8 Aug and Sun 9 Aug did not happen — nothing since Friday's close. That
trips the tripwire agreed on 2 Aug: weekend blocks are cut from here without further discussion.
Full note in `study-log.md`. This checkpoint is today's actual block — not Python L5, which the
printed schedule names for today but which is three rungs away from where the ladder actually is.

**Rules.** No notes, no chat panel, no running anything until a part is fully written down. If you
get stuck, leave it blank and move on — a blank is data, a borrowed answer isn't.

**Confidence letters.** Next to every answer write **A** (certain), **B** (fairly sure) or **C**
(guessing) **before you run anything**. Scored separately from correctness.

---

## Part 0 — Hygiene, before anything else (~90 sec)

Two things left over from Friday, do them now so they don't sit there another week:

1. `data/` is currently inside `practice/` — drag it up to the `lloyds-prep` root, next to
   `practice/`, not inside it. **This is why seeding the data felt weird on Friday**: the file lives
   at `data/cities.txt` relative to `practice/`, but the VS Code ▶ button runs from the project root
   (`lloyds-prep`), so `open("data/cities.txt")` was looking in the wrong place the whole time —
   `cities.txt` itself is fine (checked: four city names, no issue there), it was just sat behind the
   wrong door.
2. `Files and Exceptions.py` has capitals and a space in the name — rename it to
   `files_exceptions.py`. (Third costume of the lowercase rule: variables, then a folder, now a
   filename. Spaces make a module permanently unimportable — worth knowing why this one isn't
   optional.)
3. Create an empty `results/` folder at the `lloyds-prep` root too (same level as `data/` and
   `practice/`). `open(path, "w")` will happily create the *file*, but it will not create a missing
   *folder* — Part 1 Q6 and the append example both write into `results/`, and without the folder
   existing first you'd hit a FileNotFoundError that has nothing to do with the lesson.

---

## Part 1 — Predict. Value **and** type where relevant. Nothing runs until all nine are written. (~15 min)

```python
# 1
prices = [42, 17, 99, 8, 63]
print(prices[1:99])
```

```python
# 2
original = [10, 20, 30]
backup = original
backup[0] = 999
print(original)
```

```python
# 3
prices = [42, 17, 99]
cheapest_first = prices.sort()
print(cheapest_first)
print(prices)
```

```python
# 4
account = {"active": True, "balance": 500}
balance = account.get("balence")
print(f"Balance: {balance}")
```

```python
# 5
scores = ["7", "10", "9"]
top = [s for s in scores if s > "8"]
print(top)
```

```python
# 6 — retest of Friday's Q1
with open("results/log.txt", "w") as f:
    f.write("run 1\n")

with open("results/log.txt", "w") as f:
    f.write("run 2\n")

with open("results/log.txt") as f:
    print(f.read())
```

```python
# 7 — retest of Friday's Q2
try:
    total = pryce * 2
    print(total)
except:
    print("could not calculate total")

print("done")
```

```python
# 8
try:
    with open("data/missing.txt") as f:
        content = f.read()
except FileNotFoundError:
    content = ""

print(repr(content))
```

```python
# 9
row = ("2026-08-10", "Leeds", 3980)
date, city = row
```

Now run all nine. **Mark which you got wrong before you look at why**, and flag every case where you
rated **A** and were wrong — that's still the most useful cell on the sheet.

---

## Part 2 — Write. (~20 min)

**File: `practice/checkpoint_l1.py`, in VS Code, run from `lloyds-prep`.**

Write all three first. **A / B / C** on each, before you run. `# takes a ___, returns a ___` above
every `def`, written before the body — still marked.

### The three

**1. `read_scores(path)`** *(this is Friday's exercise 3, undone — doing it now, not skipped twice)*

- Takes a `str` path. Returns a `list` of `int`s.
- Skip blank lines. `int("42\n")` copes with the trailing newline; `int("")` does not — decide your
  order of operations.

**2. `load_scores_safely(path)`**

- Takes a `str` path. Calls `read_scores(path)`.
- If the file doesn't exist yet (first run of the harness, genuinely expected), return an empty
  list. Catch **the one exception you mean, by name** — not bare `except`.
- Anything else that goes wrong should still crash. Say why that matters in a comment.

**3. `summarize_orders(orders)`**

- Takes a `list` of `dict`s shaped like `{"city": "leeds", "amount": 90}`.
- Returns a `dict` mapping each city to its **total** amount across all its entries.
- No `.get()` needed here — you're building the dict, not reading one that might be missing a key.
  Decide what happens the first time you see a city versus the second.

### Skeleton — type this into the file

```python
# practice/checkpoint_l1.py

# takes a ___, returns a ___
def read_scores(path):
    ...


# takes a ___, returns a ___
def load_scores_safely(path):
    ...


# takes a ___, returns a ___
def summarize_orders(orders):
    ...


# ---------- tests: do not edit ----------

# before running: create data/scores.txt yourself —
# five numbers, one per line, with one blank line in there somewhere

print(read_scores("data/scores.txt"))              # expect a list of ints, blank line skipped
print(load_scores_safely("data/scores.txt"))        # expect the same list
print(load_scores_safely("data/nope.txt"))          # expect [] — no traceback

orders = [
    {"city": "leeds", "amount": 90},
    {"city": "york", "amount": 120},
    {"city": "leeds", "amount": 40},
]
print(summarize_orders(orders))                      # expect {'leeds': 130, 'york': 120}
```

Paste me the file and the terminal output together.

---

## Part 3 — One sentence each. (~4 min)

**(a)** Q6 in Part 1 ran clean and printed something short. What got lost, and would you have known
if this had been your golden-set results file?

**(b)** Q7 printed a polite message instead of crashing. What was actually wrong with the code, and
why did the `except` hide it rather than fix it?

**(c)** Three of the nine Part 1 questions are the same failure in different clothes — a wrong or
missing answer that doesn't announce itself. Name the failure in one sentence and say which three.

---

## What I'm marking

Correctness, then calibration, then whether (a) and (b) show the two Friday misses actually closed
— that's the real pass condition for L1.4, not just today's questions.
