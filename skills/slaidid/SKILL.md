---
name: slaidid
description: Make presentation slides and pitch scripts - checkpoint 5 slides, pre-pitch, final 6-minute demo, questions from decision makers. Use when the user says "slaidid", "esitlus", "pitch", "checkpoint", "lõpudemo", "esitlen", "ettekanne", or asks how to present the prototype.
---

# Slides and pitch (slaidid)

Output is ONE self-contained file `esitlus/slaidid.html` that works offline in Firefox. Do not use PowerPoint, reveal.js from the internet, Node or any CDN.

## 1. Start from the template

Copy `template.html` from this skill's folder (`~/.config/opencode/skills/slaidid/template.html`) to `esitlus/slaidid.html`. Only change the `<section>` blocks. Each `<section>` is one slide. Keep the CSS and script as they are.

Content comes from `PLAAN.md`, `PROBLEEM.md`, `README.md` and what the prototype really does. Never invent numbers, users or results. If something is missing, ask or write `[täpsusta]`.

## 2. Pick the mode

**Checkpoint (5 slides)** - exactly these:
1. Probleem ja kellel see on
2. Lahendus - ühe lausega
3. Kuidas see töötab - screenshot of the prototype
4. Mis on valmis, mis puudub
5. Järgmine samm - mida teeme enne lõppu

**Final demo (6 minutes)** - slides plus a script `esitlus/stsenaarium.md` with timings:
- 0:00-1:00 kasutaja lugu (one real-sounding situation)
- 1:00-2:00 probleem, with one number if the team has one
- 2:00-5:00 live demo - list every click
- 5:00-5:30 mis on sünteetiline, mis jäi tegemata
- 5:30-6:00 mida palume otsustajalt

Also write the 5 hardest questions a ministry decision maker could ask, each with a 2-sentence answer.

## 3. Slide rules

- Max 3 short points per slide, max ~30 words. A slide is read from the back of the room.
- One idea per slide. Title says the point ("Olukorrapilt 2 minutiga, mitte 2 tunniga"), not just the topic.
- Screenshots: ask the user to save them into `esitlus/pildid/` (Firefox: right click → Take Screenshot), then use `<img src="pildid/x.png">`. You cannot see images; ask what is on them.
- Estonian, plain words, no jargon.

## 4. Finish

Tell the user:
- Open in the machine's Firefox: `file:///home/<user>/.../esitlus/slaidid.html` (give the full path). Arrow keys move, F = full screen.
- PDF: Firefox → Print (ctrl+p) → Save to PDF, landscape.
- Commit and push so the team sees it.
