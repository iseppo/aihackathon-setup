---
name: andmed
description: Create realistic synthetic (fake) data for the prototype. Use when the user asks for "sünteetilised andmed", "näidisandmed", "testandmed", "väljamõeldud andmed", "nagu päris", a CSV/Excel to play with, or when real data is sensitive or unavailable.
---

# Synthetic data (sünteetilised andmed)

Real data in this hackathon is often sensitive. We never use it. We build data with the same structure that looks real enough for a demo.

## Where files go

The repo folder `andmed/` holds the challenge data and must NOT be changed. Write instead to:
- in `~/proov`: `synteetilised/`
- in a team repo, the builder: `projekt/synteetilised/`; everyone else: `<nimi>/synteetilised/` (name in `~/.config/hack/nimi`).

Below this folder is called `<kaust>`.

## 1. Agree on the structure first

- If `PLAAN.md` or the challenge data in `andmed/` describes the data, copy that structure (same column names and types). Otherwise ask, in one message, max 4 questions: what one row means, which columns, how many rows, which period.
- Show the columns as a small table (nimi · tüüp · näide · märkus) and ask "Kas sobib?" before generating. If the user says "mine edasi", go on.

## 2. Tables: generate with a script, not by typing rows

- Write `<kaust>/genereeri.py` (Python, pandas + numpy; for Estonian names `pip install faker` and `Faker("et_EE")`).
- Fixed seed (`seed = 42`) so a rerun gives the same file.
- Realistic distributions: most values ordinary, some rare; time patterns (day/night, weekdays) where they make sense; related columns stay consistent (end after start, totals add up).
- Add on purpose 3-5 kinds of mess real data has: empty cells, a typo variant of a category, a duplicate row, an outlier, a zero where it hurts. List them in the README so nobody thinks it is a bug - and so the app is tested against them.
- Output `<kaust>/<nimi>_synteetiline.csv`. "synteetiline" stays in the file name.

## 3. Texts (reports, messages, transcripts)

Write 10-30 short, varied texts directly as files (`<kaust>/tekstid/01.txt` …) in the right language and style: different authors, lengths, tones; some incomplete, some contradicting each other, if the use case needs it. Each text says nothing real.

## 4. Show and check

- Run the script. Show the first 5 rows and a short summary (row count, min/max/average of key numbers, counts per category).
- Ask yourself and tell the user: what would look fake to a real practitioner? Fix the worst one.
- Write `<kaust>/README.md`: what the files are, that they are synthetic, which mess was added, how to regenerate.
- Commit (and push in a team repo) so teammates get it.

## Rules

- Never copy, derive from, or ask for real personal data or real classified/sensitive details. Real unit names, real people, real coordinates of military sites: no. Plausible invented ones: yes.
- Keep it small enough to load instantly (usually 200-5000 rows).
