---
name: edit
description: Edit a DF Labs (Clio) task's properties — set its project, assignee, sprint, done-test, brief, or rename it. Use when the member says "assign T-0xx to ...", "set the project", "add a done-test", "rename the task", "pindah ke sprint ini". Properties only — moving status is a report, not an edit.
---

# Edit a task's properties

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" edit T-041 project=outreach-engine
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" edit T-041 assignee=ahimsa
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" edit T-041 sprint=2026-W38
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" edit T-041 doneTest="poster public and registration live"
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" edit T-041 title="<new title>" brief="<context>"
```

- Properties: `title`, `brief`, `project`, `sprint`, `assignee`
  (comma-separated slugs allowed — shared work is one task), `unit`, `doneTest`.
- **Status is refused here.** Moving a task is a report, because every move on
  this board carries the words that justify it — use `report`.
- Putting your own name on an unclaimed task is `claim` in `checkin`.
- Each edit is a signed commit; surface the hash.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
