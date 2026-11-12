---
name: nouded
description: Requirements analysis before building. Use when the user describes a new idea or problem, says "tahan teha", "mul on probleem", "aita mõelda", asks for a plan or PLAAN.md, or when the request is vague and you would otherwise have to guess what to build.
---

# Requirements analysis (nõuete analüüs)

The user is a domain expert (defence, public sector), usually not a programmer. They know the problem; you help turn it into something buildable in 3 days. Talk to them in Estonian, plainly. Do not write code in this skill.

## 1. Understand the problem first

Ask at most 5 questions in one message, numbered, each answerable in one sentence. Pick from:
- Who exactly uses this, and in what situation? (role, moment, device)
- What do they do today instead, and what is painful about it?
- What goes in? (files, data, text - and is any of it sensitive or personal?)
- What must come out? (table, map, report, answer, alert)
- How would they know it worked? What would they do next with the result?
- What is out of scope / must stay simple?

If the user already answered something, do not ask it again. If they say "sina vali", choose the simplest reasonable option and say what you assumed.

## 2. Play it back

In 3-4 sentences: the user, the problem, the result, and the one thing that makes it valuable. Ask "Kas sain õigesti aru?" Wait for confirmation.

## 3. Cut to a demo

- **Minimal working version**: the smallest thing that shows the value end to end. One user, one flow.
- **Not doing**: list explicitly (login, real integrations, real sensitive data, mobile, ...).
- **Data**: if real data is sensitive or unavailable, plan synthetic data with the same structure.
- **Risks**: 2-3 things most likely to fail (data quality, model answers wrong, too slow) and how the demo handles them.
- **Demo story**: who, what problem, what we show - 3 minutes.

## 4. Write PLAAN.md (one page)

Sections: Probleem · Kasutaja · Demo lugu · Minimaalne versioon · Mida ei tee · Andmed · Tehnoloogia · Riskid · Ülesanded.

Ülesanded: 8-12 tasks, each max 1-2 hours, each with a title, 2-4 sentences, and "Valmis, kui:" with a condition the user can check with their own eyes. Order them so that after the first 3-4 tasks something works end to end (ugly is fine). Write them so they can be copied into GitLab issues.

## Rules

- Never invent facts about the user's organisation, processes or data. Ask, or mark as assumption.
- Prefer the problem the user actually has over an impressive one.
- If the idea is too big for 3 days, say so plainly and propose the slice that fits.
