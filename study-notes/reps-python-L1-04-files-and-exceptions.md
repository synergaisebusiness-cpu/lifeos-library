# Reps — Python L1.4, Files and Exceptions

*Monday 10 August 2026 · ~15 min · unassisted · marked at the top of tomorrow's block*

Two reps and one explain-back. These target the two things Friday's model-check missed — the mode
letter, and what a bare `except:` does — so they're deliberately narrow rather than the full six
exercises from the notes.

Notes shut. No chat panel. A blank is data, a borrowed answer isn't.

**Predictions are a typed line, not a thought.** Every step that says *write your prediction* means
type it into the file as a comment before you run. Not because I need it — because the gap between
what you predicted and what happened is the entire lesson, and it evaporates if you don't pin it
down first.

---

## Rep 1 — The mode letter. `practice/reps_l1_04_modes.py` (~6 min)

**Step 1.** Type this:

```python
# I predict the file will contain: ____
with open("results/runs.txt", "a") as f:
    f.write("run\n")
```

Fill in the blank before you run anything.

**Step 2.** Run it. Open `results/runs.txt` and look.

**Step 3.** Run it twice more. Look again after each run. Update the comment with what's actually
there.

**Step 4.** Now change `"a"` to `"w"` — one character. Before you run it, type a second prediction
line:

```python
# I predict that after switching to "w" the file will contain: ____
```

**Step 5.** Run it once. Look at the file.

**Step 6.** Write, as a comment at the bottom: how many lines of data did that one character
destroy, and what — if anything — told you it had happened?

---

## Rep 2 — The sabotage. `practice/reps_l1_04_sabotage.py` (~6 min)

**Step 1.** Type this, exactly as written, typo included:

```python
price = 20

# I predict this prints: ____
try:
    total = pryce * 2
    print(f"Total: {total}")
except:
    print("could not calculate total")

print("finished")
```

Prediction first.

**Step 2.** Run it. Note that the program completed successfully and reported a problem with
calculating the total.

**Step 3.** Ask yourself, in a comment: *based only on that output, where would you start looking
for the bug?* Write down the honest answer — the one you'd actually act on at 9am with a coffee, not
the one you know is correct because you typed the typo yourself thirty seconds ago.

**Step 4.** Now change `except:` to `except TypeError:` and run it again.

**Step 5.** Read what comes out. Write down the exception's **name**, and the thing it tells you
that the polite message did not.

**Step 6.** Fix the typo. Run once more to confirm.

---

## Rep 3 — Explain back. Voice note is fine. (~3 min)

Not code. Answer in your own words, as though to someone who has written a bit of Python but has
never thought about this:

**A colleague shows you a function. Every risky operation in it is wrapped in `try` / bare
`except:`, and it never crashes — it always returns something. They're pleased with how robust it
is. What do you tell them, and what would you ask to see before you believed it worked?**

---

## What I'm marking tomorrow

Whether the predictions were typed *before* the runs — that's the rep, the rest is just running
code. Then Step 3 of Rep 2, which is the honest one: bare `except:` doesn't only hide the bug, it
actively points you at the wrong place.
