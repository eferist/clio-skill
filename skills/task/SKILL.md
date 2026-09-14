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

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
