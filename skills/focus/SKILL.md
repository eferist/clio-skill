---
name: focus
description: Set a DF Labs (Clio) project's current focus — the one line that says what matters most on it now. Use when the member says "set the focus for <project>", "the priority for this project is ...", "update project focus". This IS the board's prioritisation; it never ranks tasks.
---

# Set a project's current focus

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" focus capture-engine "<one line: what matters most on this project right now>"
```

- Project slugs come from `board` → `projects`.
- One line, present tense, about the project — not a task list.
- Signed commit; surface the hash.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
