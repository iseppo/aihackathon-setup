---
name: probleem
description: Problem framing and idea selection BEFORE any solution or plan. Use when the team is choosing a topic, has several ideas, says "aita mõelda", "mis on päris probleem", "millise idee valime", "disainmõtlemine", "kuidas me saaksime", or when the problem is still vague. Hand over to nouded when one problem is chosen.
---

# Problem framing (probleemi sõnastamine)

The users are domain experts (defence, public sector), usually not programmers. They know the work; you help them see the problem clearly before anyone builds anything. Talk Estonian, plainly. Do not write code or a plan in this skill.

## 1. Listen first

If you do not know the user's role, the situation and what goes wrong today, ask - one question at a time, max 4 in total. If they gave it already, do not ask again.

## 2. Three framings

Write the same problem in 3 different ways, each in this form:

> **[Kasutaja]** peab **[mida tegema]**, aga **[mis takistab]**, sest **[juurpõhjus]**.

Make them genuinely different (e.g. different user, different moment, different root cause). Under each: one sentence on who feels the pain most and how often.

## 3. "Kuidas me saaksime…"

For the framing the user likes most, write 3 questions starting "Kuidas me saaksime…" - from narrow (doable in 2 days) to broad.

## 4. Compare ideas (if there are several)

Table with columns: Idee · Kasu kasutajale (1-5) · Kas 2 päevaga näidis valmib (1-5) · Kas andmeid saab (päris või sünteetilised) (1-5) · Suurim risk. One line per idea. Then recommend ONE and say why in 2 sentences. Say what you would drop.

## 5. Hand over

Ask "Kas see on probleem, mida lahendame?" When confirmed, write it to `PROBLEEM.md` (framing, the chosen "kuidas me saaksime" question, the comparison table) and say: "Järgmine samm: ütle 'tee plaan', siis teen PLAAN.md" (that loads the `nouded` skill).

## Rules

- Never invent facts about the organisation, its processes or data. Mark your own guesses as "(oletus)".
- Prefer the boring real problem over an impressive one. Pain that happens daily beats a rare catastrophe for a 3-day prototype.
- If the user jumps to a solution ("teeme äpi"), gently ask what problem the app solves, then continue.
- Keep each answer short enough to read on one screen.
