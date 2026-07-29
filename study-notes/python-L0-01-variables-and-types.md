# Python L0.1 — Variables and Types

*Lloyds study · deep block · 29 July 2026 · read time ~20 min*

These are the notes to read before we talk. Read them once through without stopping, then a
second time with a terminal open, typing the examples yourself. Don't copy-paste — typing is
where the errors happen, and the errors are the lesson. Mark anything that doesn't land and
bring it back to the session.

---

## Why this rung matters more than it looks

Variables and types sound like the boring gate you walk through to get to the real stuff. They
aren't. Almost every bug you'll hit in the next five weeks — and a decent share of the ones you'll
hit at Lloyds — is a type bug wearing a disguise. A model returns the string `"42"` and your code
tries to add it to a number. A SQL query hands back `None` where you expected a value. A price
comes out of an API as text and gets sorted alphabetically, so £9 lands above £100.

Your capstone is a chain of type conversions: a user's question (text) → a model response (text
that's supposed to be JSON) → structured data → SQL (text) → query results (numbers, dates,
nulls) → a written answer (text again). Every arrow in that chain is a place where a type is
wrong. Getting solid here is not throat-clearing; it's the thing.

---

## 1. What a variable actually is

Most tutorials say a variable is "a box you put a value in." That model is wrong and it will
mislead you within a fortnight. Here's the accurate one.

In Python, a value lives somewhere in memory. A variable is a **name that points at a value**.
Assignment doesn't put a thing into a box — it attaches a label to a thing.

```python
price = 42
```

Read that as: *create the value 42, then point the name `price` at it.* The `=` is not
mathematical equality and it's not a claim that two things are equal. It's an instruction, and it
runs right-to-left: work out the right-hand side, then bind the name on the left to the result.

This is why the following is not a paradox:

```python
count = 5
count = count + 1
```

Line two reads: take whatever `count` currently points at (5), add 1 to get 6, then re-point the
name `count` at 6. In maths `count = count + 1` is nonsense. In Python it's an instruction, and
it's one of the most common lines you'll ever write.

The label model also explains something the box model can't:

```python
a = 10
b = a
a = 99
print(b)   # 10, not 99
```

`b = a` pointed `b` at the value `a` was pointing at — the number 10. Re-pointing `a` afterwards
doesn't drag `b` along. Two labels on the same value; moving one label moves nothing else.

Hold onto this. When you get to lists at L1 this same model produces behaviour that genuinely
surprises people, and you'll already have the right mental picture.

### Naming

Python's rules: letters, digits and underscores; can't start with a digit; case-sensitive
(`total` and `Total` are different names); can't be one of Python's reserved words (`if`, `class`,
`for`, `None`, and so on).

The convention — and conventions matter, because at Lloyds your code gets read by other people —
is `snake_case`: lowercase words joined by underscores.

```python
customer_count = 1_240        # good (and yes, underscores in numbers are legal and readable)
customerCount = 1240          # works, but that's JavaScript's convention, not Python's
c = 1240                      # works, means nothing to the person reading it in March
```

The real rule: a name should say what the value *is*, so the line reads like a sentence. You are
writing for the next person, and about a month from now the next person is you.

---

## 2. The core types

Every value in Python has a type. The type determines what you're allowed to do with the value.
There are five you need cold at this level.

### `int` — whole numbers

```python
customers = 1240
temperature = -5
```

No size limit worth worrying about — Python integers grow as large as your memory allows, which
is unusual among languages and occasionally useful.

### `float` — numbers with a decimal point

```python
conversion_rate = 0.034
average_basket = 42.5
```

The name is short for "floating-point," which describes how the computer stores them. More on why
that matters in section 4 — it's the one genuinely surprising thing in these notes.

### `str` — text, called a "string"

```python
name = "Jude"
question = 'How many orders were placed last month?'
```

Single or double quotes, no difference in meaning — pick one and stay consistent. Use the other
when your text contains a quote: `"it's fine"` avoids a fight.

The critical point: **`42` and `"42"` are different values of different types.** One is a
quantity, the other is two characters of text that happen to look like a quantity. Confusing them
is the single most common beginner bug, and it doesn't stop being common when you're
professional — it just gets better disguised.

### `bool` — true or false

```python
is_active = True
has_errors = False
```

Capital T, capital F. These are the answers to yes/no questions and they're what every `if`
statement ultimately runs on. Comparisons produce them:

```python
5 > 3        # True
5 == 3       # False
```

Note `==` for comparison versus `=` for assignment. One equals sign gives a name to a value; two
equals signs asks whether two values are the same. Mixing these up is a rite of passage.

### `None` — the absence of a value

```python
result = None
```

`None` is Python's way of saying "there is deliberately nothing here." It is *not* zero, *not* an
empty string, and *not* False — it's the explicit representation of nothing. It's also what a
function hands back when it doesn't return anything, and it's what you'll see constantly when
data is missing.

This one matters for you specifically. When your agent runs SQL and a column has no value, that
arrives in Python as `None`. Handling `None` well is a large fraction of what "reliability"
means in your job description.

### Asking what type something is

```python
type(42)          # <class 'int'>
type(42.0)        # <class 'float'>
type("42")        # <class 'str'>
type(True)        # <class 'bool'>
type(None)        # <class 'NoneType'>
```

`type()` is your first debugging tool. When something behaves strangely, printing the type of the
thing involved solves the mystery a genuinely surprising share of the time. Get in the habit now.

---

## 3. Dynamic typing — and the bridge to SQL

Here's a distinction worth holding, because you're climbing the SQL ladder in parallel and the
two languages disagree on this.

In SQL, the **column** has the type. A column declared `INT64` will hold integers and nothing
else; the database enforces it, and it enforces it before your data ever arrives.

In Python, the **value** has the type and the name does not. A name can point at an integer now
and a string ten lines later, and Python won't stop you:

```python
x = 42
x = "forty-two"    # perfectly legal
```

This is called dynamic typing. It makes Python fast to write and it makes it easy to write
something that explodes at three in the morning. Python checks types when the line *runs*, not
before — so a type error hides quietly in a branch of code until the day that branch executes.

The professional answer to this is type hints, which is Python L3 on your ladder, and tests, which
is L4. For now, just internalise the trade-off: the language is trusting you, and trust has to be
earned with discipline rather than assumed.

---

## 4. The float thing (read this twice)

Type this into a terminal:

```python
0.1 + 0.2
```

You get `0.30000000000000004`.

This is not a bug in Python. It happens in essentially every mainstream language, and the reason
is that floats are stored in binary. Some decimal fractions have no exact binary representation —
in the same way that 1/3 has no exact decimal representation, and 0.333... never quite closes the
gap no matter how many digits you write. The computer stores the closest value it can, and the
tiny error surfaces when you add.

Two consequences you should carry from today.

**Never test floats for exact equality.**

```python
0.1 + 0.2 == 0.3     # False
```

That line is False, and if you'd written it as a check in a program it would have failed a test
that was actually correct. Compare with a tolerance instead, or avoid the situation.

**Never store money as a float.** This one is directly relevant to where you're about to work.
Financial code represents money either as integer pence — `1250` meaning £12.50 — or with
Python's `Decimal` type, which does base-10 arithmetic exactly. A rounding error of a
hundred-millionth of a penny is a curiosity in a demo and an audit finding in a bank.

You don't need `Decimal` yet. You do need to have heard this before someone senior mentions it,
so it lands as recognition rather than news.

---

## 5. Working with strings

Strings are the type you'll touch most, because every question your agent receives and every
answer it gives is text.

**Joining:**

```python
first = "Jude"
greeting = "Hello, " + first     # "Hello, Jude"
```

The `+` works only between two strings. `"Hello, " + 42` raises a `TypeError`, because Python
refuses to guess whether you meant text-joining or arithmetic. This strictness is a feature; some
languages guess, and their bugs are worse.

**f-strings** — the modern way, and the one to use:

```python
name = "Jude"
count = 1240

message = f"{name} found {count} customers."
# "Jude found 1240 customers."
```

The `f` before the quote turns on substitution, and anything inside `{}` gets evaluated and
dropped in as text. You can put real expressions in there:

```python
f"That's {count * 2} after doubling."
f"Average: {total / n:.2f}"        # the :.2f formats to two decimal places
```

f-strings will be how you build prompts for the model and how you format the answers that come
back. You'll use them daily.

**A few methods worth knowing now:**

```python
q = "  How many orders?  "

q.strip()        # "How many orders?"  — removes surrounding whitespace
q.lower()        # lowercases
q.upper()        # uppercases
len(q)           # 21 — length, including the spaces
"orders" in q    # True — substring check
```

`.strip()` in particular: user input arrives with stray whitespace constantly, and stripping it is
the cheapest reliability win there is.

Note the shape `thing.method()` — a dot, a name, then brackets. That's you asking a value to do
something to itself. `len()` is different: it's a standalone function that takes the value as an
argument. Both patterns are everywhere; the difference will stop being noticeable within a week.

---

## 6. Converting between types

Since types don't mix freely, you convert deliberately:

```python
int("42")        # 42      — text to whole number
float("42.5")    # 42.5    — text to decimal
str(42)          # "42"    — number to text
int(42.9)        # 42      — note: truncates toward zero, does NOT round
round(42.9)      # 43      — this is how you round
bool(0)          # False
bool("")         # False
bool("anything") # True
```

Two traps.

`int()` on a float chops the decimal off rather than rounding — `int(42.9)` is 42, not 43. If you
want rounding, ask for it.

Conversion fails loudly when it can't work:

```python
int("forty-two")     # ValueError: invalid literal for int() with base 10: 'forty-two'
int("42.5")          # ValueError too — int() won't parse a decimal point
```

That second one catches people. `"42.5"` has to go through `float()` first.

Loud failure is the right behaviour. A language that silently turned `"forty-two"` into 0 would
hand you a report full of zeros and no indication anything went wrong.

---

## 7. Reading errors

You will see far more errors than working output, forever. This is normal and it is not a signal
about your ability. Errors are Python telling you precisely what's wrong, in a format that looks
hostile for about a week and then becomes the fastest debugging tool you have.

The three you'll meet at this level:

**`NameError`** — you used a name that doesn't exist. Usually a typo, or you never assigned it, or
you assigned it in a line you didn't actually run.

```python
print(totl)     # NameError: name 'totl' is not defined
```

**`TypeError`** — the types are wrong for the operation. The classic:

```python
"Total: " + 42  # TypeError: can only concatenate str (not "int") to str
```

Fix: `"Total: " + str(42)`, or better, `f"Total: {42}"`.

**`ValueError`** — right type, impossible value. `int("forty-two")` above.

How to read a traceback: **start at the bottom.** The last line names the error type and gives the
message in English. The line above shows the actual line of your code that failed. Everything in
between is the chain of calls that got you there, and at this level you can usually ignore it.
Bottom line first, then the line number. That's the whole technique.

---

## The exercises

Do these in a terminal. Type them; don't paste. Getting an error is a correct outcome — record
what it said, because we'll go through them in the session.

Open a terminal and run `python3` to get an interactive prompt, where each line runs as you press
enter. If `python3` isn't found, tell me and we'll sort the install in the session.

**1. Prediction before execution.** For each line below, write down what you think it produces
*before* you run it. Then run it. Where you were wrong is where the learning is — keep those.

```python
type(7)
type(7.0)
type("7")
7 + 7
"7" + "7"
7 == 7.0
"7" == 7
int("7") + 7
```

**2. The name-pointing model.** Predict, then run:

```python
a = 5
b = a
a = 12
print(a)
print(b)
```

Explain in one sentence why `b` is what it is, using the word "points."

**3. Build a summary line.** Create three variables — a product name (string), a quantity (int),
and a unit price (float). Using a single f-string, print a sentence like:

`Oat milk: 3 units at £1.29 each, total £3.87`

The total must be **calculated**, not typed in, and shown to exactly two decimal places.

**4. Break it deliberately, then fix it.** Write a line that raises a `TypeError` by adding a
string to a number. Record the exact message. Then fix it two different ways — once with `str()`,
once with an f-string.

**5. The float trap.** Run these and record what you get:

```python
0.1 + 0.2
0.1 + 0.2 == 0.3
round(0.1 + 0.2, 2) == 0.3
```

Then answer in one or two sentences: why would storing a customer's account balance as a float be
a bad idea at a bank?

---

## What we'll do in the session

You bring your answers and any errors. We go through the predictions you got wrong first — those
are the highest-value minutes. Then a few questions from me to check the model has landed rather
than the syntax, and if that's clean, control flow is tomorrow's block.

There's no checkpoint today. The Python L0 checkpoint is the CSV summary script, and you attempt
that cold once variables, control flow and functions are all taught — that's what "attempt first,
no tutorial" is protecting. Today is notes and reps.
