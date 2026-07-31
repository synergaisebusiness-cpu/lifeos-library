# Reps — Python L0.3, Functions

*Set Friday 31 July 2026 · do it today or first thing Saturday · ~15 min · marked at the start of the Sat 1 Aug block*

Unassisted. No notes open, no chat panel. If you get stuck, leave it blank and move on — a blank is
data and a borrowed answer isn't.

Do Part 1 on paper before touching a keyboard. Do Part 2 in `practice/reps_l0_03.py`.

---

## Part 1 — Predict. Write the value **and** its type. (~5 min)

Cold. Don't run them until all six are written down.

```python
# 1
def f(n):
    if n > 10:
        return "big"
print(f(3))
```

```python
# 2
def g(items):
    if len(items) == 0:
        return "empty"
    return len(items)
print(g([1, 2, 3]))
```

```python
# 3
def h(x):
    print(x)
print(h(5) is None)
```

```python
# 4
def area(w, h=2):
    return w * h
print(area(3))
print(area(3, 4))
print(area(h=5, w=2))
```

```python
# 5
def check(v):
    if v:
        return "yes"
    return "no"
print(check(0))
print(check(""))
print(check("False"))
```

```python
# 6
def total(a, b):
    result = a + b
print(total(2, 3) + 1)
```

Then run all six and mark yourself. **Note which ones you got wrong before you look at why.**

---

## Part 2 — Write. (~8 min)

In `practice/reps_l0_03.py`. Every function gets a `# takes a ___, returns a ___` comment above the
`def`, written *before* the body.

**1. `safe_divide(a, b)`**
Returns `a / b`. Raises `ValueError` with a useful message if `b` is zero.
Test with `safe_divide(10, 4)`, then `safe_divide(10, 0)`.

**2. `describe_temp(celsius)`**
Returns a `str` for any number you can give it: freezing, cold, mild, hot — your thresholds, your
words. **Test it with `-5`, `0`, `15`, `40`.** Every one of those four must print a sentence. If any
of them prints `None`, you've reproduced yesterday's bug and the fix is yours to find.

**3. Rewrite with guard clauses** — no nesting, no `else`, each failure raising:

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

Test data:

```python
acc = {"active": True, "balance": 500}
print(withdraw(acc, 200))
```

---

## Part 3 — One sentence. (~2 min)

Write out the difference between these two statements, and say which one is true:

- *"A function with no `return` statement returns `None`."*
- *"A function that doesn't **hit** a `return` returns `None`."*

Then say which of the six predictions in Part 1 tests the difference.

---

Bring the lot to Saturday's block. Five minutes to mark, then L1.1.
