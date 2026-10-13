---
name: task
description: Read one DF Labs (Clio) task in full — its brief, done-test, assignee, sprint, and the whole trail of reports on it. Use when the member asks "what happened on T-041", "show me T-052", "status of that task", "ceritain T-0xx". Read-only.
---

# One task, with its trail

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" task T-041
```

Tell the story in order: what it is (title, brief, done-test), who holds it,
which sprint, then the trail newest-last — each line is a signed report and
says what moved. If the task is `done`, the receipt is the proof; quote it.
If it is live and the trail is old, say how many days since it last moved.

<!-- AUTH: calls go through clio.sh, which signs in with the member's DF-OS pass as a bearer token, from ~/.config/clio/token (or $CLIO_TOKEN). Clio has no password sign-in. With no pass, or one that is not valid, tell them to get one from DF-OS (`hub token <their-slug>`) and save it in ~/.config/clio/token; the url defaults to https://clio.dflabs.id. Never echo the pass. -->
