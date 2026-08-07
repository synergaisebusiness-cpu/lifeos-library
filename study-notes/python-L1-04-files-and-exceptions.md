# Python L1.4 — Files and Exceptions

*Lloyds study · deep block · Friday 7 August 2026 · read time ~14 min · notes before questions*

Same loop. Read once through, then again with VS Code open, typing the examples.

This is the last rung of L1, and it is the one where the week's theme stops being a moral and
becomes syntax. You have spent nine days learning to distrust the quiet wrong answer — `None` off
the end of a branch, `"ababab"` from a function called `area`, a guardrail approving `DROP TABLE`.
Exceptions are Python's machinery for making failure loud, and `try`/`except` is the tool that can
switch it back off. Today you learn both, and — more importantly — when you're allowed to use the
second one.

---

## Why this rung matters more than it looks

Everything your capstone needs lives in files. The golden set of English-question/SQL pairs you're
building at 16:30 every day — that's a file the eval harness reads. Your API key on Monday — a file
the code loads and must never print. Every eval run's results — files. And every one of those reads
can fail: the file isn't there, the path is wrong, a line is blank where a number should be. What
your program does in that moment — crash with a message naming the problem, or carry on with
invented data — is the entire difference between an eval harness you can trust and one that lies
to you. You've been arguing for the crash all week. Today you get the tools.

---

## 1. Reading a file

```python
with open("data/cities.txt") as f:
    content = f.read()

print(content)
```

`open()` gives you a file object; `.read()` gives you the whole file as one `str`. The `with` block
is the part that matters: when the indented block ends, Python closes the file for you — even if
something inside raised. Files left open are the classic *works now, breaks later* bug: fine on
your machine, until the day something holds hundreds open.

**Rule, not option: `with open(...)` every time.** You will see `f = open(...)` / `f.close()` in
older code online. Know what it means, never write it.

One gotcha worth meeting today rather than on the 13th: the path is relative to **where you run
the file from**, not where the `.py` file sits. Run from `~/code/lloyds-prep` (which the VS Code
▶ button does) and `"data/cities.txt"` means `~/code/lloyds-prep/data/cities.txt`.

---

## 2. Lines, and the invisible character on the end

Files are usually line-shaped, and you'll almost always want the lines:

```python
with open("data/cities.txt") as f:
    for line in f:
        print(line)
```

Looping over the file object gives you one line at a time. But run that and the output is
double-spaced — because every `line` still carries its `\n`, the invisible newline character that
ends it, and `print` adds another.

```python
line.strip()      # "Manchester\n" -> "Manchester"   (also trims spaces both ends)
```

Remember `"distinction "` with the trailing space? Same creature. `"Manchester\n" ==
"Manchester"` is `False`, silently, and on 24 August your eval scoring is literally
`model_answer == golden_answer`. **`.strip()` every line you read** is the habit that stops that
bug existing.

If you want all the lines at once: `f.read().splitlines()` gives you a list of strings with the
newlines already removed. That's usually the tidiest.

---

## 3. Writing files — and the mode letter that can erase your data

```python
with open("results/run1.txt", "w") as f:
    f.write("accuracy: 0.85\n")
```

The second argument is the **mode**. `"r"` is read and is the default. The other two:

- `"w"` — write. Creates the file if missing. **If it exists, its contents are gone the instant
  the file opens.** No warning, no error, no undo.
- `"a"` — append. Creates if missing, otherwise adds to the end.

Read that middle one again. `"w"` on the wrong filename is a completely silent, completely
destructive operation — the program runs clean, prints nothing, and your golden set is now empty.
It is the purest costume the theme owns: a one-character choice, no crash, real damage. The habit
that protects you is boring: stop at every `open(..., "w")` and say out loud what happens if that
file already exists.

`.write()` writes exactly what you give it — no automatic newline. You supply the `\n`.

---

## 4. Reading a traceback properly — this section is the payoff

Ask for a file that isn't there:

```python
with open("data/citties.txt") as f:
    content = f.read()
```

```
Traceback (most recent call last):
  File "/Users/judehill/code/lloyds-prep/practice/files_demo.py", line 1, in <module>
    with open("data/citties.txt") as f:
         ~~~~^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: 'data/citties.txt'
```

You've been reading these all week by looking where the caret points. Today, the anatomy, once and
properly — read it **bottom-up**:

1. **Last line first.** `FileNotFoundError: ... 'data/citties.txt'`. The exception's *name* is the
   diagnosis and the message names the exact evidence — there's the typo, in quotes.
2. **The line above it** shows where Python *noticed*. That is a fact about Python, not about your
   mistake — on 31 July the message said line 45 and the caret sat on line 48, and the caret won
   six times. The sentence is what's wrong; the caret is where it surfaced.
3. **The stack above that** is the trail of calls that led there, top-down. One entry today;
   the day your agent calls `run_sql` which calls `open`, it's the map of how you got there.

The exception name is a real thing you can catch by name — `FileNotFoundError`, `ValueError`,
`KeyError`, `TypeError`. You've already met all four. That name is about to matter.

---

## 5. `try` / `except` — catching, and the licence it needs

Sometimes a failure is *expected*, and crashing is the wrong response. First run of the eval
harness, no results file exists yet — that's not a disaster, that's Tuesday:

```python
def load_previous_results(path):
    # takes a str path, returns a list of result lines (empty on first run)
    try:
        with open(path) as f:
            return f.read().splitlines()
    except FileNotFoundError:
        return []
```

`try` runs the block. If nothing raises, `except` never runs. If the named exception is raised,
Python jumps to the `except` block instead of crashing. Anything *else* still crashes loudly —
which is exactly what you want.

Three rules, and they are the whole skill:

- **Catch the specific exception, by name.** The one you expected, only.
- **Catch it only if you have something true to do about it.** Here, an empty list is *true* — no
  previous results genuinely means an empty history. It is not a made-up `0`, not a shrug.
- **Everything else stays loud.** If the file exists but is unreadable garbage, this function
  crashes — correctly.

Now the version you must never write:

```python
try:
    balance = acount["balance"]      # typo'd name — NameError
    print(f"Balance: {balance}")
except:
    print("Balance unavailable")
```

Bare `except:` catches **everything** — including the `NameError` that is a bug in *your code*,
nothing to do with missing data. The typo now produces a polite message instead of a traceback,
forever. This is the smoke-alarm remover: one keyword, and no failure in that block can ever reach
you again. You chose the silent bug over the crash once, on 30 July, as a preference. Bare
`except` is that preference as a language feature. Never bare, never `except Exception` as a
reflex — always the name.

---

## 6. `raise` and `except` are two ends of one design

You've been writing `raise ValueError("amount must be positive")` since L0.3. Today completes the
thought: **deep code raises, the edge decides.**

The function that spots the problem almost never knows what the right response is — that depends
on who called it. So the guard clause raises, loudly, with a message naming the problem. The code
at the boundary — the top loop, the thing talking to the user — is the only place with enough
context to catch, and it catches *by name*, handling only what it genuinely can:

```python
# deep: knows HOW to detect, not what to do about it
def run_sql(sql):
    if not is_read_only(sql):
        raise ValueError(f"refusing non-read-only query: {sql}")
    ...

# edge: knows what the user should see
try:
    result = run_sql(generated_sql)
except ValueError as err:
    print(f"Query refused: {err}")
```

`as err` gives the exception a name so the message travels. That pair — `run_sql` raising,
the agent loop catching and refusing politely — is, almost line for line, the guardrail structure
of your capstone. You wrote the raising half a week ago. Now you own both.

---

## Exercises — live, together

In `practice/files_exceptions.py` unless the step says otherwise. Numbered steps; reasoning stays
up here in the notes.

1. Make a folder `data/` in `lloyds-prep`. In VS Code create `data/cities.txt` with four city
   names, one per line. Read it and print each line — first without `.strip()`, then with. Say
   what the difference on screen is and why.
2. Change the filename in your code to one that doesn't exist. Run it. Read the traceback out
   loud, bottom-up: the exception name, the evidence in the message, the line where Python
   noticed. Then fix it.
3. Write `data/scores.txt`: five numbers, one per line, and make one line blank. Write
   `read_scores(path)` — takes a `str` path, returns a `list` of `int`s, skipping blank lines.
   (`int("42\n")` copes with the newline; `int("")` does not — decide the order of your steps.)
4. Append a summary line to `results/log.txt` using `"a"` — then run the file twice and look at
   the file. Say why `"w"` would have been wrong here, and what it would have done.
5. Wrap your `read_scores` call for the missing-file case: first run of the harness, no scores
   yet. Decide what the caller gets — and defend it against the alternative of returning `[0]`.
6. Sabotage: take working code, add a deliberate typo'd variable inside a `try`, and put a bare
   `except:` under it printing `"no data today"`. Run it. Look at how completely the bug
   disappears. Then narrow the `except` to the exception you actually meant and watch the typo
   come back — loudly. That before/after is the whole argument.

---

## Reps — last 15 minutes, in the room, unassisted

Marked on the spot. L1.4 isn't logged as climbed until they're marked — and the L1 checkpoint
comes first, cold, before the reps.
