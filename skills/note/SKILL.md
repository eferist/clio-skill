---
name: note
description: Log an off-board report in DF Labs (Clio) — work you did that no task covers. Lands in your own day file under Movements, as a report with no task. Use when the member says "log this to clio", "note what I did", "off-board report", "catat kegiatan", for work with no task behind it. Writes a signed commit.
---

# Off-board report

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/clio.sh" note "<what you did, in your words>"
```

- A report with no task to hold it. It counts as a report on the day, not as a
  check-in.
- If the same kind of off-board line keeps appearing, that is a task asking to
  be minted — say so, and offer `new`.
- Confirm the wording before sending; it is a signed commit.

<!-- AUTH: calls go through clio.sh. If ~/.config/clio/token (or $CLIO_TOKEN) exists it is used as a bearer token; otherwise the script signs in once with the member's board password (from ~/.config/clio/{slug,pass} or $CLIO_PASSWORD, else prompted) and caches a 30-day cookie under ~/.config/clio/. On a login error, tell them to set ~/.config/clio/slug and provide their password once; the url defaults to https://clio.dflabs.id. Never echo the password, the token, or the cookie. -->
