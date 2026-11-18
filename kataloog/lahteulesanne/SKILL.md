---
name: lahteulesanne
description: Write a need description / procurement technical specification (lähteülesanne, vajaduse kirjeldus, tehniline kirjeldus, hanke nõuded) from the team's PLAAN.md and prototype. Use when the user asks for "lähteülesanne", "vajaduse kirjeldus", "hanke jaoks", "nõuded", "tehniline kirjeldus", or on the last day to document what was learned.
---

# Need description (vajaduse kirjeldus / lähteülesanne)

One result of the hackathon is a need description that can become a procurement specification or an internal development task. The prototype is evidence; this document is what a decision maker or procurement specialist will actually read. Write in Estonian, plain and concrete.

## 1. Collect

Read `PLAAN.md`, `PROBLEEM.md` (if present), `README.md` and check what the prototype really does (read the code, run the tests). Ask the user, in one message, max 4 questions, only for what is missing: who would use it, how many users, what happens today, what must never happen. If they say "pane ise", write assumptions and mark them.

## 2. Write `LAHTEULESANNE.md`

Sections, in this order:

1. **Taust ja probleem** - 1 paragraph. Who, what goes wrong today, why it matters.
2. **Kasutajad ja olukorrad** - roles, where and when (office, field, offline?).
3. **Praegune protsess** - how it is done now, where time or quality is lost.
4. **Nõuded** - table: Nr · Nõue · Prioriteet (PEAB / PEAKS / VÕIB) · Vastuvõtutingimus. Every requirement has an acceptance condition someone can check ("10 raporti põhjal koostab olukorrapildi alla 2 minuti, iga väide viitab allikale"). Max 12 rows.
5. **Andmed** - inputs and outputs, sources, sensitivity (avalik / asutusesiseseks kasutamiseks (AK) / salastatud / isikuandmed), where they must stay.
6. **Mittefunktsionaalsed nõuded** - e.g. runs in the organisation's own infrastructure or offline, Estonian language, logging, access control, accessibility.
7. **Tehisintellekti nõuded** (if the solution uses AI) - a human makes the final decision; answers show their source; what happens when the model is wrong or unsure; how quality is measured before use.
8. **Mida prototüüp tõestas ja mida mitte** - honest. What was synthetic, what was not tested.
9. **Avatud küsimused** - each with who should answer it.
10. **Eduka tulemuse mõõdikud** - 2-4 measurable ones, each with today's value if known.

Where to write: repo root if the user is the builder or in `~/proov`; otherwise their own folder (name in `~/.config/hack/nimi`).

## 3. Review as a stranger

Re-read the document as a procurement specialist who knows nothing about the team. List what is unclear, uncheckable or missing, fix it, and tell the user what you changed.

## Rules

- Describe the need, not a product. No brand or product names; if one is unavoidable, add "või samaväärne". Describe the capability instead.
- Never invent facts about the organisation, numbers or legal requirements. Mark guesses "(oletus - kontrollida)".
- No classified details. Where something sensitive is needed write "[täpsustab tellija]".
- Max 3 pages. Shorter is better.
