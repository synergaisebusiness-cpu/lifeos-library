# Python L0 CHECKPOINT — Variables, Control Flow, Functions

*Monday 3 August 2026 · cold · 35 minutes · unassisted*

Covers L0.1 (29 Jul), L0.2 (30 Jul), L0.3 (31 Jul). This also absorbs the L0.3 rep sheet that was
never marked — so passing this is what logs L0.3 as climbed.

**Rules.** No notes, no chat panel, no running anything until a part is fully written down. If you
get stuck, leave it blank and move on — a blank is data, a borrowed answer isn't.

**Confidence column is not optional.** Next to every answer in Part 1 write **A**, **B** or **C**
before you run anything:

- **A** — certain
- **B** — fairly sure
- **C** — guessing

This is scored separately from correctness, and it's the more important score. A wrong answer rated
**A** is the single most dangerous data point this ladder produces, and you generated one on 30 Jul
across two subjects. We're measuring whether that's fixed.

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

## Part 2 — Write. In `practice/checkpoint_l0.py`. (~15 min)

Every function gets a `# takes a ___, returns a ___` comment above the `def`, written **before** the
body. That comment is part of the answer.

**1. `safe_divide(a, b)`**
Returns `a / b`. Raises `ValueError` with a useful message when `b` is zero.
Test: `safe_divide(10, 4)`, then `safe_divide(10, 0)`.

**2. `describe_temp(celsius)`**
Returns a `str` for **any** number. Your thresholds, your words.
Test with `-5`, `0`, `15`, `40`. All four must print a sentence. If any prints `None`, you've
reproduced the 31 Jul bug and the fix is yours to find.

**3. Rewrite with guard clauses.** No nesting, no `else`. Failures raise rather than return `None`.

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

Test: `acc = {"active": True, "balance": 500}` then `withdraw(acc, 200)`, then `withdraw(acc, 900)`.

**4. `is_read_only(sql)`** — this one is your capstone's first guardrail, written five weeks early.
Takes a string, returns a `bool`. `True` only when the statement is a read.
Test: `"SELECT * FROM orders"`, `"select 1"`, `"DROP TABLE orders"`,
`"SELECT * FROM orders; DELETE FROM orders"`.

The last one is the interesting case. If it returns `True`, say so in your answer rather than
patching it quietly — knowing your guardrail is porous is worth more than a guardrail you believe in.

---

## Part 3 — One sentence each. (~4 min)

**(a)** Which of these is true, and what is the difference between them?

- *"A function with no `return` statement returns `None`."*
- *"A function that doesn't **hit** a `return` returns `None`."*

**(b)** Three of the eight questions in Part 1 are the same underlying failure wearing different
clothes. Name the failure in one sentence, and say which three.

---

## What I'm marking

Correctness, then calibration, then whether the through-line in **3(b)** landed. Paste Part 1 with
its confidence letters, the file, and the terminal output together.
