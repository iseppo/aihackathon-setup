---
name: lahteulesanne
description: Write a need description / procurement technical specification (lähteülesanne, vajaduse kirjeldus, tehniline kirjeldus, hanke nõuded) based on the team's PLAAN.md and prototype. Use when the user asks for "lähteülesanne", "vajaduse kirjeldus", "hanke jaoks", "nõuded", "tehniline kirjeldus", or on the last day to document what was learned.
---

# Need description (vajaduse kirjeldus / lähteülesanne)

One of the hackathon's results is a need description that can become a procurement specification or an internal development task. The prototype is evidence; this document is what a decision maker or procurement specialist will actually read. Write in Estonian, plain and concrete.

## 1. Collect

Read `PLAAN.md`, `PROBLEEM.md` (if present), `README.md` and look at what the prototype does. Ask the user (max 4 questions) only for what is missing: who would use it, how many users, what happens today, what must never happen.

## 2. Write `LAHTEULESANNE.md`

Sections, in this order:

1. **Taust ja probleem** - 1 paragraph. Who, what goes wrong today, why it matters.
2. **Kasutajad ja olukorrad** - roles, where and when they use it (office, field, offline?).
3. **Praegune protsess** - how it is done now, where time or quality is lost.
4. **Nõuded** - table: Nr · Nõue · Prioriteet (PEAB / PEAKS / VÕIB) · Vastuvõtutingimus. Every requirement must have an acceptance condition someone can check ("10 raporti põhjal koostab olukorrapildi alla 2 minuti, iga väide viitab allikale").
5. **Andmed** - inputs and outputs, sources, how sensitive (avalik / asutusesisene / salastatud / isikuandmed), where they must stay.
6. **Mittefunktsionaalsed nõuded** - e.g. runs on-premise or offline, Estonian language, logging, a human makes the final decision, access control, accessibility.
7. **Mida prototüüp tõestas ja mida mitte** - honest. Say what was synthetic and what was not tested.
8. **Avatud küsimused** - each with who should answer it.
9. **Eduka tulemuse mõõdikud** - 2-4 measurable ones.

## 3. Review as a stranger

Re-read the document as a procurement specialist who knows nothing about the team. List what is unclear, uncheckable or missing, fix it, and tell the user what you changed.

## Rules

- Describe the need, not a product. No brand or product names (procurement law: a named product needs "või samaväärne"); describe the capability instead.
- Never invent facts about the organisation, numbers or legal requirements. Mark guesses as "(oletus - kontrollida)".
- No classified details. If something sensitive is needed, write "[täpsustab tellija]".
- Max 3 pages. Shorter is better.
