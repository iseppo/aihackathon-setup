# AI häkatoni masinate seadistus

TÜ HPC häkatoni (18.-20.11.2026, Jõhvi) osalejate masinate seadistus: opencode + TÜ HPC keelemudel, micromamba (paketid ilma rootita), tiimitöö GitLabi kaudu.

| Fail | Mis see on |
|---|---|
| `setup.sh` | Paigaldab osaleja masinasse kõik vajaliku, rooti pole vaja |
| `liitu-tiimiga` | `liitu-tiimiga 5` - toob tiimi repo ja teeb osaleja kausta |
| `AGENTS.md` | Reeglid AI-agendile (eesti keeles, algajatele) |
| `ALUSTA.txt` | Juhend osaleja töölaual |
| `hack.env.example` | Mudeli ja GitLabi seaded - **päris võti ei käi siia repo** |
| `gitlab_admin.py` | Korraldajale: tiimide repod, liikmed, varundus |

## Korraldaja: setup GitLabi panemine (testmasinas)

GitLab on nähtav ainult häkatoni masinatest, seega tee see testmasinas.

```bash
git clone https://github.com/iseppo/aihackathon-setup ~/src

# 1. GitLabis projektid (user100 token: GitLab -> Preferences -> Access tokens, scope api)
export GITLAB_TOKEN=...
python3 ~/src/gitlab_admin.py tiimid 15

# 2. setup repo sisu koos päris võtmega
mkdir ~/setup-gitlab && cd ~/setup-gitlab
cp -r ~/src/{setup.sh,liitu-tiimiga,AGENTS.md,ALUSTA.txt,skills} .
cp ~/src/hack.env.example hack.env     # kleebi võti ctrl+shift+v-ga HACK_LLM_KEY=
git init -q && git add . && git commit -qm setup
git push https://user100@gitlab-aihackathon.hpc.ut.ee/hackathon/setup.git HEAD:main
```

## Korraldaja: setup uuendamine

```bash
cd ~/src && git pull
cd ~/setup-gitlab && cp -r ~/src/{setup.sh,liitu-tiimiga,AGENTS.md,ALUSTA.txt,skills} .
git add . && git commit -qm uuendus && git push https://user100@gitlab-aihackathon.hpc.ut.ee/hackathon/setup.git HEAD:main
```

## Osaleja

Üks rida terminali (ctrl+shift+v), küsib GitLabi kasutajanime ja parooli (samad mis Guacamole'il):

```bash
git config --global credential.helper store && git clone https://gitlab-aihackathon.hpc.ut.ee/hackathon/setup.git ~/setup && bash ~/setup/setup.sh
```
