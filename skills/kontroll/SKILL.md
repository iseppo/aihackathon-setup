---
name: kontroll
description: Demo-readiness check before the checkpoint, pre-pitch or final demo. Use when the user asks "kas oleme valmis", "kontrolli üle", "enne demo", "checkpoint", "mis võib katki minna", or before saying a larger piece of work is done.
---

# Demo-readiness check (kontroll)

Never say "valmis" or "töötab" without fresh evidence from this run. Check, then report plainly in Estonian.

## Checklist - run each, do not assume

1. **Tests**: if `tests/` exists, run `pytest` and report "N kontrolli läbis / M kukkus".
2. **Clean start**: open a fresh terminal, follow `README.md` exactly to start the app. If a step is missing from the README, fix the README.
3. **It answers**: `curl -s http://localhost:<port>` (or open the page) returns the page, not an error.
4. **Demo story**: walk through the demo story from `PLAAN.md` step by step. Each step works?
5. **Bad input**: empty input, a wrong file type, a very large input. Does the app explain the problem instead of crashing?
6. **Numbers**: pick 3 numbers the app shows and recalculate them by hand or with a separate small script. Same result?
7. **Sources**: if the app gives answers with references, open 3 references and check they really say that.
8. **Data honesty**: synthetic data is labelled as synthetic in the app or slides.
9. **Saved**: everything is committed and pushed (`git status` clean, `git push` done).
10. **Backup**: there is a screenshot or short screen recording of the working demo in `pildid/`, in case the live demo fails.

## Report

A table: Kontroll · Korras / Vajab parandust · Mis täpselt. Then the 3 things most likely to break during the demo and a fallback for each. Then ask which fixes to do first. Fix one thing at a time.
