# Python L1.1 — Lists and Tuples

*Lloyds study · deep block · Monday 3 August 2026 · read time ~13 min · notes before questions*

Shorter than usual on purpose — the block lost 50 minutes at the front, and the last 15 belong to
reps now. One idea, taught properly, beats four skimmed.

Written in `.py` files run from VS Code, as of 31 Jul. No REPL.

---

## Why this rung matters more than it looks

Every single thing your capstone touches comes back as a list.

`run_sql()` returns rows. Rows come back as a **list of tuples** — a list of records, each record a
fixed group of fields. The golden set is a list of question-and-answer pairs. The eval harness walks
a list and scores each item. On 15 August, when the model calls your function and gets data back,
what it gets back is this shape. You cannot hand a model a result set you can't confidently index,
slice or count.

So this isn't "collections, for completeness". This is the return type of the entire project.

---

## 1. A list is an ordered, changeable sequence

```python
prices = [42, 17, 99]
```

Square brackets, comma-separated, order is preserved and meaningful. Position 0 is first — always
0, never 1, and the off-by-one that causes is a rite of passage rather than a sign of anything.

```python
prices[0]     # 42
prices[2]     # 99
prices[-1]    # 99   — last item
prices[-2]    # 17   — second from last
prices[3]     # IndexError: list index out of range
```

Negative indices count backwards. `[-1]` for "the last one" is idiomatic and you'll write it
constantly — `rows[-1]` is the most recent row when the query is sorted by date.

Note what `prices[3]` does: it **raises**. That's a loud failure, and loud failures are the good
kind. Hold that thought — this rung's real lesson is about the quiet ones.

---

## 2. Slicing, and the one thing that trips everyone

A slice takes a range and gives you back a **new list**.

```python
prices = [42, 17, 99, 8, 63]

prices[1:3]    # [17, 99]
prices[:2]     # [42, 17]
prices[2:]     # [99, 8, 63]
prices[:]      # [42, 17, 99, 8, 63]  — a full copy
```

**The rule that matters: the start is included, the end is not.** `[1:3]` gives you positions 1 and
2, not 1, 2 and 3. This is called a half-open interval, and it looks like a design mistake until you
notice two things it buys you:

- `prices[:2]` and `prices[2:]` split the list cleanly with no overlap and nothing lost. The same
  number appears in both slices and each item lands in exactly one of them.
- The length of `prices[a:b]` is just `b - a`. No arithmetic, no fencepost.

Slicing never raises for being out of range. `prices[1:99]` gives you everything from position 1
onward, quietly. That's convenient and it is also the first quiet thing on this rung.

---

## 3. Changeable — and the bug that comes with it

This is where lists differ from everything you've handled so far, and where L0.1's label model comes
back to collect.

```python
prices = [42, 17, 99]
prices[0] = 50
print(prices)      # [50, 17, 99]
```

The list itself changed. You did not make a new one. Compare with a string, which cannot be changed
in place at all:

```python
name = "jude"
name[0] = "J"      # TypeError: 'str' object does not support item assignment
```

Now the consequence. Remember from L0.1: **a variable is a name pointing at a value, and assignment
attaches a label.** With numbers that was a harmless bit of pedantry. With lists it is a live bug:

```python
original = [42, 17, 99]
backup = original          # NOT a copy — a second label on the same list
backup[0] = 0
print(original)            # [0, 17, 99]   ← your "backup" edited the original
```

One list, two names. There was never a second list. Nothing raised, nothing warned, and `original`
is now wrong. If that had been a result set you were about to hand a model, the model would answer
confidently from corrupted data and you would have no error message to follow.

The fix is to ask for a copy explicitly:

```python
backup = original[:]          # slice-copy
backup = list(original)       # same thing, says it out loud
```

---

## 4. Methods — and the theme in a new costume

```python
prices = [42, 17, 99]

prices.append(8)        # [42, 17, 99, 8]      — one item on the end
prices.extend([1, 2])   # [42, 17, 99, 8, 1, 2] — each item of another list
prices.pop()            # returns 2, list is now [42, 17, 99, 8, 1]
len(prices)             # 5
99 in prices            # True
```

`append` versus `extend` is worth ten seconds: `append([1, 2])` puts *a list* on the end as a single
item, giving you a list containing a list. `extend([1, 2])` puts the two numbers on. Both are
correct code and only one is what you meant.

And now the one to actually remember:

```python
prices = [42, 17, 99]

cheapest_first = prices.sort()
print(cheapest_first)     # None
print(prices)             # [17, 42, 99]
```

`.sort()` sorts the list **in place** and **returns `None`**. Assign it to a name and the name holds
nothing, while the sorting you asked for happened anyway, invisibly, to the original.

Read that again and then read your 31 July notes, because **this is the same failure you have now
met four times**: `describe_temp` returning `None` off the end, `area("ab", 3)` returning
`"ababab"`, `total()` shadowing its own name, and now `.sort()`. Four different costumes, one
creature — *a wrong answer that does not announce itself*.

When you want a sorted copy and to leave the original alone:

```python
cheapest_first = sorted(prices)      # returns a new list; prices untouched
```

The naming is the tell, and it's a rule that generalises across Python: **verb methods
(`.sort()`, `.reverse()`, `.append()`) change the thing and return `None`. Adjective-ish
built-ins (`sorted()`, `reversed()`) leave it alone and hand you a new one.**

---

## 5. Tuples: the ones that can't change

```python
row = ("2026-08-03", "Manchester", 4210)
```

Round brackets. Same indexing, same slicing, same `len()`. One difference: you cannot change it
after it's made.

```python
row[2] = 5000     # TypeError: 'tuple' object does not support item assignment
```

Which sounds like a list with a feature removed. It isn't — it's a different intent, and the
difference is the useful part:

- A **list** is *several of the same kind of thing*, and how many is a fact about the data.
  Ten prices. Two hundred rows.
- A **tuple** is *one thing with several fields*, where the count and the order are fixed by what
  the thing is. A row. A coordinate. A date-city-revenue record.

`len(prices)` is a real question. `len(row)` is always 3 and asking is a bit odd. That's the test.

This is exactly why database rows come back as tuples: a row of `(date, city, revenue)` has three
fields in that order by definition, and code that appends a fourth to a row has misunderstood
something. The immutability isn't a restriction, it's the schema being enforced.

### Unpacking — the reason you'll actually like tuples

```python
row = ("2026-08-03", "Manchester", 4210)

date, city, revenue = row

print(f"{city} took £{revenue:,} on {date}")
```

Three names bound in one line, positionally. This is how you'll read query results for the rest of
the project, and it's far better than `row[0]`, `row[1]`, `row[2]` scattered through your code —
those are unreadable three weeks later and they silently do the wrong thing the day the column order
changes.

The count must match exactly, and helpfully this one is *loud*:

```python
date, city = row     # ValueError: too many values to unpack (expected 2)
```

Use `_` for a field you don't need: `date, _, revenue = row`.

---

## 6. Walking a list

L0.2's control flow, now with something to control:

```python
prices = [42, 17, 99]

for price in prices:
    if price > 50:
        print(f"{price} is expensive")
```

`for <name> in <list>:` runs the indented block once per item, with the name bound to each item in
turn. Indentation is grammar here exactly as it was in `if`.

And over a list of tuples — the shape you'll actually meet — unpacking works right in the `for`:

```python
rows = [
    ("2026-08-01", "Manchester", 4210),
    ("2026-08-02", "Leeds", 3980),
]

for date, city, revenue in rows:
    print(f"{city}: £{revenue:,}")
```

That is a query result being read. You have now written the loop that ends up inside `run_sql()`.

One warning worth having early: **do not add to or remove from a list while you're looping over
it.** It doesn't raise. It skips items. Build a new list instead — which is where comprehensions
come in tomorrow.

---

## Exercises — we do these together, live

1. From `prices = [42, 17, 99, 8, 63]`: print the first, the last, the middle three, and everything
   except the first, using slices where a slice is the right tool.
2. Make `backup` a genuine copy of `prices`. Change `backup[0]`. Prove `prices` is untouched by
   printing both.
3. Given `prices`, produce **a sorted copy** without changing `prices`, and print both to prove it.
   Then sort `prices` in place and print it. Say out loud which of the two returned `None`.
4. `rows = [("Manchester", 4210), ("Leeds", 3980), ("Bristol", 5120)]` — loop with unpacking and
   print `"City took £X"` per row, with a thousands separator.
5. Same `rows`: find the city with the highest revenue. No `max()`, no sorting — a loop and an `if`.
   Think about what you initialise your "best so far" to, and why an empty list is the case that
   catches people.
6. Write `first_and_last(items)` — takes a list, returns a **tuple** of its first and last items.
   Then decide what it should do for a one-item list, and for an empty one. Your call, but the
   answer is not "return `None` and hope".

---

## Reps — last 15 minutes, in the room, unassisted

New rule from today: no homework, reps happen here. Notes shut, no chat panel. I mark them on the
spot and L1.1 isn't logged as climbed until they're marked.
