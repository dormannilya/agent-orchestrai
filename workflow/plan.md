---
name: Plan
description: Stage 2 of 5. Receives the Define Output Block, reads the registry, runs a three-level matching algorithm, and produces an ordered install plan. First stage where decisions are made — no installations are performed.
---

# Stage 2: Plan

> Before doing anything else, read `safety/rules.md` in full.

---

## Input

The sole input to this stage is the **Define Output Block** produced by Stage 1.

MUST NOT re-read `USER_INFO.md`, `PROJECT_INFO.md`, or the user prompt directly. All relevant signals are already extracted and classified.

If Define Output Block is absent or malformed: halt and return to Stage 1.

---

## Matching Algorithm

Plugin selection runs in three sequential levels. Do not skip levels. Do not jump to Level 3 without completing Level 2.

**Before entering Level 1:** read `registry/README.md` in full. It defines entry format, repo types (`single-skill` vs `multi-plugin`), and install command handling. Do not process any registry entry without having read it first.

---

### Level 1 — Category Filter

Read the list of files in `registry/`.

Map `Task domain` from Define Output to the corresponding registry category file(s):

| Task domain | Registry file |
|---|---|
| Design | `registry/design.md` |
| Marketing | `registry/marketing.md` |
| Development | `registry/development.md` |
| Content | `registry/content.md` |
| Other / Unknown | all registry files |

For `MULTI-DOMAIN`: load both corresponding category files. Process them in parallel in Level 2.

All registry files outside the matched categories are excluded from further analysis. Do not read them in detail.

---

### Level 2 — Semantic Scoring

Read the full contents of each matched registry category file.

For every plugin listed, score it against the Define Output signals using the following rules:

```
+2   Task domain AND task type both match best_for
+1   Task domain OR task type matches best_for (not both)
+1   Output format matches best_for or plugin description
+1   Platform or tool mentioned in Define Output matches plugin scope
-2   Any signal from Define Output explicitly appears in not_for
```

After scoring all candidates:

- Rank by total score, descending
- Discard any plugin with a score of 0 or below
- Carry the top 2–3 candidates forward to Level 3

If fewer than 2 candidates survive Level 2: carry all non-negative scorers forward.

If zero candidates survive: proceed to **No Match** handling below.

---

### Level 3 — README Verification

For each Level 2 finalist, fetch the plugin README using the raw GitHub URL stored in the registry entry.

Read the README to verify:

- Does the plugin actually cover the core of the user's task?
- Does the plugin's described output format match what Define Output expects?
- Are there any limitations, prerequisites, or scope constraints that conflict with the user's context?

After reading each README, update the candidate's assessment:

```
CONFIRMED  — README directly supports the match
INFERRED   — README implies coverage, source stated explicitly
MISSING    — README does not clarify; gap named explicitly
DISQUALIFIED — README reveals a conflict not visible in Level 2
```

Select the final plugin(s) from surviving Level 3 candidates.

---

## Selection Outcomes

### Single clear winner
One plugin with the highest score and CONFIRMED or INFERRED status after Level 3. Proceed to Plan Output.

### Multiple equal candidates
Two or more plugins with equal scores and no clear differentiator after Level 3. Present top 2–3 to the user with a concise justification for each. Ask the user to choose. Do not select unilaterally.

### MULTI-DOMAIN
Run the full three-level algorithm independently for each domain. Produce one finalist per domain. Before finalising, check for compatibility: if either plugin's `not_for` or described scope conflicts with the other, flag this explicitly and ask the user how to proceed.

Maximum two plugins per session. If MULTI-DOMAIN produces more than two finalists, ask the user to prioritise.

### No match
No plugin in the registry covers the task sufficiently. MUST NOT silently select the closest option.

Respond to the user:

> No strong match was found in the registry for your task. The closest available option is **[plugin name]**, which covers **[what it covers]** but does not address **[the gap]**. Would you like to proceed with this, or describe your task differently?

Wait for the user's response before proceeding.

---

## Decision Tracing

Every plugin in the Plan Output block MUST carry a full trace. No selection without justification.

Each signal used in the selection decision is labelled:

- `CONFIRMED` — direct match, source stated
- `INFERRED` — indirect match, reasoning stated explicitly
- `MISSING` — signal absent; acknowledged as a gap, not ignored

---

## Plan Output Block

Produce this block at the end of Stage 2. This is the input to Integrate.

```
PLAN OUTPUT
─────────────────────────────────────────────────
Selected plugin(s):
  [1] [plugin name]
      Install: [exact command from registry — verbatim]
      Score:   [Level 2 score]
      Status:  [CONFIRMED / INFERRED / MISSING per signal]
      Covers:  [what this plugin addresses for this task]
      Gap:     [what it does not cover — or NONE]

  [2] [plugin name — only if MULTI-DOMAIN or combination required]
      Install: [exact command from registry — verbatim]
      Score:   [Level 2 score]
      Status:  [CONFIRMED / INFERRED / MISSING per signal]
      Covers:  [what this plugin addresses for this task]
      Gap:     [what it does not cover — or NONE]

Rejected candidates:
  [plugin name] — [reason for rejection]

Install sequence:  [ordered list if multiple plugins — or N/A]
Compatibility:     [OK / FLAG — description if flagged]
─────────────────────────────────────────────────
Proceed to Integrate: YES / BLOCKED — [reason]
```

---

## What Plan Does NOT Do

- Does not run any installation command
- Does not modify any file in `registry/`
- Does not re-read `USER_INFO.md`, `PROJECT_INFO.md`, or the user prompt
- Does not contact GitHub beyond fetching README files for Level 3 finalists
- Does not write to `output/session_log.md`
- Does not make a unilateral selection when candidates are equal