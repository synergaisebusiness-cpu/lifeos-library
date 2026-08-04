# Reps — Python L1.1, Lists

*Tuesday 4 August 2026 · 15 min · unassisted · marked on the spot*

Notes shut. No chat panel. A blank is data, a borrowed answer isn't.

**Confidence is part of the answer this time, not a separate column.** Write every Part 1 answer in
this exact form:

```
1. [20, 30] — B
```

Value, then a dash, then **A** (certain), **B** (fairly sure) or **C** (guessing). An answer without
a letter is an incomplete answer and I'll mark it as blank.

---

## Part 1 — Predict. Nothing runs until all six are written. (~6 min)

```python
# 1
items = [10, 20, 30, 40, 50]
print(items[1:3])
print(items[-2])
print(items[2:99])
```

```python
# 2
a = [1, 2, 3]
b = a
b.append(4)
print(a)
```

```python
# 3
a = [1, 2, 3]
b = a[:]
b.append(4)
print(a)
print(b)
```

```python
# 4
nums = [3, 1, 2]
result = nums.sort()
print(result)
print(nums)
```

```python
# 5
nums = [3, 1, 2]
result = sorted(nums)
print(result)
print(nums)
```

```python
# 6
a = [1, 2]
a.append([3, 4])
print(a)
print(len(a))
```

Then run all six and mark yourself before you look at why.

---

## Part 2 — Write. `practice/reps_l1_01.py`. (~7 min)

Both functions get a `# takes a ___, returns a ___` comment above the `def`, written first.
Put **A / B / C** on the same line as each `def` as a trailing comment before you run the file.

**1. `with_added(items, value)`**

- Takes a list and a value. Returns a **new** list containing everything in `items` plus `value` on
  the end.
- The list passed in must be unchanged afterwards. That is the whole exercise.

**2. `top_n(numbers, n)`**

- Takes a list of numbers and a whole number `n`. Returns a list of the `n` largest, highest first.
- `numbers` must be unchanged afterwards.
- If `n` is bigger than the list, return everything you have rather than raising.

```python
# practice/reps_l1_01.py

# takes a ___, returns a ___
def with_added(items, value):
    ...


# takes a ___, returns a ___
def top_n(numbers, n):
    ...


# ---------- tests: do not edit ----------

original = [1, 2, 3]
print(with_added(original, 4))    # expect [1, 2, 3, 4]
print(original)                   # expect [1, 2, 3]  <- unchanged

scores = [42, 17, 99, 8, 63]
print(top_n(scores, 3))           # expect [99, 63, 42]
print(scores)                     # expect [42, 17, 99, 8, 63]  <- unchanged
print(top_n(scores, 99))          # expect all five, highest first
```

---

## Part 3 — One sentence. (~2 min)

`nums.sort()` gives you `None`. `sorted(nums)` gives you a list. State the rule that tells you which
kind of thing a Python method hands back, without having to memorise the list.
