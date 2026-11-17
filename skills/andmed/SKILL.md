---
name: andmed
description: Create realistic synthetic (fake) data for the prototype. Use when the user asks for "sünteetilised andmed", "näidisandmed", "testandmed", "nagu päris", a CSV/Excel to play with, or when real data is sensitive or unavailable.
---

# Synthetic data (sünteetilised andmed)

Real data in this hackathon is often sensitive. We never use it. We build data with the same structure that looks real enough for a demo.

## 1. Agree on the structure first

- If `PLAAN.md` describes the data, use that. Otherwise ask (one message, max 4 questions): what one row means, which columns, how many rows, which date range.
- Show the column list as a small table (nimi · tüüp · näide · märkus) and ask "Kas sobib?" before generating.

## 2. Generate with a script, not by typing rows

- Write `andmed/genereeri.py` (Python, pandas + numpy; Faker with `et_EE` locale if names/addresses are needed and it is installed).
- Fixed random seed (`seed = 42`) so it can be rerun with the same result.
- Realistic distributions: most values ordinary, some rare; time patterns (day/night, weekdays) where they make sense; correlated columns stay consistent (e.g. end time after start time).
- Add on purpose 3-5 kinds of mess real data has: empty cells, a typo variant of a category, a duplicate row, an outlier. List them in the README so nobody thinks it is a bug.
- Output `andmed/<nimi>_synteetiline.csv`. The word "synteetiline" stays in the file name.
- Text data (reports, messages, transcripts): generate a small set (10-30) of short, varied texts in the right language and style, with some contradicting or incomplete ones if the use case needs it.

## 3. Show and check

- Run the script. Show the first 5 rows and a short summary (row count, min/max/average of key numbers, counts per category).
- Ask yourself and tell the user: what would look fake to a real practitioner? Fix the worst one.
- Add 2-3 lines to `andmed/README.md`: what the file is, that it is synthetic, how to regenerate.

## Rules

- Never copy, derive from, or ask for real personal data or real classified/sensitive details. Real unit names, real people, real coordinates of military sites: no. Plausible invented ones: yes.
- Keep it small enough to load instantly (usually 200-5000 rows).
