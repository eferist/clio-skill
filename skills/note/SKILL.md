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

<!-- AUTH: calls go through clio.sh, which signs in with the member's DF-OS pass as a bearer token, from ~/.config/clio/token (or $CLIO_TOKEN). Clio has no password sign-in. With no pass, or one that is not valid, tell them to get one from DF-OS (`hub token <their-slug>`) and save it in ~/.config/clio/token; the url defaults to https://clio.dflabs.id. Never echo the pass. -->
