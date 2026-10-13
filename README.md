# clio — the DF Labs board, from any Claude Code session

**Clio** is DF Labs' board at https://clio.dflabs.id. This plugin lets you read
and write it from any Claude Code session, in any folder, mid-conversation:
check in for the day, report what moved, mint a task, see what is going on.
No repo clone. One DF-OS pass, saved once.

It is a pure client. State lives on the board's server, where a git repo is
the state and every write is a commit signed with your name. Nothing here
holds a secret.

## Install

```
/plugin marketplace add eferist/clio-skill
/plugin install clio
```

Restart the session once. From then on the skills are there as `/clio:…`, and
they also fire on plain sentences like "check in", "report this to clio",
"what's on my plate".

## Sign in

You need an account on DF-OS. Ask Noel for one if you do not have it.

Clio has no password of its own: DF-OS keeps the accounts. The plugin signs in
with a DF-OS terminal pass, which you get with `hub token <your-slug>` (ask
Noel if you cannot run it). Save it once:

```sh
mkdir -p ~/.config/clio && chmod 700 ~/.config/clio
printf '%s' 'your-pass' > ~/.config/clio/token && chmod 600 ~/.config/clio/token
```

Or set `CLIO_TOKEN` in your shell instead.

## The two verbs

The board has two ways to write to it, and the skills keep them apart. Get
this right and the Thursday report writes itself.

| | Check-in | Report |
|---|---|---|
| What it says | **Who is here, and on what.** Attendance and intent. | **What happened.** Progress, with proof when it is finished. |
| Where it lands | Your own day file | The task's trail (or your day file, if no task) |
| Changes a task? | Never. Taking an unclaimed task puts your name on it, nothing more. | Yes. A report on waiting work starts it; a report with proof finishes it. |
| How often | Once a day, every day — working or resting | Every time something moves |
| Skill | `/clio:checkin` | `/clio:report` |

### Check in — `/clio:checkin`

Say what the day is for. Tasks, words, or both. Or say you are off.

> "check in — today I'm on T-041 and T-043, the deck first"
> "hari ini aku ngerjain T-055"
> "I'm off today"
> "check in on T-060, I'm taking it"  ← an unclaimed task from this week's sprint

- **Every day.** On the days you work and on the days you rest. An off day is
  a check-in too. This is how the record tells resting from vanishing.
- **Last line wins.** Changing your mind at 2pm is another check-in, not an
  edit.
- **No proof, no status.** It is planning and presence. Nothing on the board
  flags anyone for it; the Thursday report reads it from the brain.

### Report — `/clio:report`

One line about what actually happened, on one task. Recorded forever, never
edited. Your word is final; nobody approves it.

> "report on T-041: outline locked, three candidates left"
> "T-041 is done — the deck is at drive/…/deck-v3.pdf"
> "drop T-052, we decided against it"

- **A report starts the work.** Nobody sets "in progress" by hand; reporting
  on a waiting task is what starting means.
- **Finishing carries the receipt.** "Done" makes your line the proof, so it
  names what exists now that did not this morning: a link, a file, a number.
  If you cannot name it, it is not done — report the progress instead. A task
  with no done-test cannot be closed; the skill will ask for one.
- **Do not launder the day.** If the plan said X and the day produced Y, the
  report says Y. The gap is signal, not failure.
- **Backfill is the point.** Realise mid-conversation that something you just
  did is reportable? Say so. The assistant drafts the line from what you
  discussed, shows it with the task, and sends only when you confirm.

### Off the board — `/clio:note`

Work you did that no task covers. It lands in your day file as a report with
no task. If the same kind of note keeps appearing, that is a task asking to be
minted.

## The rest

| Skill | Say | Does |
|---|---|---|
| `/clio:orient` | "what's going on in DF", "show the board" | The whole board: this week's sprint, what is moving, what has gone quiet, what is homeless, each project's focus. Read-only. |
| `/clio:mine` | "what's on my plate" | Your live tasks, with projects. Read-only. |
| `/clio:today` | "who checked in today", "what happened today" | Today across the team, check-ins and reports apart. Read-only. |
| `/clio:task` | "what happened on T-041" | One task in full, with its trail. Read-only. |
| `/clio:new` | "new task: poster public" | Mint a task. Title names the result; add a done-test when the work is concrete. |
| `/clio:edit` | "assign T-041 to ahimsa", "move it to this sprint" | Properties: project, assignee, sprint, done-test, title. Never status — that is a report. |
| `/clio:focus` | "set the focus for outreach to …" | A project's one-line current focus. This is the board's prioritisation. |

Every write comes back with the commit hash the server made. The assistant
shows it to you; that hash is your receipt.

## What the board holds you to

- **The alarm lives on the work, never on a person.** A live task whose trail
  has gone quiet for days is dying and the board says so. A quiet human is
  never marked. The check-in exists so that quiet can be read.
- **Only promises that can die go on the board.** Client work and knowledge
  work get a task the day they start, or the Thursday report will not credit
  them.
- **The reporter's word is final.** No approval, no seal, no ranks.
  Accountability is provenance: every line is a commit with your name on it.

## Under the hood

One script, `scripts/clio.sh`, calls the board's HTTP API with your DF-OS
pass. Each skill is a markdown file telling the assistant when to fire and
what to send. Read them; they are short. The board's own law, the shape of a
task, a report, a check-in, lives in the Clio repo's `SPEC.md`.

Timoho's Cakruk board has a plugin of the same shape. The two share no code;
they agree on the ontology by choice, which is why one person in both houses
can carry both plugins without the assistant confusing them: every skill here
says "DF Labs" or "Clio" in its own words.

## Troubleshooting

- **"no Clio pass yet"** — save your DF-OS pass (`hub token <your-slug>`) in
  `~/.config/clio/token`.
- **"that pass is not valid"** — it has expired or was switched off. Get a new
  one with `hub token <your-slug>` and replace `~/.config/clio/token`.
- **"a viewer reads the board — it does not write to it"** — your account is a
  viewer. Ask Noel for a member account.
- **"done-test required"** — you tried to finish a task that has none. Give one
  in the same report: "…done, test: poster is public and registration is live".
- **Skills do not appear** — restart the session after install, or run
  `/plugin list` to confirm `clio@clio` is enabled.
