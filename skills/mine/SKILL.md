---
name: mine
description: Show the DF Labs (Clio) tasks assigned to you — your plate. Live tasks first (doing, then todo), with their projects and how long each has been quiet. Use when the member asks "what's on my plate", "my clio tasks", "what am I on in DF", "tugasku di DF apa". Read-only.
---

# Your plate on Clio

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" mine
```

Print a tight list: `doing` first, then `todo`, then anything closed only if
asked. For each: id, title, project, and the last trail line's date if it is
old — a live task that has not moved in days is the one to ask about.

If they then want to say what they are on today, that is `checkin`; if they
want to say what happened on one of these, that is `report`. Do not blur the two.

<!-- AUTH: calls go through clio.sh, which signs in with the member's DF-OS pass as a bearer token, from ~/.config/clio/token (or $CLIO_TOKEN). Clio has no password sign-in. With no pass, or one that is not valid, tell them to get one from DF-OS (`hub token <their-slug>`) and save it in ~/.config/clio/token; the url defaults to https://clio.dflabs.id. Never echo the pass. -->
