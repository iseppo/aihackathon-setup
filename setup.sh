#!/usr/bin/env bash
# Häkatoni masina seadistus. Paigaldab kõik kasutaja koju, rooti pole vaja.
#
# Osaleja kleebib terminali ühe rea (ctrl+shift+v) ja sisestab küsimisel
# oma GitLabi kasutajanime ja parooli (samad, millega Guacamole'i sisse logis):
#
#   git config --global credential.helper store && git clone https://gitlab-aihackathon.hpc.ut.ee/hackathon/setup.git ~/setup && bash ~/setup/setup.sh
#
# credential.helper store salvestab parooli faili ~/.git-credentials, edaspidi git enam ei küsi.
# Võib käivitada mitu korda - teeb ainult puuduva ära ja uuendab seaded.

set -euo pipefail

SETUP_DIR="${SETUP_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
HACK_CONF="$HOME/.config/hack"
HACK_ENV="$HACK_CONF/hack.env"   # HACK_LLM_*, HACK_GITLAB_*
ENV_NAME="hack"
MAMBA_ROOT="${HOME}/micromamba"
MAMBA_BIN="${HOME}/.local/bin/micromamba"

say()  { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
ok()   { printf '    \033[32mOK\033[0m %s\n' "$*"; }
warn() { printf '    \033[33mHOIATUS\033[0m %s\n' "$*"; }
fail() { printf '\n\033[1;31mVIGA: %s\033[0m\n' "$*" >&2; exit 1; }

# --- 0. Eeldused ja seaded ----------------------------------------------------
say "Kontrollin eeldusi"
for c in curl git; do
  command -v "$c" >/dev/null || fail "'$c' puudub masinast. Anna mentorile märku."
done
[ -r "$SETUP_DIR/hack.env" ] || fail "Seadete fail puudub: $SETUP_DIR/hack.env"
mkdir -p "$HACK_CONF"
cp "$SETUP_DIR/hack.env" "$HACK_ENV"
chmod 600 "$HACK_ENV"
# shellcheck source=/dev/null
. "$HACK_ENV"
: "${HACK_LLM_URL:?hack.env: HACK_LLM_URL puudub}"
: "${HACK_LLM_MODEL:?hack.env: HACK_LLM_MODEL puudub}"
: "${HACK_GITLAB_URL:?hack.env: HACK_GITLAB_URL puudub}"
: "${HACK_GITLAB_GROUP:=hackathon}"
ok "curl, git, seaded"

# --- 1. Nimi ------------------------------------------------------------------
# Eesnimi on tiimi repos sinu kausta nimi (nt mari/) ja commitide autor.
if [ ! -s "$HACK_CONF/nimi" ]; then
  say "Kuidas sind kutsuda?"
  NIMI=""
  while [ -z "$NIMI" ]; do
    read -rp "    Sinu eesnimi (tiimikaaslased näevad seda): " NIMI
    NIMI="$(printf '%s' "$NIMI" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | tr -cd '[:alnum:]äöüõšž-')"
  done
  printf '%s\n' "$NIMI" > "$HACK_CONF/nimi"
fi
NIMI="$(cat "$HACK_CONF/nimi")"
ok "nimi: $NIMI"

# --- 2. micromamba ------------------------------------------------------------
say "micromamba"
if [ ! -x "$MAMBA_BIN" ]; then
  mkdir -p "$(dirname "$MAMBA_BIN")"
  curl -fsSL -o "$MAMBA_BIN" \
    https://github.com/mamba-org/micromamba-releases/releases/latest/download/micromamba-linux-64
  chmod +x "$MAMBA_BIN"
fi
ok "$("$MAMBA_BIN" --version)"

export MAMBA_ROOT_PREFIX="$MAMBA_ROOT"

# --- 3. Põhikeskkond: python, node, sqlite ------------------------------------
say "Põhikeskkond '$ENV_NAME' (python, node) - esimesel korral paar minutit"
if [ ! -d "$MAMBA_ROOT/envs/$ENV_NAME" ]; then
  "$MAMBA_BIN" create -y -q -n "$ENV_NAME" -c conda-forge \
    python=3.12 pip nodejs=22 sqlite
fi
ENV_PREFIX="$MAMBA_ROOT/envs/$ENV_NAME"
export PATH="$ENV_PREFIX/bin:$PATH"
ok "python $(python --version 2>&1 | cut -d' ' -f2), node $(node --version)"

# --- 4. AI-agent --------------------------------------------------------------
say "AI-agent (opencode)"
npm install -g --silent --no-fund --no-audit opencode-ai >/dev/null
ok "opencode $(opencode --version 2>/dev/null || echo '?')"

say "Agendi seaded ja reeglid"
mkdir -p "$HOME/.config/opencode"
# opencode: OpenAI-ühilduv /v1/chat/completions
cat > "$HOME/.config/opencode/opencode.json" <<EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "provider": {
    "hpc": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "TÜ HPC",
      "options": {
        "baseURL": "${HACK_LLM_URL}",
        "apiKey": "{env:HACK_LLM_KEY}"
      },
      "models": {
        "${HACK_LLM_MODEL}": { "name": "${HACK_LLM_MODEL}" }
      }
    }
  },
  "model": "hpc/${HACK_LLM_MODEL}",
  "autoupdate": false
}
EOF
cp "$SETUP_DIR/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
if [ -d "$SETUP_DIR/skills" ]; then
    mkdir -p "$HOME/.config/opencode/skills"
    cp -r "$SETUP_DIR/skills/." "$HOME/.config/opencode/skills/"
fi
ok "opencode.json, AGENTS.md, oskused"

# --- 5. Git ja GitLab ---------------------------------------------------------
say "Git ja GitLab"
git config --global credential.helper store
git config --global init.defaultBranch main
git config --global pull.rebase true        # teiste muudatused tulevad sinu omade alla, ilma merge-commitideta
git config --global rebase.autoStash true
git config --global push.autoSetupRemote true

# GitLabi kasutajanimi tuleb salvestatud paroolifailist (setup repo kloonimisel)
GL_HOST="${HACK_GITLAB_URL#*://}"; GL_HOST="${GL_HOST%%/*}"
GL_USER="$(sed -n "s|^https://\([^:]*\):.*@${GL_HOST}.*|\1|p" "$HOME/.git-credentials" 2>/dev/null | head -1)"
git config --global user.name "$NIMI"
git config --global user.email "${GL_USER:-$NIMI}@hack.local"

if git ls-remote "${HACK_GITLAB_URL%/}/${HACK_GITLAB_GROUP}/setup.git" >/dev/null 2>&1; then
  ok "GitLab ühendus töötab (${GL_USER:-?})"
else
  warn "GitLab ei vasta või parool pole salvestatud - anna mentorile märku"
fi

mkdir -p "$HOME/.local/bin"
install -m 755 "$SETUP_DIR/liitu-tiimiga" "$HOME/.local/bin/liitu-tiimiga"
ok "käsk liitu-tiimiga"

# --- 6. Shell: keskkond iga uue terminaliga -----------------------------------
say "Terminali seaded (~/.bashrc)"
MARK_BEGIN="# >>> hackathon >>>"
MARK_END="# <<< hackathon <<<"
touch "$HOME/.bashrc"
sed -i "/$MARK_BEGIN/,/$MARK_END/d" "$HOME/.bashrc"
cat >> "$HOME/.bashrc" <<EOF
$MARK_BEGIN
export MAMBA_ROOT_PREFIX="$MAMBA_ROOT"
export PATH="\$HOME/.local/bin:\$PATH"
eval "\$(micromamba shell hook --shell bash)"
micromamba activate $ENV_NAME
set -a; . "$HACK_ENV"; set +a
$MARK_END
EOF
ok "uus terminal laeb keskkonna automaatselt"

# --- 7. Töölaud ja proovikaust ------------------------------------------------
DESKTOP="$(xdg-user-dir DESKTOP 2>/dev/null || echo "$HOME/Desktop")"
mkdir -p "$DESKTOP" "$HOME/proov"
[ -d "$HOME/proov/.git" ] || git -C "$HOME/proov" init -q
[ -f "$SETUP_DIR/ALUSTA.txt" ] && cp "$SETUP_DIR/ALUSTA.txt" "$DESKTOP/ALUSTA.txt"
ok "~/proov - oma katsetuste kaust enne tiimi"

# --- 8. Mudeli test -----------------------------------------------------------
say "Testin mudeli ühendust"
if curl -fsS -m 30 "${HACK_LLM_URL%/}/chat/completions" \
     -H "Authorization: Bearer ${HACK_LLM_KEY:-none}" -H 'Content-Type: application/json' \
     -d "{\"model\":\"${HACK_LLM_MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"Ütle ainult: töötab\"}],\"max_tokens\":20}" \
     >/dev/null; then
  ok "mudel vastab"
else
  warn "mudel ei vastanud - anna mentorile märku"
fi

say "Valmis! Sulge see terminal, ava uus ja kirjuta: cd ~/proov && opencode"
