# SQL L0.1 — Filtering with WHERE

*Lloyds study · taught block · Friday 31 July 2026 · read time ~15 min · notes before questions*

Read once through, then a second time with the BigQuery console open, typing the examples. All of
them run against `bigquery-public-data.thelook_ecommerce` — a fake online clothing shop with real
structure.

You did Python this morning, so this file leans on that deliberately. Several things look identical
and mean something different, and knowing which is which is most of the difficulty at this rung.

---

## Why this rung matters more than it looks

`WHERE` is the whole capstone in miniature.

Someone types *"how many orders from Texas customers were returned last quarter?"* Your agent turns
that sentence into SQL, and the part that carries almost all the meaning is the `WHERE` clause. Get
`AND` where the sentence said `OR` and the query still runs, still returns a tidy number, and the
number is wrong. Nobody sees an error. The model reports it confidently.

That is this morning's argument again, in a new language, and SQL is *worse* than Python for it —
because there's no type system, no traceback, and the output of a wrong query looks exactly like
the output of a right one. It's a table of numbers either way.

Which is why the drill format is English question first, then SQL. The English is the specification.
The SQL is the implementation. Most SQL bugs are a mismatch between the two, not a syntax error.

---

## 1. The shape

```sql
SELECT   first_name, last_name, state
FROM     bigquery-public-data.thelook_ecommerce.users
WHERE    state = 'Texas'
```

Three clauses:

- **`SELECT`** — which *columns* you want back
- **`FROM`** — which *table* they come from
- **`WHERE`** — which *rows* to keep

`SELECT *` means "every column". Fine while exploring, bad habit later — on 31 August you learn that
BigQuery bills you by bytes scanned, and `*` scans everything.

### The one mental model to take from this rung

**SQL does not run in the order you write it.** It runs:

```
FROM   →   WHERE   →   SELECT
```

Get the table. Throw away rows that fail the test. *Then* pick the columns.

This explains things that otherwise look arbitrary. It's why `WHERE` can filter on a column you
never `SELECT`ed — the filtering already happened before the column list mattered. Hold this and
most of L0 stops being a list of rules.

**The other half of the model:** `WHERE` is tested **once per row**, independently. There is no
loop you can see, no `for`, no index. You write the test for *one* row and the database applies it
to all sixty thousand. `state = 'Texas'` means *"for the row in front of me, is the state Texas?"*
That's the whole idea, and it's why SQL feels strange coming from Python — the iteration is implied.

---

## 2. Four things that differ from Python, and will bite today

You've spent three days in Python. These look the same and aren't.

### `=` not `==`

```sql
WHERE state = 'Texas'        -- correct
WHERE state == 'Texas'       -- error in BigQuery
```

SQL has no assignment operator in this position, so there's no ambiguity to resolve — a single `=`
is the comparison. Muscle memory will fight you for a week.

### Strings go in **single** quotes

```sql
WHERE state = 'Texas'        -- correct
WHERE state = "Texas"        -- works in BigQuery, but don't
```

In Python `'x'` and `"x"` are identical. In standard SQL, double quotes mean an **identifier** — a
column or table name, not text. BigQuery is lenient and accepts both for strings; most other
databases are not, and Lloyds runs more than BigQuery. Single quotes for text, always.

### Not-equal is `!=` or `<>`

Both work. `<>` is the older spelling and you'll see it in inherited code.

### `AND` / `OR` / `NOT`, not `and` / `or` / `not`

Same words, conventionally uppercase. SQL keywords are case-insensitive — `where` and `WHERE` both
run. **Your data is not.** `'texas'` and `'Texas'` are different strings, and a query filtering on
`'texas'` returns zero rows with no complaint whatsoever.

Convention: keywords upper, everything else lower.

---

## 3. Comparison

```sql
WHERE retail_price > 50
WHERE age <= 30
WHERE category = 'Jeans'
WHERE status != 'Cancelled'
```

`>` `<` `>=` `<=` `=` `!=` — as you'd expect, and they work on text too (`WHERE state > 'M'` gives
you alphabetically-later states, which is occasionally useful and mostly a curiosity).

Numbers bare, text quoted. `WHERE retail_price > '50'` is asking a different question and in some
databases an error.

---

## 4. `AND`, `OR`, `NOT`

```sql
-- both conditions must hold
WHERE category = 'Jeans' AND retail_price > 50

-- either will do
WHERE state = 'Texas' OR state = 'California'

-- flip it
WHERE NOT status = 'Cancelled'          -- same as status != 'Cancelled'
```

### `OR` does not carry the comparison across — and here SQL is kinder than Python

This is your Wednesday miss, and it's worth seeing what each language does with it.

```sql
WHERE state = 'Texas' OR 'California'        -- WRONG
WHERE state = 'Texas' OR state = 'California' -- right
```

`OR` joins two complete conditions. The left-hand side is a test; the right-hand side has to be a
test too. `'California'` on its own is a piece of text, not a question.

**In Python that exact mistake runs silently** — `status == "open" or "pending"` is always truthy,
so every row passes and nothing complains. **In BigQuery it errors:** *"No matching signature for
operator OR for argument types: BOOL, STRING."* The database refuses to guess.

Same bug, one language screams and one shrugs. Worth noticing which one you found harder to spot.

### Precedence: `AND` binds tighter than `OR`

The single most expensive thing in this file.

```sql
-- what you probably mean:
WHERE department = 'Men' AND (category = 'Jeans' OR category = 'Shorts')

-- what you get without brackets:
WHERE department = 'Men' AND category = 'Jeans' OR category = 'Shorts'
```

The second one reads to SQL as:

```sql
WHERE (department = 'Men' AND category = 'Jeans') OR (category = 'Shorts')
```

— so it returns men's jeans **plus every pair of shorts in the shop, including women's**. It runs.
It returns rows. The row count looks plausible. Nothing is wrong except the answer.

`AND` before `OR`, exactly like `×` before `+` in arithmetic. **Rule: the moment a `WHERE` clause
contains both `AND` and `OR`, put brackets in.** Even when you've worked out you don't need them —
the next person to read it hasn't.

---

## 5. `IN` — the tidy `OR`

```sql
WHERE category = 'Jeans' OR category = 'Shorts' OR category = 'Socks'
WHERE category IN ('Jeans', 'Shorts', 'Socks')      -- identical, and readable
```

Same meaning, one line, and no chance of the precedence trap. Use it whenever you're testing one
column against a list.

`NOT IN` does the obvious thing:

```sql
WHERE status NOT IN ('Cancelled', 'Returned')
```

---

## 6. `BETWEEN` — and the thing people get wrong

```sql
WHERE age BETWEEN 25 AND 35
```

**`BETWEEN` is inclusive at both ends.** That's `age >= 25 AND age <= 35`. A 25-year-old is in. A
35-year-old is in.

This is your `59.5` problem from this morning wearing a different hat: the boundary is where the
bug lives. When the English says "between 25 and 35", find out whether the person asking means
inclusive. They usually do. They don't always.

Works on dates too, and that's where it gets sharp — `BETWEEN '2026-01-01' AND '2026-03-31'` on a
timestamp column silently excludes almost all of 31 March, because `'2026-03-31'` means midnight at
the *start* of that day. Not today's problem, but remember you read it.

---

## 7. `LIKE` — matching part of a string

```sql
WHERE name LIKE '%Denim%'
```

Two wildcards, and only two:

- **`%`** — any number of characters, including none
- **`_`** — exactly one character

| Pattern | Matches |
|---|---|
| `'%Denim%'` | Denim anywhere in the string |
| `'Denim%'` | starts with Denim |
| `'%Denim'` | ends with Denim |
| `'%@gmail.com'` | ends with @gmail.com |
| `'_enim'` | five characters, ending `enim` |

**`LIKE` is case-sensitive in BigQuery.** `'%denim%'` and `'%Denim%'` return different rows. When
you don't know how the data is capitalised — and you usually don't — normalise both sides:

```sql
WHERE LOWER(name) LIKE '%denim%'
```

That's the safe default and it's what you'll write in the capstone. Note what it costs, though:
`LOWER(name)` runs the function on every row, so the database can't use an index on `name`. Fine on
these tables, not fine on a hundred million rows. There's always a trade — that's the 29 August
session.

---

## 8. Worked examples

Type these. Read each one as English first.

**"Men's jeans over £50."**

```sql
SELECT   name, category, department, retail_price
FROM     bigquery-public-data.thelook_ecommerce.products
WHERE    department = 'Men'
  AND    category = 'Jeans'
  AND    retail_price > 50
```

**"Customers in Texas or California, aged 30 to 40."**

```sql
SELECT   first_name, last_name, state, age
FROM     bigquery-public-data.thelook_ecommerce.users
WHERE    state IN ('Texas', 'California')
  AND    age BETWEEN 30 AND 40
```

Note the brackets you *didn't* need: `IN` is a single condition, so there's nothing for `AND` to
bind too tightly to. That's the second reason to prefer `IN` over chained `OR`s.

**"Gmail users not in the UK."**

```sql
SELECT   first_name, email, country
FROM     bigquery-public-data.thelook_ecommerce.users
WHERE    email LIKE '%@gmail.com'
  AND    country != 'United Kingdom'
```

**The precedence one — run both and compare the row counts.**

```sql
-- A
SELECT COUNT(*)
FROM   bigquery-public-data.thelook_ecommerce.products
WHERE  department = 'Men' AND category = 'Jeans' OR category = 'Shorts';

-- B
SELECT COUNT(*)
FROM   bigquery-public-data.thelook_ecommerce.products
WHERE  department = 'Men' AND (category = 'Jeans' OR category = 'Shorts');
```

Both run. Neither errors. One answers the question. **Write down which is bigger and why before you
run them.**

---

## 9. Reference — the tables you'll use

**`bigquery-public-data.thelook_ecommerce.products`**
`id`, `name`, `brand`, `category`, `department`, `cost`, `retail_price`, `sku`

**`...users`**
`id`, `first_name`, `last_name`, `email`, `age`, `gender`, `state`, `city`, `country`,
`traffic_source`, `created_at`

**`...orders`**
`order_id`, `user_id`, `status`, `gender`, `num_of_item`, `created_at`, `shipped_at`,
`delivered_at`, `returned_at`

---

## Summary

- `FROM` → `WHERE` → `SELECT`. Rows are filtered before columns are chosen.
- `WHERE` is tested once per row. Write the test for one row.
- `=` not `==`. `'single quotes'` for text. `!=` or `<>` for not-equal.
- Keywords are case-insensitive; **your data is not**.
- **`AND` binds tighter than `OR`.** Both in one clause → use brackets, always.
- `IN (...)` for a list. `BETWEEN a AND b` is **inclusive** at both ends.
- `LIKE '%x%'` for "contains". Case-sensitive — `LOWER()` both sides when unsure.
- A wrong `WHERE` returns a clean table of wrong numbers. There is no error to catch it.

Next SQL rung (Sat 1 Aug): **NULLs and `DISTINCT`** — where `None` comes back to find you.
