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

<!-- AUTH: calls go through clio.sh, which signs in with the member's DF-OS pass as a bearer token, from ~/.config/clio/token (or $CLIO_TOKEN). Clio has no password sign-in. With no pass, or one that is not valid, tell them to get one from DF-OS (`hub token <their-slug>`) and save it in ~/.config/clio/token; the url defaults to https://clio.dflabs.id. Never echo the pass. -->
