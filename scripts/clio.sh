#!/usr/bin/env bash
# clio.sh — thin HTTP client for the DF Labs board (Clio).
#
# One way in: your DF-OS terminal pass, used as a bearer token
# (~/.config/clio/token or $CLIO_TOKEN). Get it from DF-OS with
# `hub token <slug>`. Clio has no password sign-in of its own any more — DF-OS
# keeps the accounts (audit, 2026-10-13). No repo clone: any Claude Code
# session can read and write the board.
# State lives on the server; every write comes back with its commit hash.
#
# Usage:
#   clio.sh board                                   the whole board (JSON)
#   clio.sh mine                                    your live tasks
#   clio.sh task    <id>                            one task, with its trail
#   clio.sh checkin <text> [id,id,...]              check in: what you're on today
#   clio.sh off     [text]                          check in as off today
#   clio.sh claim   <id>                            put your name on an unclaimed task
#   clio.sh report  <id> <text> [status] [doneTest] the verb (status: done|dropped|archived|doing|todo)
#   clio.sh note    <text>                          off-board report → your day file
#   clio.sh new     <title> [field=value ...]       mint a task (project|sprint|assignee|doneTest|brief|unit)
#   clio.sh edit    <id> field=value ...            task properties (title|brief|project|sprint|assignee|unit|doneTest)
#   clio.sh focus   <slug> <line>                   set a project's current focus
#   clio.sh raw     <METHOD> <path> [jsonBody]      escape hatch
#
# Config dir  ~/.config/clio  (override with $CLIO_CONFIG):
#   url     base URL           (default https://clio.dflabs.id)
#   token   your DF-OS pass, chmod 600 (or $CLIO_TOKEN) — from `hub token <slug>`
set -euo pipefail

CFG="${CLIO_CONFIG:-$HOME/.config/clio}"
mkdir -p "$CFG"; chmod 700 "$CFG" 2>/dev/null || true
URL="$(cat "$CFG/url" 2>/dev/null || echo 'https://clio.dflabs.id')"; URL="${URL%/}"
TOKEN="${CLIO_TOKEN:-$(cat "$CFG/token" 2>/dev/null || true)}"

# JSON-encode one argument safely (quotes, newlines, unicode).
jenc() { python3 -c 'import json,sys; sys.stdout.write(json.dumps(sys.argv[1]))' "$1"; }
# Build a JSON object from key=value pairs whose values are already JSON.
jobj() { python3 - "$@" <<'PY'
import json,sys
o={}
for kv in sys.argv[1:]:
    k,_,v=kv.partition('=')
    o[k]=json.loads(v)
sys.stdout.write(json.dumps(o))
PY
}
# A comma list of ids → JSON array, uppercased and trimmed.
jids() { python3 -c 'import json,sys; print(json.dumps([x.strip().upper() for x in sys.argv[1].split(",") if x.strip()]))' "$1"; }

req() { # METHOD PATH [JSONBODY]
  local m="$1" p="$2" body="${3:-}"
  local -a auth=(-H "Authorization: Bearer $TOKEN")
  if [ -n "$body" ]; then
    curl -sS --max-time 25 "${auth[@]}" -X "$m" "$URL$p" -H 'Content-Type: application/json' -d "$body"
  else
    curl -sS --max-time 25 "${auth[@]}" -X "$m" "$URL$p"
  fi
}

logged_in() { req GET /api/me 2>/dev/null | grep -q '"slug"'; }

ensure_auth() {
  [ -n "$TOKEN" ] || { echo "no Clio pass yet — get one from DF-OS (hub token <your-slug>) and save it in $CFG/token" >&2; exit 1; }
  logged_in || { echo "that pass is not valid — get a new one from DF-OS (hub token <your-slug>) and save it in $CFG/token" >&2; exit 1; }
}

cmd="${1:-mine}"; shift || true
case "$cmd" in
  board)   ensure_auth; req GET /api/board ;;
  mine)    ensure_auth; req GET "/api/tasks?mine=1" ;;
  task)    ensure_auth; req GET "/api/tasks/$(echo "$1" | tr a-z A-Z)" ;;
  checkin) ensure_auth
           text="${1:-}"; ids="${2:-}"
           req POST /api/commit "$(jobj "text=$(jenc "$text")" "tasks=$(jids "$ids")")" ;;
  off)     ensure_auth
           req POST /api/commit "$(jobj "text=$(jenc "${1:-off today}")" "tasks=[]" "off=true")" ;;
  claim)   ensure_auth
           me="$(req GET /api/me | python3 -c 'import json,sys; print(json.load(sys.stdin)["slug"])')"
           req PATCH "/api/tasks/$(echo "$1" | tr a-z A-Z)" "$(jobj "assignee=$(jenc "$me")")" ;;
  report)  ensure_auth
           id="$(echo "$1" | tr a-z A-Z)"; text="$2"; status="${3:-}"; dt="${4:-}"
           parts=("text=$(jenc "$text")")
           [ -n "$status" ] && parts+=("status=$(jenc "$status")")
           [ -n "$dt" ]     && parts+=("doneTest=$(jenc "$dt")")
           req POST "/api/tasks/$id/report" "$(jobj "${parts[@]}")" ;;
  note)    ensure_auth; req POST /api/report "$(jobj "text=$(jenc "$1")")" ;;
  new)     ensure_auth
           title="$1"; shift
           parts=("title=$(jenc "$title")")
           for kv in "$@"; do parts+=("${kv%%=*}=$(jenc "${kv#*=}")"); done
           req POST /api/tasks "$(jobj "${parts[@]}")" ;;
  edit)    ensure_auth
           id="$(echo "$1" | tr a-z A-Z)"; shift
           parts=()
           for kv in "$@"; do parts+=("${kv%%=*}=$(jenc "${kv#*=}")"); done
           [ ${#parts[@]} -eq 0 ] && { echo "usage: edit <id> field=value ...  (title|brief|project|sprint|assignee|unit|doneTest)" >&2; exit 2; }
           req PATCH "/api/tasks/$id" "$(jobj "${parts[@]}")" ;;
  focus)   ensure_auth; req PATCH "/api/projects/$1" "$(jobj "focus=$(jenc "$2")")" ;;
  raw)     ensure_auth; req "$1" "$2" "${3:-}" ;;
  *)       echo "unknown command: $cmd (see header for usage)" >&2; exit 2 ;;
esac
echo
