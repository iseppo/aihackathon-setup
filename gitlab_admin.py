#!/usr/bin/env python3
"""Häkatoni GitLabi haldus (meie, mitte osalejad). Ainult Pythoni standardteek.

GitLab (gitlab-aihackathon.hpc.ut.ee) on nähtav ainult häkatoni masinatest - käivita testmasinas.
Grupi "Hackathon" teeb Arnold; user100 on selle omanik, user001..user075 developerid.

Vaja:  export GITLAB_TOKEN=<user100 personal access token, scope api>
Valikuline: GITLAB_URL (vaikimisi https://gitlab-aihackathon.hpc.ut.ee), GITLAB_GROUP (vaikimisi hackathon)

  python3 gitlab_admin.py tiimid 15                 # setup repo ja tiim01..tiim15 grupis
  python3 gitlab_admin.py eralda                    # võta developerid grupist välja -> näevad ainult oma tiimi
  python3 gitlab_admin.py lisa tiim05 user007 ...   # lisa inimesed tiimi
  python3 gitlab_admin.py eemalda tiim05 user007    # eemalda tiimist
  python3 gitlab_admin.py nimekiri                  # tiimid ja liikmed
  python3 gitlab_admin.py varunda ~/hack-arhiiv     # kõik repod --mirror koopiana (üleandmiseks)
"""
import json
import os
import subprocess
import sys
import urllib.error
import urllib.parse
import urllib.request

URL = os.environ.get("GITLAB_URL", "https://gitlab-aihackathon.hpc.ut.ee").rstrip("/")
TOKEN = os.environ.get("GITLAB_TOKEN", "")
GROUP = os.environ.get("GITLAB_GROUP", "hackathon")
DEVELOPER = 30

TEAM_README = """# {tiim}

Iga liige töötab oma koopias (`~/{tiim}` oma masinas). Muudatused liiguvad GitLabi kaudu.

- `projekt/` - põhiprojekt, siin muudab ainult ehitaja
- `<nimi>/` - iga liikme katsetused (tekib käsuga `liitu-tiimiga`)
- `andmed/` - väljakutse andmed, ära muuda
"""
GITIGNORE = ".env\nvenv/\n.venv/\nnode_modules/\n__pycache__/\n*.sqlite\n*.db\n"


def api(method, path, data=None, ok404=False, soft=False):
    req = urllib.request.Request(
        f"{URL}/api/v4{path}",
        method=method,
        data=json.dumps(data).encode() if data is not None else None,
        headers={"PRIVATE-TOKEN": TOKEN, "Content-Type": "application/json"},
    )
    try:
        with urllib.request.urlopen(req) as r:
            body = r.read()
            return json.loads(body) if body else None
    except urllib.error.HTTPError as e:
        if ok404 and e.code == 404:
            return None
        if soft:
            return None
        sys.exit(f"GitLab {method} {path}: {e.code} {e.read().decode(errors='replace')[:300]}")


def q(s):
    return urllib.parse.quote(s, safe="")


def project(tiim, required=True):
    p = api("GET", f"/projects/{q(GROUP + '/' + tiim)}", ok404=True)
    if p is None and required:
        sys.exit(f"Projekti {GROUP}/{tiim} pole")
    return p


def user_id(username):
    u = api("GET", f"/users?username={q(username)}")
    if not u:
        sys.exit(f"Kasutajat {username} pole GitLabis")
    return u[0]["id"]


def team_name(arg):
    n = arg.removeprefix("tiim")
    return f"tiim{int(n):02d}"


def group():
    g = api("GET", f"/groups/{q(GROUP)}", ok404=True)
    if g is None:
        sys.exit(f"Gruppi {GROUP} pole (või token ei näe seda). Vaata GitLabist grupi path ja sea GITLAB_GROUP.")
    return g


def ensure_project(group_id, name, visibility, files):
    p = project(name, required=False)
    if p:
        print(f"{name} juba olemas")
        return p
    body = {"name": name, "path": name, "namespace_id": group_id, "visibility": visibility}
    p = api("POST", "/projects", body, soft=True)
    if p is None and visibility != "private":
        # privaatne grupp ei luba internal projekti
        p = api("POST", "/projects", {**body, "visibility": "private"})
        visibility = "private"
    elif p is None:
        sys.exit(f"Projekti {name} loomine ebaõnnestus")
    if files:
        api("POST", f"/projects/{p['id']}/repository/commits", {
            "branch": "main", "commit_message": "Algus",
            "actions": [{"action": "create", "file_path": f, "content": c} for f, c in files.items()],
        })
        # liikmed on Developer-id: luba neil main harusse push, aga mitte force push
        api("DELETE", f"/projects/{p['id']}/protected_branches/main", ok404=True)
        api("POST", f"/projects/{p['id']}/protected_branches", {
            "name": "main", "push_access_level": DEVELOPER, "merge_access_level": DEVELOPER,
            "allow_force_push": False,
        })
    print(f"{name} loodud ({visibility})")
    return p


def cmd_tiimid(n):
    g = group()
    ensure_project(g["id"], "setup", "internal", None)  # sisu pushime ise: setup.sh, hack.env jne
    for i in range(1, int(n) + 1):
        t = f"tiim{i:02d}"
        ensure_project(g["id"], t, "private", {
            "README.md": TEAM_README.format(tiim=t),
            ".gitignore": GITIGNORE,
            "projekt/README.md": "# Projekt\n\nSiin muudab ainult ehitaja.\n",
            "andmed/README.md": "# Andmed\n\nVäljakutse andmed. Ära muuda.\n",
        })


def cmd_lisa(tiim, *users):
    p = project(team_name(tiim))
    for u in users:
        uid = user_id(u)
        api("POST", f"/projects/{p['id']}/members", {"user_id": uid, "access_level": DEVELOPER})
        print(f"{u} -> {p['path']}")


def cmd_eemalda(tiim, *users):
    p = project(team_name(tiim))
    for u in users:
        api("DELETE", f"/projects/{p['id']}/members/{user_id(u)}", ok404=True)
        print(f"{u} eemaldatud: {p['path']}")


def cmd_eralda():
    """Developerid grupist välja: siis näeb igaüks ainult projekte, kuhu ta otse lisatud on.
    setup repo jaoks lisatakse kõik setup projekti liikmeks (Reporter = ainult lugeda)."""
    g = group()
    setup = project("setup")
    members = api("GET", f"/groups/{g['id']}/members?per_page=100")
    page = 2
    while True:
        more = api("GET", f"/groups/{g['id']}/members?per_page=100&page={page}")
        if not more:
            break
        members += more
        page += 1
    for m in members:
        if m["access_level"] >= 50:  # omanikud jäävad
            continue
        api("POST", f"/projects/{setup['id']}/members", {"user_id": m["id"], "access_level": 20}, soft=True)
        api("DELETE", f"/groups/{g['id']}/members/{m['id']}", ok404=True)
        print(f"{m['username']}: grupist välja, setup lugemisõigus jäi")


def group_projects():
    return api("GET", f"/groups/{q(GROUP)}/projects?per_page=100&order_by=path&sort=asc")


def cmd_nimekiri():
    for p in group_projects():
        if not p["path"].startswith("tiim"):
            continue
        m = api("GET", f"/projects/{p['id']}/members?per_page=100")
        print(f"{p['path']}: {', '.join(x['username'] for x in m) or '-'}")


def cmd_varunda(target):
    target = os.path.expanduser(target)
    os.makedirs(target, exist_ok=True)
    host = urllib.parse.urlsplit(URL)
    for p in group_projects():
        dest = os.path.join(target, p["path"] + ".git")
        src = f"{host.scheme}://oauth2:{TOKEN}@{host.netloc}{host.path}/{p['path_with_namespace']}.git"
        if os.path.isdir(dest):
            subprocess.run(["git", "-C", dest, "fetch", "-q", "--prune", src, "+refs/*:refs/*"], check=True)
        else:
            subprocess.run(["git", "clone", "--mirror", "-q", src, dest], check=True)
            # token ei jää arhiivi
            subprocess.run(["git", "-C", dest, "remote", "set-url", "origin", p["http_url_to_repo"]], check=True)
        print(f"{p['path']} -> {dest}")


COMMANDS = {"tiimid": cmd_tiimid, "eralda": cmd_eralda, "lisa": cmd_lisa, "eemalda": cmd_eemalda,
            "nimekiri": cmd_nimekiri, "varunda": cmd_varunda}

if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] not in COMMANDS:
        sys.exit(__doc__)
    if not TOKEN:
        sys.exit("Sea GITLAB_TOKEN (user100 personal access token, scope api)")
    COMMANDS[sys.argv[1]](*sys.argv[2:])
