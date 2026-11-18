---
name: kontroll
description: Demo-readiness check before the checkpoint, pre-pitch or final demo. Use when the user asks "kas oleme valmis", "kontrolli üle", "enne demo", "mis võib katki minna", "kas töötab", or before saying a larger piece of work is done.
---

# Demo-readiness check (kontroll)

Never say "valmis" or "töötab" without fresh evidence from this run. Run each check, do not assume. Do not fix anything until the report is shown.

## Checklist

1. **Tests**: if `tests/` exists, run `pytest -q` and report "N kontrolli läbis / M kukkus". Passing tests are not enough - see 4.
2. **Fresh start**: follow `README.md` exactly, in a new shell, to install and start the app. A missing or wrong step is a finding.
3. **It answers**: a web app blocks the terminal, so start it in the background and stop it afterwards, e.g.
   `nohup streamlit run app.py --server.port 8501 --server.headless true > /tmp/app.log 2>&1 &` then `sleep 8; curl -s -o /dev/null -w '%{http_code}' http://localhost:8501`, check `/tmp/app.log` for errors, finally `kill %1` (or `pkill -f "streamlit run"`).
4. **Real demo data**: run the core logic (the functions the app calls) on the **full** data files the demo uses, not only the test examples. Look for crashes, `inf`, `NaN`, empty results, negative or impossible values. Look at the data for zeros, empty cells, duplicates, odd categories.
5. **Demo story**: walk the demo story from `PLAAN.md` step by step with the same inputs the presenter will use.
6. **Bad input**: empty input, wrong file type, a very large input. Does the app explain the problem instead of showing a traceback?
7. **Numbers**: pick 3 numbers the app shows and recalculate them with a separate small script. Same result?
8. **Sources**: if the app cites sources, open 3 and check they really say that.
9. **Data honesty**: synthetic data is labelled as synthetic in the app or slides.
10. **Secrets**: no API key or password in the code or git history (`git grep -n "HACK_LLM_KEY\s*=\|sk-"`), `.env` is in `.gitignore`.
11. **Saved**: `git status` clean, latest commit pushed.
12. **Backup**: ask the user whether there is a screenshot or screen recording of the working demo (`esitlus/pildid/`). You cannot make one yourself.

## Report

A table: Kontroll · Korras / Vajab parandust · Mis täpselt. Then the 3 things most likely to break during the demo and a fallback for each. Then ask which fixes to do first. Fix one at a time, each with a test that reproduces the problem first.
