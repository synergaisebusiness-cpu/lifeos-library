# Python L1.2 — Dictionaries and Sets

*Lloyds study · deep block · Tuesday 4 August 2026 · read time ~13 min · notes before questions*

Same loop. Read once through, then again with VS Code open, typing the examples.

You've already used a dictionary this week without being taught one — `account["active"]` in
yesterday's `withdraw`, which you wrote as `account.balance` and then as `account == "active"`. Both
of those were reasonable guesses at a thing nobody had shown you. Here's the thing.

---

## Why this rung matters more than it looks

A list answers *what's in position 3*. A dictionary answers *what's the value of `revenue`*.

That difference is the whole shape of your capstone. When a model replies to you it doesn't hand
back item 0 and item 1 — it hands back JSON, and JSON becomes a Python dictionary the moment it
arrives:

```python
{"sql": "SELECT ...", "confidence": 0.8, "reasoning": "..."}
```

On 14 August you'll spend a whole block on structured output, and structured output means *this
shape*. Every API response, every config file, every row you want to read by column name rather
than by counting commas — dictionaries. If lists were the return type of the project, dicts are the
language the model speaks to you in.

---

## 1. A dictionary is lookup by name

```python
account = {"active": True, "balance": 500}
```

Curly braces, and each entry is a **key** and a **value** separated by a colon. You look things up
by key:

```python
account["balance"]     # 500
account["active"]      # True
```

That's the answer to yesterday. `account["active"]` reaches in and pulls out `True` — which is
already a boolean, so `if not account["active"]:` reads exactly as *if the account is not active*.
No comparison needed, because there's nothing to compare it to.

Keys are almost always strings. Values can be anything — numbers, strings, booleans, lists, other
dictionaries.

Order is not the point. `{"a": 1, "b": 2}` and `{"b": 2, "a": 1}` hold the same information, and you
never index a dict by position. If you find yourself wanting item 0, you wanted a list.

---

## 2. The two ways to read a key, and why it matters

This is the important section on this rung.

```python
account = {"active": True, "balance": 500}

account["balance"]      # 500
account["overdraft"]    # KeyError: 'overdraft'
```

Square brackets on a missing key **raise**. Loud, immediate, points at the exact key you got wrong.

```python
account.get("overdraft")        # None
account.get("overdraft", 0)     # 0
```

`.get()` does not raise. A missing key gives you `None`, or whatever default you pass as the second
argument. It is quiet, and quiet is the thing you've spent a week learning to distrust.

Look at what that does downstream:

```python
balance = account.get("balence")     # typo'd key
print(balance + 100)                 # TypeError: unsupported operand type(s)
```

The typo is on line one. The explosion is on line two, and the error message talks about addition,
which is not where the problem is. With `account["balence"]` you'd have got a `KeyError` naming the
exact typo, on the exact line.

Worse — if the value only gets printed rather than added:

```python
print(f"Balance: {account.get('balence')}")     # Balance: None
```

No error at all. A report goes out saying `None`.

**Rule of thumb: use `[]` by default.** You *want* the crash when a key you were relying on isn't
there. Reach for `.get()` only when a key being absent is a normal, expected state and you have a
sensible default — `settings.get("timeout", 30)`. `.get()` on data you assumed was there is how you
end up debugging line 40 for a mistake made on line 2.

---

## 3. Changing a dictionary

```python
account["balance"] = 300        # change an existing key
account["overdraft"] = 250      # add a new one — same syntax
del account["overdraft"]        # remove
```

Note that adding and changing look identical. There's no "new key" operator, which means a typo'd
key on the left-hand side silently *creates* a second key rather than updating the one you meant:

```python
account["balence"] = 300
print(account)    # {'active': True, 'balance': 500, 'balence': 300}
```

Both are now sitting there, no complaint, and the one everything else reads is unchanged. Same
creature, new costume.

And the point from L1.1 that transfers directly: **dictionaries are mutable, so passing one into a
function hands over the real thing, not a copy.** Yesterday's `withdraw` doing
`account["balance"] -= amount` changed the caller's account permanently. If you want to be safe,
`account.copy()` first — exactly as with lists.

---

## 4. Checking before you reach

```python
"balance" in account        # True  — checks KEYS, not values
500 in account              # False — 500 is a value, not a key
```

`in` on a dictionary asks about keys. That gives you the safe pattern when you're unsure:

```python
if "overdraft" in account:
    use(account["overdraft"])
```

...which is a guard clause, same as the ones you wrote yesterday.

---

## 5. Looping over a dictionary

Plain iteration gives you **keys**:

```python
for key in account:
    print(key)              # active, balance
```

Usually you want both, and this is where L1.1's unpacking pays off:

```python
for key, value in account.items():
    print(f"{key}: {value}")
```

`.items()` hands you each entry as a **tuple of (key, value)**, and `key, value` unpacks it — the
same move as `for city, revenue in rows`. That's why tuples came first.

`.keys()` and `.values()` exist for when you want one or the other. `.values()` is the one you'll
use for sums: `sum(account.values())` where the values are numbers.

---

## 6. The shape your data actually arrives in

Real data nests. Two combinations do almost all the work:

**A list of dictionaries** — many records, each with named fields. This is what an API returns and
what a query result looks like when you ask for it by name:

```python
rows = [
    {"city": "Manchester", "revenue": 4210},
    {"city": "Leeds", "revenue": 3980},
]

for row in rows:
    print(f"{row['city']}: £{row['revenue']:,}")
```

Note the quote-swap inside the f-string — outer double, inner single, or Python can't tell where the
string ends.

**A dictionary of lists** — one record with a field that holds several things:

```python
report = {"city": "Manchester", "months": [4210, 3980, 5120]}
report["months"][0]     # 4210 — read it left to right: the months, then the first
```

Nothing new here, just the two ideas stacked. Read the brackets left to right and it stays simple.

---

## 7. Sets, briefly

A set is a collection with **no duplicates and no order**:

```python
cities = {"Manchester", "Leeds", "Manchester"}
print(cities)          # {'Leeds', 'Manchester'} — the duplicate is gone
```

Curly braces like a dict, but no colons — entries, not pairs. (`{}` on its own is an empty dict, not
an empty set. Empty set is `set()`. Mild trap, worth knowing once.)

Two things it's genuinely good for:

**De-duplicating.** `set(my_list)` collapses duplicates; `list(set(my_list))` gets you back a list
with the repeats gone — though the order is lost, so sort it after if order mattered.

**Asking whether something is present.** `x in my_set` is fast no matter how large the set is, where
`x in my_list` checks items one at a time. On five items you'll never notice. On a banned-words
check running against every query your agent generates, you will.

Which is your guardrail from yesterday:

```python
BANNED = {"drop", "delete", "update", "insert"}
```

A fixed collection of unique things you only ever ask *is this in there* — that's a set's exact job
description.

---

## Exercises — live, together

1. `account = {"active": True, "balance": 500}`. Print the balance. Then try to print
   `account["overdraft"]` and read the error. Then get it with `.get()` and a default of `0`.
2. Add an `"overdraft"` key of 250. Change the balance to 300. Delete the overdraft. Print the dict
   after each step.
3. Write `describe_account(account)` — takes a dict, returns a string like
   `"Active account with a balance of £500"`. Handle an inactive account differently. Use guard
   clauses, and decide deliberately whether a missing `"balance"` key should crash or default.
4. `rows = [{"city": "Manchester", "revenue": 4210}, {"city": "Leeds", "revenue": 3980}, {"city": "Bristol", "revenue": 5120}]`
   — loop and print each city with its revenue, thousands-separated.
5. Same `rows`: return the city with the highest revenue. Seed with `None`, not `0` — you know why
   as of yesterday.
6. Rewrite `is_read_only(sql)` using a **set** of banned words instead of a list. Nothing else
   changes. Say what the set buys you and what it costs.
7. `["drop", "select", "drop", "update", "select"]` → a list of the unique words, alphabetically.

---

## Reps — last 15 minutes, in the room, unassisted

Marked on the spot. L1.2 isn't logged as climbed until they're marked.
