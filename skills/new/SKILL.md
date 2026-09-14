---
name: new
description: Mint a new DF Labs (Clio) task. Use when the member says "new clio task", "add a task to DF", "buat task", or a brainstorm produces work worth tracking. Writes a signed commit and returns the new task id.
---

# Mint a task

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" new "<title — name the result, not the activity>"
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" new "<title>" project=capture-engine sprint=2026-W38 doneTest="<how we will know it is done>"
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" new "<title>" assignee=risang brief="<one paragraph of context>"
```

Fields (all optional after the title): `project` (slug), `sprint` (id),
`assignee` (slug — defaults to you), `doneTest`, `brief`, `unit`
(`task` or `question`).

- The title names the result. "Poster public" beats "work on poster".
- A task with no done-test cannot be finished, so ask for one when the work
  is concrete enough to have it. A `question` unit is for open questions.
- Work you take on yourself is born `self-added`; work minted for someone
  else is born `planned`. The gate decides from the assignee.
- Confirm the title and fields before sending. Surface the returned id.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
