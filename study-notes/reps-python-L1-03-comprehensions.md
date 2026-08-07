# Reps — Python L1.3, Comprehensions & iteration

*Friday 7 August 2026 · ~8 min · unassisted · marked on the spot*

Taught yesterday in a session that wrote nothing to the library, so this sheet is both the reps and
the evidence. Notes shut. No chat panel. A blank is data, a borrowed answer isn't.

**Confidence is part of the answer.** Every Part 1 answer in this exact form:

```
1. [2, 4, 6] — B
```

Value, dash, then **A** (certain), **B** (fairly sure) or **C** (guessing). No letter = marked blank.

---

## Part 1 — Predict. Nothing runs until all six are written. (~5 min)

```python
# 1
nums = [1, 2, 3]
doubled = [n * 2 for n in nums]
print(doubled)
print(nums)
```

```python
# 2
print([x for x in [5, 12, 8, 20, 3] if x > 9])
```

```python
# 3
prices = {"apple": 3, "milk": 2}
print([k for k in prices])
```

```python
# 4
print([c.upper() for c in "abc"])
```

```python
# 5
for i, name in enumerate(["ana", "raj"]):
    print(i, name)
```

```python
# 6
scores = ["88", "92", "100"]
high = [s for s in scores if s > "90"]
print(high)
```

Then run all six and mark yourself before you look at why.

---

## Part 2 — Write. `practice/reps_l1_03.py`. (~3 min)

One comprehension per function body — a single `return [...]` line. `# takes a ___, returns a ___`
comment above each `def`, written first, with **A / B / C** as a trailing comment on the `def` line.

**1. `emails_of(users)`**

- Takes a list of dicts like `{"name": "Ana", "email": "ana@bank.com"}`. Returns the list of email
  strings, same order.

**2. `big_orders(orders, threshold)`**

- Takes a list of `(city, amount)` tuples and a number. Returns the list of **cities** whose amount
  is strictly over the threshold. Unpack the tuple in the comprehension — no `order[0]`.

```python
# practice/reps_l1_03.py

# takes a ___, returns a ___
def emails_of(users):
    ...


# takes a ___, returns a ___
def big_orders(orders, threshold):
    ...


# ---------- tests: do not edit ----------

users = [
    {"name": "Ana", "email": "ana@bank.com"},
    {"name": "Raj", "email": "raj@bank.com"},
]
print(emails_of(users))               # expect ['ana@bank.com', 'raj@bank.com']

orders = [("london", 250), ("leeds", 90), ("london", 40), ("york", 120)]
print(big_orders(orders, 100))        # expect ['london', 'york']
print(big_orders(orders, 9999))       # expect [] — and think about why [] and not 0 or None
```

---

## Part 3 — One sentence. (~1 min)

Question 6 up there ran clean and printed something. Say what it silently got wrong, and name the
29 July exercise it is wearing a costume of.
