# Python L0 CHECKPOINT — Variables, Control Flow, Functions

*Monday 3 August 2026 · cold · unassisted*

Covers L0.1 (29 Jul), L0.2 (30 Jul), L0.3 (31 Jul). This also absorbs the L0.3 rep sheet that was
never marked — so passing this is what logs L0.3 as climbed.

**Rules.** No notes, no chat panel, no running anything until a part is fully written down. If you
get stuck, leave it blank and move on — a blank is data, a borrowed answer isn't.

**Confidence letters.** Next to every answer write **A** (certain), **B** (fairly sure) or **C**
(guessing) **before you run anything**. Scored separately from correctness, and it's the more
important score: a wrong answer rated **A** is the most dangerous data point this ladder produces.

---

## Part 1 — Predict. Value **and** type. Nothing runs until all eight are written. (~12 min)

Every one of these executes without raising. That is the point of the set.

```python
# 1
def classify(n):
    if n > 10:
        return "big"
    elif n > 5:
        return "medium"

print(classify(3))
```

```python
# 2
def line_cost(item, qty):
    return item * qty

print(line_cost("£5", 3))
```

```python
# 3
score = 72

if score >= 40:
    grade = "pass"
elif score >= 60:
    grade = "merit"
elif score >= 80:
    grade = "distinction"

print(grade)
```

```python
# 4
status = "closed"

if status == "open" or "pending":
    print("active")
else:
    print("inactive")
```

```python
# 5
count = 5
count == count + 1
print(count)
```

```python
# 6
print(0.1 + 0.2 == 0.3)
```

```python
# 7
print(bool("False"), bool(""), bool("0"))
```

```python
# 8
def total(price, tax=0.2):
    total = price * (1 + tax)

print(total(100))
```

Now run all eight. **Mark which you got wrong before you look at why**, and note every case where
you rated **A** and were wrong.

---

## Part 2 — Write. (~15 min)

**File: `practice/checkpoint_l0.py`, in VS Code. Run it with the play button or
`python practice/checkpoint_l0.py` in the terminal.**

Write all four functions first. Put **A / B / C** next to each one — meaning *will this run
correctly first time* — **before** you run the file. Then run it once and let everything fail at
once; that's cheaper than four separate runs.

Every function gets a `# takes a ___, returns a ___` comment above the `def`, written **before** the
body. That comment is part of the answer and it is marked.

Note on line 3 of the tests: **once a `raise` fires, the script stops.** So comment out the lines
below a deliberate raise, run, then swap which one is live — or wrap them in `try`/`except` if you
already know how. Don't remove the failing test to make the file run clean; that's on the standing
corrections list.

### The four

**1. `safe_divide(a, b)`**

- Takes two numbers. Returns the result of `a / b`.
- If `b` is zero: `raise ValueError` with a message that says what went wrong.
- A traceback on the second test line is a **pass**, not a failure. It's what you asked for.

**2. `describe_temp(celsius)`**

- Takes a number. Returns a **string** — for *every* possible number, with no gaps between bands.
- Four bands. Your thresholds, your wording.
- All four test lines must print a sentence. A `None` means a number fell through your branches —
  that's the 31 July bug and the fix is yours to find.

**3. `withdraw(account, amount)`**

Rewrite this with guard clauses:

```python
def withdraw(account, amount):
    if account is not None:
        if account["active"]:
            if amount <= account["balance"]:
                return account["balance"] - amount
            else:
                return None
        else:
            return None
    else:
        return None
```

- Takes a dict and a number. Returns the **new balance** after the withdrawal.
- Each invalid case is checked at the top, one condition per guard, and `raise`s immediately.
- No nesting. No `else`. Nothing returns `None`.
- Three invalid cases: no account, account not active, amount larger than the balance.

**4. `is_read_only(sql)`**

- Takes a string. Returns `True` or `False` and nothing else — no printing inside the function.
- `True` only when the statement is safe to run against the database: it reads, and does nothing
  else.
- `False` if it contains `DROP`, `DELETE`, `UPDATE` or `INSERT`.
- Capitalisation must not matter — `"select 1"` is a valid read.

This is your capstone's first guardrail, written five weeks early in nothing but L0 syntax.

### Skeleton — type this into the file

```python
# practice/checkpoint_l0.py

# takes a ___, returns a ___
def safe_divide(a, b):
    ...


# takes a ___, returns a ___
def describe_temp(celsius):
    ...


# takes a ___, returns a ___
def withdraw(account, amount):
    ...


# takes a ___, returns a ___
def is_read_only(sql):
    ...


# ---------- tests: do not edit ----------

print(safe_divide(10, 4))                 # expect 2.5
print(safe_divide(10, 0))                 # expect ValueError: <your message>

for t in [-5, 0, 15, 40]:
    print(describe_temp(t))               # expect four sentences, no None

acc = {"active": True, "balance": 500}
print(withdraw(acc, 200))                 # expect 300
print(withdraw(acc, 900))                 # expect a raise
print(withdraw(None, 50))                 # expect a raise

print(is_read_only("SELECT * FROM orders"))                     # expect True
print(is_read_only("select 1"))                                 # expect True
print(is_read_only("DROP TABLE orders"))                        # expect False
print(is_read_only("SELECT * FROM orders; DELETE FROM orders")) # ?
```

The last line has no expected answer written down **on purpose**. Tell me what yours returns and
whether you think that is the right answer.

Paste me the file and the terminal output together.

---

## Part 3 — One sentence each. (~4 min)

**(a)** Which of these is true, and what is the difference between them?

- *"A function with no `return` statement returns `None`."*
- *"A function that doesn't **hit** a `return` returns `None`."*

**(b)** Three of the eight questions in Part 1 are the same underlying failure wearing different
clothes. Name the failure in one sentence, and say which three.

**(c)** Give the **type** of the printed value in Part 1 questions 1, 2 and 8.

---

## What I'm marking

Correctness, then calibration, then whether the through-line in **3(b)** landed.
