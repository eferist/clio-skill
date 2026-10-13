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

<!-- AUTH: calls go through clio.sh, which signs in with the member's DF-OS pass as a bearer token, from ~/.config/clio/token (or $CLIO_TOKEN). Clio has no password sign-in. With no pass, or one that is not valid, tell them to get one from DF-OS (`hub token <their-slug>`) and save it in ~/.config/clio/token; the url defaults to https://clio.dflabs.id. Never echo the pass. -->
