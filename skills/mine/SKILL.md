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

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
