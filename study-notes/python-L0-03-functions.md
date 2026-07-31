# Python L0.3 — Functions

*Lloyds study · deep block · Friday 31 July 2026 · read time ~25 min · notes before questions*

Same loop. Read once through without stopping, then a second time with VS Code open, typing the
examples. Don't paste — typing is where the errors happen and the errors are the lesson.

**One thing changes today: no more REPL.** From now on Python gets written in `.py` files and run
from VS Code. The REPL was the obstacle yesterday, and a function is more than one line by
definition, so the tool has to go. Everything below assumes a file.

---

## Before you read: the warm-up (this is yesterday's deferred set)

Yesterday's exercise set was deferred, not dropped. It's due now, and it doubles as proof that your
environment actually runs.

Make a file `practice/control_flow_reps.py` and write the following. Run it. Fix what breaks.

1. A grade chain: given `score = 72`, print `"distinction"` for 80+, `"merit"` for 60–79,
   `"pass"` for 40–59, `"fail"` below 40. **Write it descending with `>=`, one bound per branch, no
   belt-and-braces.** Then change `score` to `59.5` and run it again. Yesterday your two-sided
   version handed `59.5` a distinction; this version should not.
2. `status = "open"`. Print `"active"` if the status is `"open"` **or** `"pending"`, else
   `"inactive"`. Write the condition correctly this time — the comparison does not carry across
   `or`.
3. Three lines that each print a prediction you make *before* running:
   `print("10" > "9")`, `print(bool("False"))`, `print(bool(""))`.

Paste me the file and the terminal output together.

---

## Why this rung matters more than it looks

Everything you've written so far has been a script: a list of instructions that runs top to bottom
once. A function is the first thing you build that has a **name, an inside, and a boundary** — you
hand it something, it hands something back, and you don't have to care how.

That boundary is the whole job you're heading toward. On **15 August** you sit down to the agent
moment: you write a function called `run_sql()`, you describe it to a model, and the model *calls
it*. The model never sees inside. It sees a name, what goes in, and what comes back. If your
function returns the wrong thing when it fails — or worse, returns nothing while looking like it
worked — the model gets handed a lie and answers confidently from it.

The eval harness is the same shape from the other side: `score(model_answer, golden_answer)` takes
two things and returns a verdict. The guardrails are functions: `is_read_only(sql)` takes a string
and returns `True` or `False`.

So today is not "how to avoid repeating yourself". Today is the unit that everything after it is
made of.

---

## 1. The shape of a function

```python
def add_vat(amount):
    return amount * 1.2
```

Four parts, all required:

- the keyword **`def`**
- a **name**, lowercase snake_case, same rule as every other name you write
- **parentheses** holding zero or more **parameters** — here, `amount`
- a **colon**, then an indented **body**

Indentation does the same job it did yesterday: it's how Python knows where the function's inside
begins and ends. Four spaces.

Writing that `def` block **does not run it.** Nothing happens. You've defined a shape and given it
a name; the value `1.2` doesn't get multiplied by anything yet. To run it you **call** it:

```python
add_vat(50)
```

Two separate events — defining and calling — and they can be far apart in the file. Define at the
top, call at the bottom.

### Parameters vs arguments

Worth getting straight now because both words appear in every error message you'll read for the
next month:

- **Parameter** — the name in the `def` line. `amount`. It's a placeholder; it has no value yet.
- **Argument** — the actual value you pass at the call. `50`.

`amount` becomes `50` for the duration of that one call, and then it's gone.

```python
def greet(first_name, last_name):
    return f"hello, {first_name} {last_name}"

greet("jude", "hill")
```

Two parameters, two arguments, matched **by position**. Pass one argument and Python stops you:
`TypeError: greet() missing 1 required positional argument: 'last_name'`. Pass three and it stops
you the same way. That is the language being loud, which is the property you want.

---

## 2. `return` — and the thing that is about to bite you

This is the section to read twice.

`return` does two things at once:

1. It **ends the function immediately.** Nothing after it in that function runs.
2. It **hands a value back** to whoever called it.

That second one is the part that's easy to say and hard to feel. The value doesn't get printed, it
doesn't get saved, it doesn't go anywhere on its own. It gets handed back, and it's the caller's job
to catch it:

```python
total = add_vat(50)     # catch it in a name
print(add_vat(50))      # or hand it straight to something else
add_vat(50)             # or drop it on the floor — this line does nothing useful
```

### The default nobody tells you about

**A function with no `return` returns `None`.**

Not zero. Not an empty string. Not nothing-at-all. It returns the value `None`, every time,
silently.

```python
def show_vat(amount):
    print(amount * 1.2)

x = show_vat(50)
print(x)
```

That prints `60.0` and then `None`. The first line is the `print` *inside* the function doing its
job. The second is `x` — which holds what `show_vat` handed back, and `show_vat` handed back
nothing, so `x` is `None`.

Stop on this. Yesterday you read `None` as "the account is empty", and the correction was that
`None` means **"no answer"** — we don't know, there's nothing here, the question wasn't answered.
Today that exact meaning arrives as a language default, unannounced, in the construct you're
learning. A function that forgets to return doesn't crash and doesn't complain. It hands back "no
answer" and your program carries on holding it.

This is your silent-wrongness pattern with a `def` in front of it. The reason it's worth a whole
section is that you will write it accidentally within the week, and it will look fine.

### `return` vs `print` — not the same thing, not close

The single most common L0 confusion, and the one that makes the 15 August session impossible if it
isn't dead by then.

```python
def add_vat_a(amount):
    print(amount * 1.2)      # shows a human a number

def add_vat_b(amount):
    return amount * 1.2      # hands a value to the program
```

`add_vat_a(50) * 2` is an error — you can't multiply `None` by 2. `add_vat_b(50) * 2` is `120.0`.

`print` talks to a person. `return` talks to the rest of the program. When the model calls your
`run_sql()` in a fortnight, there is no person in the loop — a `print` goes into the void and the
model receives `None`. **Functions return. Only the outermost layer prints.**

### `return` stops everything

```python
def check(n):
    return n * 2
    print("never runs")
```

That `print` is unreachable. Not a warning, not an error — just dead. Useful, and section 5 makes it
load-bearing.

---

## 3. Say the type out loud

New rule, and it applies to every function you write from today: **before you write the body, say
what type goes in and what type comes out.** Out loud, using the real words: `int`, `float`, `str`,
`bool`, `None`, `list`.

> `add_vat` takes a `float` and returns a `float`.
> `is_read_only` takes a `str` and returns a `bool`.
> `greet` takes two `str` and returns a `str`.
> `show_vat` takes a `float` and returns **`None`** — which is the tell that it should have been a
> `return`.

Two reasons this isn't pedantry. First, yesterday "integer" was doing service as a general-purpose
word for "value" — you called the string `"False"` an integer twice. That's survivable while you're
reading code, and fatal once you're debugging it, because `type()` is your main tool and it tells
you nothing if `int` and `str` are the same word in your head.

Second, on **7 August** you learn type hints, where this stops being a habit and becomes syntax:

```python
def add_vat(amount: float) -> float:
    return amount * 1.2
```

You'll write that in a week. Saying it out loud now means the notation lands as a label for
something you already do, rather than as a new thing to memorise.

---

## 4. Defaults and keyword arguments

A parameter can carry a fallback:

```python
def add_vat(amount, rate=0.2):
    return amount * (1 + rate)

add_vat(50)            # 60.0  — uses the default
add_vat(50, 0.05)      # 52.5  — overrides it
add_vat(50, rate=0.05) # 52.5  — same, but you can see what 0.05 means
```

That last form is a **keyword argument**. Once a call has more than two arguments, positional order
becomes a thing you have to remember and therefore a thing you can get wrong; naming them at the
call site costs four characters and removes the class of bug. Parameters with defaults must come
after the ones without.

**One trap, mentioned now so it's not a surprise later:** never use a list or a dict as a default
value (`def f(items=[])`). The default is created *once*, when the function is defined, and shared
by every call — so it accumulates. You'll meet lists properly tomorrow; for now just know the rule
and don't do it.

---

## 5. Bad input: hand back `None`, or refuse?

Here is the choice functions give you that scripts didn't, and it's the argument you and I have
been having for two days in different costumes.

```python
def divide(a, b):
    if b == 0:
        return None          # option 1: hand back "no answer"
    return a / b
```

```python
def divide(a, b):
    if b == 0:
        raise ValueError("cannot divide by zero")   # option 2: refuse, loudly
    return a / b
```

Option 1 doesn't crash. Option 2 stops the program with a message naming exactly what went wrong
and exactly where.

Your instinct so far — three times in two days now, across two subjects — has been to reach for
option 1, because option 2 "crashes". Run that forward. `divide(10, 0)` returns `None`. That `None`
gets added to a total, or written to a report, or handed to a model. Nothing errors. Somewhere
downstream a number is wrong, or a sentence is confidently false, and there is no line number
attached to it and nothing in the log. You find it, if you find it, three weeks later, by noticing
the answer looks odd.

Option 2 costs you one loud failure at 3am and a stack trace pointing at the line. That is not the
expensive option. **The absence of an error message is not a safety property** — it's the absence
of a smoke alarm, and this is the argument the entire eval harness rests on. In four weeks you'll
build a harness whose only job is to make wrongness announce itself, and it will feel obvious then
because of decisions like this one.

`raise ValueError("message")` is the whole syntax. There are other error types; `ValueError` covers
"you gave me something I can't work with" and is right nine times in ten.

There is a legitimate use for returning `None` — "I looked, and there genuinely isn't one." A
lookup that finds no matching customer returns `None` honestly. The test is whether the absence is
**an answer** or **a failure**. No matching customer is an answer. Dividing by zero is a failure.

---

## 6. Guard clauses, and the end of the staircase

Yesterday's notes promised this and deliberately didn't chase it: you wrote nested `if`s and felt
the indentation march right across the screen.

```python
def process(order):
    if order is not None:
        if order["amount"] > 0:
            if order["status"] == "confirmed":
                return order["amount"] * 1.2
            else:
                return None
        else:
            return None
    else:
        return None
```

Four levels deep, and the actual work is the one line at the bottom. Every reader has to hold three
open conditions in their head to reach it.

Because `return` exits immediately, you can invert it — **check the bad cases first, leave early,
and let the main path sit unindented**:

```python
def process(order):
    if order is None:
        raise ValueError("no order given")
    if order["amount"] <= 0:
        raise ValueError("amount must be positive")
    if order["status"] != "confirmed":
        raise ValueError("order is not confirmed")

    return order["amount"] * 1.2
```

Those first three are **guard clauses**. Same logic, and now: each failure names itself, the happy
path is one unindented line at the bottom, and adding a fourth condition means adding a line rather
than another level of nesting.

Notice the two corrections met in one shape. The staircase collapses, *and* the silent `None`s
become loud refusals. That isn't a coincidence — deep nesting and silent failure come from the same
instinct, which is trying to make the function cope with everything rather than saying what it
requires.

---

## 7. Docstrings, briefly

A string on the first line of the body is a **docstring** — the function's own description of
itself.

```python
def add_vat(amount, rate=0.2):
    """Return amount with VAT added at rate (default 20%)."""
    return amount * (1 + rate)
```

Worth thirty seconds per function. Two reasons beyond tidiness: `help(add_vat)` prints it, and on
15 August the docstring is **literally what the model reads to decide whether to call your
function**. Bad docstring, wrong tool call. Start the habit now; the payoff has a date on it.

---

## 8. Predict before you run

Cold, on paper, before typing anything. Write the answer *and* the type.

```python
# 1
def f(x):
    x * 2
print(f(3))

# 2
def g(x):
    return x * 2
    return x * 3
print(g(3))

# 3
def h(name="world"):
    return f"hello, {name}"
print(h())
print(h("jude"))

# 4
def k(a, b=1):
    return a - b
print(k(10, 3))
print(k(b=3, a=10))

# 5
total = 0
def bump():
    total = total + 1
    return total
print(bump())

# 6
def describe(n):
    if n > 0:
        return "positive"
    if n < 0:
        return "negative"
print(describe(0))

# 7
def shout(text):
    print(text.upper())
result = shout("hello")
print(result)

# 8
def area(w, h):
    return w * h
print(area("ab", 3))
```

Number 5 will error, and the error is the point — bring your prediction of *which* error. Number 8
runs and returns something you may not expect; say what type it returns.

---

## 9. Exercises

In `practice/functions.py`. For each one, write the sentence "takes a ___, returns a ___" as a
comment above the `def` before you write the body.

1. **`add_vat(amount, rate=0.2)`** — returns the amount with VAT. Raise a `ValueError` if `amount`
   is negative. Call it three times: default rate, 5% rate passed positionally, 5% rate passed as a
   keyword.

2. **`account_message(balance)`** — yesterday's question, properly this time. Three states:
   balance is `None` (we couldn't load it), balance is `0`, balance is positive. Return the right
   sentence for each. Yesterday two branches were made to carry three states and the customer whose
   balance failed to load got told their account was empty. Write it so that can't happen.

3. **`is_read_only(sql)`** — takes a `str`, returns a `bool`. `True` only if the query starts with
   `select` (any capitalisation) and contains none of `drop`, `delete`, `update`, `insert`. This is
   a real guardrail from your capstone, four weeks early. Test it with:
   `"SELECT * FROM orders"`, `"select 1"`, `"DROP TABLE orders"`, `"select * from t; drop table t"`.
   The last one is the interesting one — say out loud whether your function catches it before you
   run it.

4. **`grade(score)`** — takes a number, returns a `str`. Refactor the warm-up chain into a function
   with guard clauses: raise `ValueError` for anything below 0 or above 100, then the grade. Call it
   with `72`, `59.5`, `-4`, `101`.

5. **Rewrite this with guard clauses**, no nesting, each failure loud:

```python
def ship(order):
    if order is not None:
        if order["paid"]:
            if order["address"] != "":
                return "shipped"
            else:
                return None
        else:
            return None
    else:
        return None
```

Paste back the file and the terminal output, together, unedited. Including whatever went red.

---

## Summary

- `def name(params):` defines; `name(args)` calls. Defining runs nothing.
- **A function with no `return` returns `None`** — silently. "No answer", not zero.
- `return` hands a value to the program and exits immediately. `print` shows a human. Not the same.
- Say the types out loud before writing the body: `int`, `float`, `str`, `bool`, `None`.
- Defaults go last; name your arguments at the call site once there's more than two.
- On bad input, **refuse loudly** (`raise ValueError`) rather than hand back a quiet `None`.
  Return `None` only when absence is an honest answer.
- Guard clauses first, happy path last and unindented.

Tomorrow (Sat, 10:00–12:30): **L1.1 — lists and tuples.** Holding many things instead of one.
