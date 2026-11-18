---
name: probleem
description: Problem framing and choosing between ideas BEFORE any plan or code. Use when the team has several ideas or a vague topic and says "mis on päris probleem", "millise idee valime", "meil on mitu ideed", "disainmõtlemine", "kuidas me saaksime", "kellel see valu on". When one problem is already clear and the user wants a plan, use nouded instead.
---

# Problem framing (probleemi sõnastamine)

The users are domain experts (defence, public sector), usually not programmers. They know the work; you help them see the problem clearly before anyone builds. Talk Estonian, plainly. Do not write code or a plan here.

## 1. Listen first

You need: the user's role, the situation, what goes wrong today, how often, who suffers. Ask only what is missing - in ONE message, numbered, max 4 questions, each answerable in one sentence. If they already said it, do not ask again. If they say "sina vali" / "mine edasi", assume and mark it "(oletus)".

## 2. Three framings

Write the problem in 3 genuinely different ways (different user, moment or root cause):

> **[Kasutaja]** peab **[mida tegema]**, aga **[mis takistab]**, sest **[juurpõhjus]**.

Under each: one sentence on who feels the pain most and how often.

## 3. "Kuidas me saaksime…"

For the framing the user prefers, write 3 questions starting "Kuidas me saaksime…", from narrow (doable in 2 days) to broad.

## 4. Compare ideas (if there are several)

Table: Idee · Kasu kasutajale · Kas 2 päevaga näidis valmib · Kas andmeid saab (päris või sünteetilised) · Suurim risk. Scores 1-5 are YOUR estimate - say so and invite the user to correct them. Recommend ONE in 2 sentences and say what you would drop.

Feasibility facts for this hackathon - use them when scoring:
- The available AI model reads and writes **text only**. It cannot see photos or video and cannot hear audio. An idea that depends on recognising images or speech is hard in 2 days - say so plainly, and offer a text-based variant (e.g. a checklist the person fills in instead of a photo).
- No real sensitive data; everything is synthetic. An idea whose value only shows on real data is risky.
- No integrations with real systems; files in, result out.

## 5. Hand over

Ask "Kas see on probleem, mida lahendame?" When confirmed, write `PROBLEEM.md` (the chosen framing, the chosen "kuidas me saaksime" question, the comparison table, assumptions) and say: "Järgmine samm: ütle 'tee plaan', siis teen PLAAN.md."

Where to write: in `~/proov` anywhere. In a team repo (`~/tiimNN`) the repo root belongs to the team's builder - if the user is not the builder, write into their own folder (name in `~/.config/hack/nimi`) and tell them to pass it to the builder. Never write into `andmed/`.

## Rules

- Never invent facts about the organisation, its processes or data. Mark your guesses "(oletus)".
- Prefer the boring daily problem over a rare impressive one.
- If the user jumps to a solution ("teeme äpi"), ask once what problem it solves, then continue.
- Each answer fits on one screen.
