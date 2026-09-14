---
name: orient
description: Get oriented on the whole DF Labs board (Clio) — this week's sprint, what's moving, what's gone quiet, what's homeless — so the assistant has context before a brainstorm or a planning talk. Use when the member asks "what's going on in clio", "show the board", "give me the state of DF", "reorient me", "apa kabar board". Read-only, covers everyone's work, not just theirs.
---

# Orient on the DF Labs board

Pull the whole board and summarize it in your own words — never dump raw JSON.

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" board
```

From the payload:
- `currentSprint` and `week` — the week the house is on, and how it stands.
- `tasks` — live work by status (`doing` vs waiting `todo`), grouped by project.
- `views.stale` — **gone quiet**: live tasks whose trail has been silent for days. The alarm sits on the work, never on a person; say which tasks, not who.
- `views.backlog` — **homeless**: live work under no active project.
- `views.committed` and each member's `today` — who has checked in today and on what.
- `projects` — each one's current focus line, which IS the house's prioritisation.

Keep it short: the sprint in one line, then moving / quiet / homeless, then the
focus lines. End by asking what the member wants to dig into.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
