---
name: today
description: See what's been going on in DF Labs (Clio) today — who checked in, who is off, and what got reported, across the team. Use when the member asks "what happened today in DF", "who checked in", "activity today", "siapa yang sudah check-in", "apa yang terjadi hari ini di clio". Read-only.
---

# Today on Clio

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" board
```

Read `views.today`: one flat list, sorted by time, of two kinds of line —

- **check-ins** — `kind: "commitment"`. What a person said they are on
  (`tasks`, `text`), or `off: true` for a rest day. Attendance and intent.
- **reports** — everything else. A trail line on a task (`task` set) or an
  off-board line (`task` null). What actually moved.

Present them apart, in two short groups, each line as `time · name · words`.
For check-ins, say plainly who is off today. Then `members[].today` tells you
who has said nothing at all — mention it as a fact, never as a verdict: the
board does not flag people.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
