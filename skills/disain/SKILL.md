---
name: disain
description: Visual and UX design for the prototype's user interface. Use when building or changing a Streamlit/Gradio/HTML page, when the user says the page is ugly, confusing, "tee ilusamaks", "kujundus", or before the final demo.
---

# Design (kujundus)

Goal: a page a tired officer understands in 5 seconds. Clarity first, beauty second. Function must work before you polish.

## Structure

- One page = one job. The most important answer/number/map is at the top, big. Details below or in expanders/tabs.
- Title says what the page does in plain Estonian ("Varud, mis saavad 7 päevaga otsa"), not the app name.
- Max 3-4 inputs visible at once. Sensible defaults so the page shows something useful immediately - never an empty screen.
- Show the user what to do next: short helper text under inputs, one primary button.
- All visible text in Estonian, short, no jargon. Numbers with units and Estonian formatting (1 234,5).

## States

Design all of these, not only the happy path:
- **Empty**: no file uploaded yet → explain what to upload, offer "Kasuta näidisandmeid".
- **Loading**: spinner with text ("Analüüsin 300 rida…").
- **Error**: plain-language message that says what to do, never a raw traceback.
- **Result**: the answer, plus where it came from (data source, "sünteetilised andmed" label if so).

## Visual

- Restraint: one accent colour, neutral greys, lots of whitespace. No rainbow charts, no emoji decoration.
- Colour means something: red = needs action, amber = watch, green = ok. Never colour alone - add text or icon.
- Contrast readable on a projector (dark text on light background, min 14 px).
- Charts: one message per chart, title states the takeaway, sorted bars, direct labels instead of legends where possible.
- Tables: only needed columns, readable headers, highlight the rows that matter.
- Streamlit: use `st.set_page_config(page_title=..., layout="wide")`, `st.columns`, `st.metric` for key numbers, `st.tabs` for secondary views. Do not fight Streamlit with heavy custom CSS.
- HTML: one CSS file, system fonts, CSS variables for colours, works at 1366 px width.

## Before the demo

Open the page as the user would. Check: is the main answer visible without scrolling? Does every label make sense to a non-programmer? Does the empty state work? Is synthetic data labelled? Then tell the user 2-3 concrete things you improved.
