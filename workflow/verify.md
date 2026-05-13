---
name: Verify
description: Stage 5 of 5. Validates pipeline integrity, presents a human-readable summary to the user, waits for explicit confirmation, writes the session log, and hands control to the installed plugin. The orchestrator's final action.
---

# Stage 5: Verify

> Before doing anything else, read `safety/rules.md` in full.
> The prohibition on starting without explicit user confirmation is stated in `safety/rules.md` and is enforced here as the primary gate of this stage.

---

## Input

Inputs to this stage:
- **ReviewBug Output Block** from Stage 4
- **Integrate Output Block** from Stage 3
- **Plan Output Block** from Stage 2
- **Define Output Block** from Stage 1

If ReviewBug Output Block is absent, malformed, or marked `BLOCKED`: halt immediately. Do not present a summary. Do not request confirmation.

---

## What Verify Actually Checks

Verify does not evaluate plugin output quality — the plugin has not run yet. Verify does not audit third-party plugin code. These are outside its scope.

What Verify can and does check, concretely:

### Check 1 — Pipeline Integrity

Read the final status line of each preceding stage output block.

```
Define Output    → Proceed to Plan:      must be YES
Plan Output      → Proceed to Integrate: must be YES
Integrate Output → Proceed to ReviewBug: must be YES
ReviewBug Output → Proceed to Verify:    must be YES
```

If any stage is not `YES`: halt. Report which stage is blocked and why. Do not proceed to user summary. The pipeline is incomplete.

### Check 2 — Selection Coherence

Read Define Output and Plan Output side by side:

```
V1 — Task domain (Define) matches selected plugin domain (Plan)
V2 — Task type (Define) is covered by plugin's described skills (Plan / registry)
V3 — Gap field in Plan Output is present — either a named gap or explicit NONE
V4 — No MISSING labels in Plan Output were silently ignored
       (each MISSING field was acknowledged, not substituted with assumptions)
```

If V1 or V2 fail: this is a coherence failure. Halt and report — the wrong plugin was selected.
If V3 or V4 fail: flag in the summary as a known limitation. Do not halt.

### Check 3 — Context Completeness

Read `skills/USER_CONTEXT.md` directly:

```
V5 — File exists and is non-empty
V6 — Session language is explicitly stated
V7 — Task for This Session section is non-empty
V8 — No section contains invented content
       (MISSING fields are marked "Not provided", not filled with assumptions)
```

If V5 fails: halt. Context injection failed — return to Integrate.
If V6, V7, or V8 fail: flag in the summary. Do not halt.

### Check 4 — Patch Budget

Read patch attempts used from ReviewBug Output:

```
V9 — Patch attempts used is 0, 1, or 2
```

If 2 patches were used: flag in the summary so the user is aware the environment required correction. Do not halt.

---

## Pre-Confirmation Gate

MUST NOT present the user summary until all four checks are complete.

MUST NOT request confirmation until the summary has been presented.

MUST NOT proceed to session log or plugin handoff until explicit confirmation is received.

This gate has no timeout. The orchestrator waits indefinitely for user input.

---

## User Summary

Present this in the **session language** detected at Define stage. Not in English unless English is the session language.

The summary is human-readable. It is not a technical output block. Keep it clear and concise.

```
─────────────────────────────────────────────────
Ready to launch. Here is what I've prepared:

Task:          [user's task — brief restatement from Define Output]
Plugin:        [plugin name]
Installed via: [install command]
Covers:        [2–3 bullet points from Plan Output coverage field]
Does not cover:[gap from Plan Output — or "No gaps identified"]
Your context:  [User role + Project domain — or "Not provided — working from task only"]

[If patch attempts > 0:]
Note: The environment required [1 / 2] correction(s) during setup.
      Everything is resolved and ready.

[If any V6/V7/V8/V9 flags are present:]
Known limitations: [brief plain-language description of each flag]
─────────────────────────────────────────────────
Type "yes" to launch, or "abort" to cancel.
```

---

## Confirmation Handling

**Accepted as confirmation:** `yes` — and its direct equivalents in the session language only (e.g. `да` in Russian, `sí` in Spanish). The equivalents must be unambiguous affirmatives.

**Accepted as cancellation:** `abort` — and its direct equivalents in the session language.

**Any other input:** do not interpret. Do not assume. Respond:

> I need an explicit confirmation to proceed. Please type "yes" to launch or "abort" to cancel.

Repeat the confirmation prompt. Do not re-display the full summary unless the user asks. Wait again.

**On `abort`:** write session log with outcome `ABORTED_BY_USER`. Do not launch the plugin. Respond:

> Session ended. Nothing has been launched. The session log has been saved to `output/session_log.md`.

---

## Session Log

Write to `output/session_log.md` **after confirmation, before plugin handoff**.

If the file already exists: append a new entry. Do not overwrite previous sessions.

Log entry structure:

```markdown
## Session — [date and time]

**Task:**         [user's task — one sentence]
**Plugin:**       [plugin name + install command]
**Selection basis:** [CONFIRMED / INFERRED / MISSING summary from Plan Output]
**Gap:**          [from Plan Output — or NONE]

**Pipeline status:**
  Define →    [YES / BLOCKED]
  Plan →      [YES / BLOCKED]
  Integrate → [YES / BLOCKED]
  ReviewBug → [YES / BLOCKED — patch attempts: N]
  Verify →    [YES / BLOCKED]

**Outcome:** [LAUNCHED / ABORTED_BY_USER / BLOCKED — reason if blocked]

**Broken sources flagged:** [list — or NONE]
```

If writing the log fails: report to the user and ask whether to proceed anyway or abort. Do not silently skip the log.

---

## Plugin Handoff

After writing the log:

1. Read the installed plugin's SKILL.md from the path recorded in the `Skill path` field of the Integrate Output Block.
2. Read `skills/USER_CONTEXT.md` — this is the context already prepared for the plugin.
3. Execute the user's task in full, following the plugin's SKILL.md instructions exactly. The plugin's instructions take priority over any default orchestrator behaviour. Apply them as if the plugin itself were running.

The orchestrator does not add commentary, does not explain what it is doing, and does not prefix the output with orchestrator language. From this point, all responses follow the plugin's format and style.

If the SKILL.md path is missing from the Integrate Output Block: halt and report:

> The plugin's SKILL.md path was not recorded during installation. Cannot execute the task. Please start a new session.

If the SKILL.md file does not exist at the recorded path: halt and report:

> The plugin's SKILL.md was not found at [path]. The installation may be incomplete. Please start a new session.

---

## Verify Output Block

For internal pipeline record only — not shown to the user.

```
VERIFY OUTPUT
─────────────────────────────────────────────────
Pipeline integrity:    PASS / FAIL — [stage if failed]
Selection coherence:   PASS / FLAGGED / FAIL — [check if failed]
Context completeness:  PASS / FLAGGED / FAIL — [check if failed]
Patch budget:          PASS / FLAGGED — [attempts used]

Confirmation received: YES / ABORTED / PENDING
Log written:           YES / FAILED
─────────────────────────────────────────────────
Outcome: LAUNCHED / ABORTED_BY_USER / BLOCKED — [reason]
```

---

## What Verify Does NOT Do

- Does not execute the user's task using its own knowledge — task execution follows the installed plugin's SKILL.md instructions exclusively
- Does not evaluate plugin output or task results
- Does not interpret ambiguous user input as confirmation
- Does not write the session log before receiving explicit confirmation
- Does not proceed past any failed Check 1 (pipeline integrity) or V1/V2 (coherence) failure
- Does not re-run preceding stages — failed checks result in escalation, not self-repair
- Does not guarantee the quality of the installed plugin's work