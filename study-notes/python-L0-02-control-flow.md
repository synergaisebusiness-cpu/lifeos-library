# Python L0.2 — Control Flow

*Lloyds study · deep block · Thursday 30 July 2026 · read time ~20 min · notes before questions*

Same loop as yesterday. Read these once through without stopping, then a second time with a
terminal open, typing the examples. Don't paste — typing is where the errors happen and the errors
are the lesson. Mark anything that doesn't land; bring it back to the session.

You're on poor sleep today, so the plan is deliberately smaller than usual. One concept —
**making a decision in code** — and we go slower than feels efficient. If we finish the exercises
and nothing else, today was a success.

---

## Before you read: the 2-minute warm-up

Do this first, in the REPL, before the notes. It's hygiene, not a test, and nothing depends on
getting it right.

1. Retype yesterday's summary line from scratch, with **lowercase snake_case names throughout** —
   `product_name`, `quantity`, `unit_price`, `total`. Don't look at yesterday's version.
2. Run `0.7 * 3`. Then run `f"{0.7 * 3:.2f}"`. Look at the two outputs side by side.

Keep both outputs; paste them into the session with your exercise answers.

---

## Why this rung matters more than it looks

Yesterday you learned how to hold a value. Today you learn how to **branch** — how a program does
one thing in one situation and something else in another. That is the entire difference between a
calculator and a program.

It matters more than usual for where you're going. Every guardrail in your capstone is a branch: *if
the model's SQL contains anything but `SELECT`, refuse to run it.* Every eval score is a branch: *if
the answer matches the golden answer, count it correct; if the tool returned nothing, count it a
refusal, not a wrong answer.* Every piece of data handling is a branch: *if this value is missing,
do X.* When the plan file says "never cut the eval harness," the harness it means is mostly a pile
of carefully-ordered `if` statements. This rung is where that starts.

There's a second reason. Control flow is the first place Python's **layout is part of its grammar**.
Up to now you could write lines in any style and they'd run. From today, whitespace changes meaning.
That trips people once, hard, and then never again.

---

## 1. The shape of a decision

Here is the whole idea in four lines:

```python
temperature = 4

if temperature < 10:
    print("Cold")
```

Read it as: *evaluate the thing after `if`. If it comes out True, run the indented block. If not,
skip it.*

Three parts, and all three are required:

- the keyword `if`
- a **condition** — an expression that produces `True` or `False`
- a **colon**, then an indented **block** of one or more lines

### Indentation is syntax, not style

The indented lines are the body. Python decides what's inside the `if` purely by how far the line is
indented. In most languages that's cosmetic and curly braces do the real work; in Python there are
no braces, so the whitespace *is* the structure.

```python
if temperature < 10:
    print("Cold")          # inside the if — only runs when the condition is True
print("Done")              # outside the if — runs every time
```

The convention, and effectively the rule: **four spaces per level.** Not a tab, not two spaces, not
sometimes-three. Mixing them is the single most common way to make a file that looks fine and
refuses to run.

This is worth connecting to your standing correction about names. Same instinct, different surface:
Python does not care what you *meant*, only what you *typed*. A capital letter where you wanted
lowercase gives you a `NameError`; three spaces where you wanted four gives you an
`IndentationError`. Neither is a comment on your understanding. Both are the language being exactly
literal, which is the property that makes it worth trusting.

### `else` — the other road

```python
temperature = 22

if temperature < 10:
    print("Cold")
else:
    print("Not cold")
```

`else` takes no condition — it's "in every other case." Exactly one of the two blocks runs. Never
both, never neither.

### `elif` — more than two roads

`elif` is short for "else if". You can have as many as you like.

```python
temperature = 22

if temperature < 10:
    print("Cold")
elif temperature < 20:
    print("Mild")
elif temperature < 30:
    print("Warm")
else:
    print("Hot")
```

**The most important sentence in these notes: Python checks the conditions top to bottom and stops
at the first one that is True.** Everything below the winner is skipped without being evaluated at
all.

That's why the example above works with `<` on every line and no upper bounds. By the time Python is
testing `temperature < 20`, it already knows `temperature < 10` was False — so "under 20" can only
mean 10-to-19. The earlier tests do the lower-bound work for you.

And it's why **order changes behaviour**. Reverse those branches:

```python
if temperature < 30:
    print("Warm")
elif temperature < 10:
    print("Cold")
```

Now `temperature = 4` prints `Warm`. The `Cold` branch is unreachable — it can never win, because
anything under 10 is also under 30 and the first test grabs it. The code is legal, runs without any
error, and is wrong. This is the flavour of bug this rung produces: no crash, just a quietly
incorrect answer. You will hit it for real when you write eval scoring bands.

If a chain of `if` / `elif` / `else` ends in `else`, exactly one branch always runs. If it has no
`else`, it's possible for none to run — which is often fine, but it should be a decision rather than
an accident.

---

## 2. Comparison operators

These are the expressions that produce the `True` / `False` that `if` needs. Six of them:

```python
5 == 5      # True   — equal to
5 != 3      # True   — not equal to
5 > 3       # True   — greater than
5 < 3       # False  — less than
5 >= 5      # True   — greater than or equal to
5 <= 4      # False  — less than or equal to
```

`==` versus `=` deserves saying twice, because it's yesterday's lesson wearing a new coat.

- `=` is **assignment**: point this name at that value. It changes the world.
- `==` is a **question**: are these two values the same? It changes nothing; it produces `True` or
  `False`.

Which brings your other standing correction straight into today's material. **A comparison is an
expression: it produces a value, it does not re-point a name.**

```python
count = 5
count > 3        # produces True. count is still 5.
count == 10      # produces False. count is still 5. Nothing was set to 10.
```

`count == 10` does *not* make `count` be 10 and does not attempt to. It asks a question and hands
back an answer. Modern Python will usually stop you if you write `if count = 10:` — that's a
`SyntaxError` — which is the language protecting you from a mistake that in older languages silently
destroyed data.

### Comparisons across types

You met most of this yesterday; it lands differently now that it's driving a decision.

```python
7 == 7.0         # True  — int and float compare by numeric value
"7" == 7         # False — a string is never equal to a number
"7" == "7.0"     # False — different text
```

That middle line is a trap you will meet for real. A CSV or an API hands you `"7"`, you write
`if value == 7:`, and the branch never fires. No error, no crash, just a condition that's False
forever. When a branch mysteriously never runs, **print the type of the thing you're comparing** —
`type(value)` — before anything else. Yesterday's habit, today's debugging tool.

Ordering comparisons across types are stricter. Python 3 refuses:

```python
"10" > 5         # TypeError: '>' not supported between instances of 'str' and 'int'
```

Good. Python 2 would have answered — with nonsense. This is the same design instinct as
`"Total: " + 42` raising rather than guessing.

Strings do compare with each other, though, and they compare **alphabetically**, character by
character:

```python
"apple" < "banana"    # True
"10" < "9"            # True  ← because "1" comes before "9"
```

That second one is the `max(["9","10","100"])` lesson from yesterday, in operator form. Text that
looks numeric does not sort numerically. This is exactly the £9-above-£100 bug from yesterday's
notes.

### Chaining

Python lets you write a range the way maths does, and it means what you'd hope:

```python
age = 25
18 <= age < 65        # True
```

Read as "18 is less than or equal to age, and age is less than 65." Most languages can't do this.
Use it — it's clearer than the `and` version.

### `is` versus `==`, briefly

`==` asks "same value?". `is` asks "the very same object in memory?" — same label pointing at the
same thing, in yesterday's picture.

You need exactly one rule at this level: **check for `None` with `is`.**

```python
result = None

if result is None:
    print("no result")
```

`is not None` for the opposite. Don't use `is` for numbers or strings; it appears to work
sometimes, which is worse than never working. Section 4 explains why the `None` check specifically
matters so much.

---

## 3. Logical operators — `and`, `or`, `not`

Three words, used to combine conditions. Python spells them as English words, not symbols.

```python
is_active = True
balance = 250

if is_active and balance > 100:
    print("eligible")
```

- `and` — True only if **both** sides are True
- `or` — True if **either** side is True (or both)
- `not` — flips it: `not True` is False

```python
True  and False    # False
True  or  False    # True
not True           # False
not (5 > 3)        # False
```

### The `or` trap — the one everybody writes

You want "if the status is either open or pending". The natural English shortens to:

```python
if status == "open" or "pending":       # WRONG
```

This runs. It never errors. And it's **always True**, whatever `status` is.

Why: Python reads it as `(status == "open") or ("pending")`. Two separate things joined by `or`. The
second thing isn't a comparison at all — it's just the string `"pending"`, sitting there. And a
non-empty string counts as True (section 4). So the whole condition is `something or True`, which is
True forever.

The fix is to say the comparison twice, or use `in`:

```python
if status == "open" or status == "pending":
    ...

if status in ("open", "pending"):        # cleaner, and the one to prefer
    ...
```

Note the shape of the bug. Legal syntax, no error, silently wrong answer — same family as the
mis-ordered `elif`. That family is the reason this rung gets a whole session.

### Precedence, and the brackets rule

`not` binds tightest, then `and`, then `or`. So:

```python
a or b and c        # means  a or (b and c)
```

Don't memorise it. **Use brackets whenever a condition has both `and` and `or` in it.** They cost
nothing, they remove all doubt, and they tell the next reader what you meant — and about a month
from now the next reader is you.

### Short-circuiting — and why you'll rely on it

Python evaluates left to right and **stops as soon as the answer is settled**.

- With `and`: if the left side is False, the answer is False regardless — so the right side is never
  evaluated.
- With `or`: if the left side is True, the answer is True regardless — so the right side is never
  evaluated.

This isn't trivia; it's a working pattern. It lets you put a guard on the left and the risky thing on
the right:

```python
if result is not None and result > 100:
    ...
```

If `result` is `None`, the left side is False, Python stops, and `result > 100` — which would raise a
`TypeError` on `None` — never runs. Swap the order and the same line crashes. You'll write this
shape constantly once your agent starts handling query results that may be empty.

---

## 4. Truthiness

Here's the part that surprises people, and the part that's most directly about your job.

`if` doesn't strictly require `True` or `False`. Give it any value at all and Python will decide
whether that value is "truthy" or "falsy".

The **falsy** values are a short list worth knowing cold:

```python
False
None
0
0.0
""          # empty string
[]          # empty list
{}          # empty dict
()          # empty tuple
```

Everything else is truthy. Any non-zero number, any string with characters in it — including
`"False"` and `"0"`, which are non-empty strings and therefore True — any list with items.

```python
bool(0)          # False
bool(42)         # True
bool("")         # False
bool("0")        # True   ← non-empty string
bool([])         # False
bool([0])        # True   ← the list has an item; what's in it doesn't matter
```

So this works, and it's idiomatic Python:

```python
rows = []

if rows:
    print("got data")
else:
    print("no rows")
```

`if rows:` reads as "if there are any rows". Prefer it to `if len(rows) > 0:` — shorter, and it's
what Python programmers expect to see.

### The trap: falsy is not the same as missing

This is the one to carry out of today.

```python
balance = 0

if balance:
    print("has a balance")
else:
    print("no balance")          # ← this runs
```

A balance of exactly zero is falsy, so `if balance:` treats a real, known, correct value of £0
identically to a value that never arrived. Those are different facts about the world, and in a bank
they're very different facts.

When you mean "did this value arrive?", ask that question exactly:

```python
if balance is not None:      # arrived — even if it's 0
    ...

if balance:                  # arrived AND is non-zero
    ...
```

Yesterday's notes said handling `None` well is a large fraction of what "reliability" means in your
job. This is the mechanics of it. Your SQL results will contain `0`, `None`, and `""`, they mean
three different things, and `if value:` flattens all three into "nope". Choose the question you
actually mean.

---

## 5. Nesting, and a word on flat code

Blocks can contain blocks:

```python
if is_active:
    if balance > 100:
        print("eligible")
```

That works, and sometimes nesting genuinely reflects the logic. But two levels deep is usually a
sign the condition wants combining instead:

```python
if is_active and balance > 100:
    print("eligible")
```

Same behaviour, one level, reads as a sentence. The general principle — and it's a real one, not
tidiness for its own sake: **deeply nested conditions are where bugs live**, because you have to hold
the whole stack of "we're in the case where..." in your head to read any single line. Flatter code
holds less.

Once you have functions tomorrow you get the better tool for this — check the bad cases first, return
early, and let the main path sit unindented at the bottom. Note it for tomorrow; don't chase it
today.

---

## 6. The errors of this rung

Three new ones join yesterday's `NameError`, `TypeError` and `ValueError`.

**`IndentationError`** — the layout doesn't parse.

```python
if temperature < 10:
print("Cold")
# IndentationError: expected an indented block after 'if' statement
```

You promised a block with the colon and didn't provide one. Also fires when levels are inconsistent
within a block. Almost always: check you're on four spaces, and that everything meant to be together
is at the same depth.

**`SyntaxError`** — usually the missing colon.

```python
if temperature < 10
    print("Cold")
# SyntaxError: expected ':'
```

Python 3.13's messages are unusually good; when it tells you what it expected, believe it.

**`TypeError` from a comparison** — as in `"10" > 5` above. In an `if`, this is nearly always a value
that arrived as text when you assumed a number. `type()` first, then fix.

Reading tracebacks is the same technique as yesterday: **start at the bottom.** Last line = what went
wrong, in English. Line above = the line of yours that did it. Ignore the middle at this level.

---

## The exercises

In the terminal, typed not pasted. Bring your answers *and* your errors — we go through the errors
first, and getting one is a correct outcome, not a failure.

Run `python3` for the interactive prompt. In the REPL, after a line ending in a colon you'll see
`...` — that's Python waiting for the indented block; type four spaces then the line, and press
enter on a blank line to finish the block. Writing these in a file instead is also fine if you
prefer.

**1. Prediction before execution.** Write down what each line produces *before* running it. Keep the
ones you got wrong — those are the session.

```python
5 == 5.0
"5" == 5
"10" > "9"
3 < 5 < 10
not 0
bool("False")
bool([])
True and False or True
```

**2. Bands.** Write an `if` / `elif` / `else` chain that takes a variable `score` and prints
`"fail"` under 40, `"pass"` from 40 to 59, `"merit"` from 60 to 79, and `"distinction"` from 80 up.
Test it with 39, 40, 79, 80, and 100.

Then answer in one sentence: why don't you need to write an upper bound on the `"pass"` branch?

**3. Break the ordering deliberately.** Take your working chain and move the `"distinction"` branch
to the top. Run it with `score = 39`. Record what it prints, and write one sentence explaining why —
using the word "first".

**4. The `or` trap.** Set `status = "closed"`, then run:

```python
if status == "open" or "pending":
    print("actionable")
else:
    print("not actionable")
```

Record what it prints. Explain in one sentence why, then rewrite the condition two ways so it's
correct — once with a second `==`, once with `in`.

**5. Falsy versus missing.** For each of these three values of `balance` — `0`, `None`, and `250` —
run both checks and record all six results:

```python
if balance:
    print("truthy")
else:
    print("falsy")

if balance is not None:
    print("arrived")
else:
    print("missing")
```

Then, in two or three sentences: which of the two checks would you want in code that decides whether
to send a customer a "your account is empty" message, and what goes wrong if you pick the other one?

**6. Short-circuit guard.** With `result = None`, run these two lines separately and record what
happens with each:

```python
result is not None and result > 100
result > 100 and result is not None
```

One works and one raises. Explain in one sentence why the order matters.

**7. Break the layout on purpose.** Write an `if` with no indented body, and an `if` with no colon.
Record both exact error messages. You want to have seen these deliberately once so that meeting them
by accident is recognition rather than alarm.

---

## What we'll do in the session

Your questions first — including anything in here you'd have written differently, or any sentence
you had to read twice. Then a few from me, aimed at the model rather than the syntax: I'm going to
ask you *why* the `elif` chain needs no upper bounds and *what's actually different* between
`if balance:` and `if balance is not None:`, because those two answers are the whole rung. Then
exercises, marked line by line, errors first.

No checkpoint today. The Python L0 checkpoint is the CSV summary script, attempted cold on Sunday
2 August once variables, control flow and functions are all taught. Today is notes and reps —
and a short day is fine.
