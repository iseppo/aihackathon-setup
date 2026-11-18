# Oskuste kataloog

Need oskused ei ole masinates eelpaigaldatud. Osaleja saab need ise paigaldada, kui ütleb agendile näiteks:

> Paigalda oskus slaidid aadressilt https://github.com/iseppo/aihackathon-setup (kaust kataloog/slaidid). Enne loe SKILL.md läbi ja ütle, mida see teeb.

Agent teeb sisuliselt seda (võid ka ise terminalis):

```
git clone --depth 1 https://github.com/iseppo/aihackathon-setup /tmp/oskused
cp -r /tmp/oskused/kataloog/slaidid ~/.config/opencode/skills/
```

Siis sulge agent ja ava uuesti. Kontroll: „Mis oskused sul on?“

Kopeeri kogu kaust, mitte ainult SKILL.md – `slaidid` vajab ka faili `template.html`.

| Oskus | Milleks |
|---|---|
| `probleem` | probleemi sõnastamine, ideede võrdlemine ja valik |
| `andmed` | sünteetilised andmed skriptiga, realistlike vigadega |
| `slaidid` | checkpointi 5 slaidi, lõpudemo stsenaarium, otsustaja küsimused (HTML, töötab ilma internetita) |
| `lahteulesanne` | vajaduse kirjeldus / hanke lähteülesanne koos vastuvõtutingimustega |
| `kontroll` | demovalmiduse kontrollnimekiri |
