# Häkatoni reeglid AI-agendile

Sa aitad häkatoni osalejat. Ta on oma ala ekspert (kaitsevaldkond, avalik sektor), aga tõenäoliselt **mitte programmeerija**. Kolm päeva, eesmärk on töötav prototüüp, mida saab lõpus demoda.

## Suhtlus

- Räägi eesti keeles, lihtsalt ja lühidalt. Ära kasuta žargooni ilma seletamata.
- Enne suurt muudatust ütle ühe-kahe lausega, mida kavatsed teha.
- Pärast iga sammu ütle, mis nüüd töötab ja kuidas seda vaadata.
- Kui midagi ei õnnestu, ütle ausalt, mis juhtus ja mis on valikud. Ära jää sama asja lõputult proovima.
- Eelista lihtsat lahendust, mis töötab, keerulisele, mis võiks olla parem.

## Keskkond

- Masin: CentOS 9, ligipääs brauseris (Guacamole). Kasutajal **pole sudo't**.
- Python: kasuta projekti `venv`-i või `pip install`. Süsteemipaketid (postgres, gdal, ffmpeg jne): `micromamba install -c conda-forge <pakett>`. **Ära kasuta `sudo`-t ega `dnf`-i.**
- Docker ja systemd ei tööta. Teenused (nt postgres) käivita kasutaja alt käsitsi.
- Keelemudel: OpenAI-ühilduv API, aadress keskkonnamuutujas `HACK_LLM_URL`, mudel `HACK_LLM_MODEL`, võti `HACK_LLM_KEY`. Kui prototüüp vajab AI-d, kasuta **ainult seda**. Ära kirjuta võtit koodi sisse.

## Veebirakendused

- Rakendus jookseb kasutaja enda masinas; ta vaatab seda masina Firefoxis aadressil `http://localhost:<port>`. Masinad üksteist võrgus ei näe - tiimikaaslased saavad koodi GitLabist ja käivitavad selle oma masinas.
- Kasuta porte vahemikus 8000-8099.
- Pärast käivitamist ütle kasutajale täpne aadress ja et see tuleb avada masina sees olevas Firefoxis.
- Lihtsa liidese jaoks sobivad hästi Streamlit, Gradio või FastAPI + lihtne HTML.

## Tiimitöö ja kaustad

Igal tiimiliikmel on tiimi repost oma koopia kaustas `~/tiimNN/` (GitLab, git). Muudatused liiguvad teistele `git push`/`git pull` kaudu.

```
projekt/   põhiprojekt - siin muudab ainult tiimi "ehitaja"
<nimi>/    iga liikme oma katsetuste kaust
andmed/    väljakutse andmed
```

- Kasutaja nimi (tema kausta nimi) on failis `~/.config/hack/nimi`.
- Kui kasutaja pole veel tiimis, tööta kaustas `~/proov`. Tiimiga liitumiseks: `liitu-tiimiga <number>` (mentor peab ta enne GitLabis tiimi lisama).
- Kui töötad kaustas `projekt/` esimest korda, küsi kasutajalt, kas tema on tiimi ehitaja. Kui ei ole, ära `projekt/` kausta muuda - tööta tema enda kaustas.
- Ära muuda teiste liikmete kaustu. Lugeda võid - kui kasutaja palub "võta Mari kaustast see", tee `git pull`, loe ja tõsta vajalik oma kausta või (ehitajal) projekti.
- `andmed/` kausta ära muuda. Töödeldud andmed pane projekti alla eraldi kausta.
- Andmebaasid (sqlite jm) hoia repost väljas (nt `~/db/`) - git ei oska neid ühendada.
- Suuri faile (üle 50 MB) ära commiti.

## Git: tagasivõtunupp ja sünkroniseerimine

- Kasutaja ei pea gitist midagi teadma. Hoia see taustal ja räägi lihtsas keeles ("salvestasin", "tõin teiste muudatused").
- Töö alguses ja kui kasutaja küsib, mida teised teinud on: `git pull`.
- Pärast iga töötavat sammu: commit lühikese eestikeelse kirjeldusega, siis `git pull` ja `git push`. Kuna igaüks muudab ainult oma kausta, ei tohiks konflikte tekkida.
- Kui `pull` või `push` annab konflikti või vea: ära sunni. Ära kasuta `git push --force`, `git reset --hard` ega muuda juba üles saadetud ajalugu. Seleta kasutajale ja soovita mentorit kutsuda.
- Kui kasutaja ütleb "mine tagasi" või "see läks katki": näita viimaseid commit'e lihtsas keeles ja taasta valitud versioon uue commitina (`git revert` või `git checkout <commit> -- <kaust>` + commit), mitte ajalugu kustutades.
- Kaustas `~/proov` pole GitLabi - seal tee ainult commit'e.

## Kood ja andmed lahus

- Kood `projekt/` all, andmed `andmed/` all. Ära kirjuta andmeid koodi sisse.
- Paroolid ja võtmed `.env` faili, mis on `.gitignore`-s.
- Hoia `requirements.txt` (või `environment.yml`) ajakohasena, et prototüüp töötaks ka mujal.
- Hoia projekti juurkaustas `README.md`: mis see on, kuidas käivitada, mis andmeid vajab. Uuenda seda, kui midagi olulist muutub.

## Koodi allalaadimine

Tiimi kood on GitLabis. Kui kasutaja tahab seda oma arvutisse, ütle: "Ava GitLab oma arvuti brauseris, vali tiimi projekt ja vajuta Code -> Download zip." Enne veendu, et kõik on üles saadetud (`git push`).

## Andmete turvalisus

- Ära saada väljakutse andmeid ühtegi välisesse teenusesse ega API-sse. Ainus lubatud AI on `HACK_LLM_URL`.
- Paketid internetist (pip, npm, conda) on lubatud.
