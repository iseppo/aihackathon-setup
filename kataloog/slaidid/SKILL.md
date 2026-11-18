---
name: slaidid
description: Make presentation slides and pitch scripts - checkpoint 5 slides, pre-pitch (eel-pitch), final demo script, hard questions from decision makers. Use when the user says "slaidid", "esitlus", "pitch", "checkpoint", "lõpudemo", "esitlen", "ettekanne", or asks how to present the prototype.
---

# Slides and pitch (slaidid)

Output is ONE self-contained file `esitlus/slaidid.html` that works offline in Firefox. Do not use PowerPoint, reveal.js, Node or anything from a CDN.

## 1. Start from the template

The template is `template.html` in this skill's base directory (shown when the skill loads). Copy it with `cp` to `esitlus/slaidid.html`. If it is missing:
`curl -sL https://raw.githubusercontent.com/iseppo/aihackathon-setup/main/kataloog/slaidid/template.html -o esitlus/slaidid.html`

Only change the `<section>` blocks; keep the CSS and script. Each `<section>` is one slide; `class="dark"` gives a dark slide. Building blocks: `<p class="eyebrow">` small label above the title, `<p class="big">` one huge number, `<div class="cols">` two columns, `<ul>` max 3 points, `<img>`. Add or remove sections as needed. Do not add your own CSS or tiny text - the large fonts are on purpose (projector).

Where `esitlus/` goes: in `~/proov` or for the team's builder - repo root; for other team members - their own folder (name in `~/.config/hack/nimi`), so two people do not edit the same file.

Content comes from `PLAAN.md`, `PROBLEEM.md`, `README.md` and what the prototype really does. Never invent numbers, users or results. If something is missing, ask or write `[täpsusta]` on the slide.

## 2. Pick the mode

Ask the time limit if you do not know it.

**Checkpoint (5 slides)** - exactly these:
1. Probleem ja kellel see on
2. Lahendus - ühe lausega
3. Kuidas see töötab - the flow in 3 steps; screenshot if there is one
4. Mis on valmis, mis puudub
5. Järgmine samm - mida teeme enne lõppu

**Eel-pitch (short)** - 3 slides (probleem · lahendus + demo · mida palume) and a script `esitlus/stsenaarium.md` that fits the time limit, read aloud at ~120 words per minute.

**Final demo** - slides plus `esitlus/stsenaarium.md`, with timings scaled to the time limit (example for 6 min):
- 0:00-1:00 kasutaja lugu (one concrete situation)
- 1:00-2:00 probleem, with one number if the team has one
- 2:00-5:00 live demo - list every click and what to say
- 5:00-5:30 mis on sünteetiline, mis jäi tegemata
- 5:30-6:00 mida palume otsustajalt
Plus a plan B line: which screenshot to show if the live demo fails.

Also write the 5 hardest questions a ministry decision maker could ask (cost, data security, what if the AI is wrong, who maintains it, why not an existing product), each with a 2-sentence answer.

## 3. Slide rules

- Max 3 short points per slide, max ~30 words. Read from the back of the room.
- Title states the point ("Olukorrapilt 2 minutiga, mitte 2 tunniga"), not just the topic.
- Screenshots: ask the user to save them into `esitlus/pildid/` (Firefox: right click → Take Screenshot), then `<img src="pildid/x.png" alt="...">`. You cannot see images; ask what is on them.
- Estonian, plain words, no jargon.

## 4. Check and finish

- Check the file: every `<section>` opens and closes, no placeholder `[...]` left unless the user agreed. Count words per slide.
- Give the full path with `realpath esitlus/slaidid.html` and tell the user: open `file://<path>` in the machine's Firefox. Arrow keys move, F = full screen.
- PDF: Firefox → Print (ctrl+p) → Save to PDF, landscape.
- Commit (and push in a team repo) so the team sees it.
