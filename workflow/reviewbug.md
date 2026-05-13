---
name: ReviewBug
description: Stage 4 of 5. Verifies that the integration environment is correctly assembled and ready for the plugin to execute. Does not evaluate plugin output quality. Enforces a strict 2-attempt patch limit to prevent token-burning correction loops.
---

# Stage 4: ReviewBug

> Before doing anything else, read `safety/rules.md` in full.

---

## Input

The sole input to this stage is the **Integrate Output Block** produced by Stage 3.

If Integrate Output Block is absent, malformed, or marked `BLOCKED`: halt immediately and return to Stage 3.

**The scope of this stage is strictly limited to one question:**
> Is the integration environment correctly assembled and ready for the plugin to work?

This stage does NOT evaluate plugin output. It does NOT test the quality of results. It does NOT perform the user's task.

---

## Patch Limit — Critical Rule

To prevent token-burning correction loops, this stage enforces a hard patch limit.

```
Maximum patch attempts per session: 2
```

The counter applies to the entire ReviewBug stage, not per individual issue. Once 2 patch attempts have been made, all further problems — regardless of their apparent triviality — are escalated to the user. No exceptions.

Patch attempt counter starts at 0 when this stage begins. It is incremented by 1 each time a patch is applied. It is never reset within the same session.

---

## Problem Classification

Every issue found during checks is classified before any action is taken.

| Class | Description | Permitted action |
|---|---|---|
| `TRIVIAL` | A missing or incomplete field with a single unambiguous fix | Autopatch — if patch counter < 2 |
| `STRUCTURAL` | An environment problem requiring return to Integrate or Plan | Escalate to user immediately |
| `CRITICAL` | Plugin not responding, install command mismatch, domain conflict | Stop immediately, escalate to user |

**What qualifies as TRIVIAL (autopatch permitted):**
- `USER_CONTEXT.md` exists but is missing one clearly defined section
- Session language is not explicitly stated in `USER_CONTEXT.md`
- A section in `USER_CONTEXT.md` is present but blank where source data exists to fill it

**What is NEVER autopatched — escalate immediately regardless of patch counter:**
- Plugin installation did not complete or plugin does not respond
- Install command in environment does not match the registry entry
- Selected plugin domain does not match Task domain from Define Output
- `USER_CONTEXT.md` is absent entirely
- Any issue that requires changes to installed plugin files
- Any issue that requires returning to Plan or Integrate stages

---

## Checks

Run all checks in order. Do not stop at the first failure — collect all issues, then classify and act.

### Structural Checks

```
S1 — skills/USER_CONTEXT.md exists and is non-empty
S2 — USER_CONTEXT.md contains all required sections:
       Session Language / User / Project / Task for This Session /
       Why You Were Selected / Known Gaps
S3 — Session language is explicitly stated in USER_CONTEXT.md
S4 — Task section in USER_CONTEXT.md is non-empty
S5 — USER_CONTEXT.md contains no invented content
       (all MISSING fields are marked "Not provided", not filled with assumptions)
```

### Logical Checks

```
L1 — Selected plugin domain matches Task domain from Define Output Block
L2 — Gap field in USER_CONTEXT.md matches Gap field from Plan Output Block
L3 — Install command recorded in environment matches the registry entry verbatim
L4 — If MULTI-DOMAIN: both plugins are present and both domains are represented
       in USER_CONTEXT.md
```

### Operational Checks

```
O1 — Plugin installation completed without warnings that were silently bypassed
       in Integrate stage
O2 — If MULTI-DOMAIN: install sequence was followed in correct order
O3 — No file in the installed plugin directory has been modified
       (plugin files are read-only post-install)
```

---

## Patch Procedure

### Conditions to attempt a patch

All three must be true:
1. Issue class is `TRIVIAL`
2. Patch counter is below 2
3. The fix is unambiguous — there is exactly one correct resolution

If any condition is not met: escalate immediately. Do not patch.

### Patch execution

1. Increment patch counter by 1
2. Apply the fix
3. Re-run only the checks that were affected by this patch — not the full check suite
4. Evaluate result:
   - All affected checks now pass → continue
   - Any affected check still fails → do not increment counter again, escalate immediately

### After 2 patch attempts

If patch counter has reached 2 and any issue remains unresolved:

MUST NOT attempt a third patch under any circumstance.

Report to the user:

> Two patch attempts have been made and the environment is still not fully resolved.
> Remaining issue: **[specific check that failed — exact description]**
> Class: **[TRIVIAL / STRUCTURAL / CRITICAL]**
>
> Continuing would risk further token consumption without guaranteed resolution.
> Options:
>   `return to integrate` — restart Stage 3 with the current plan
>   `return to plan`      — restart Stage 2 to select a different plugin
>   `abort`               — end this session

Wait for user instruction. Do not proceed.

---

## Escalation Responses

### STRUCTURAL issue detected

```
Stop autopatch. Report immediately:

"A structural issue was found that cannot be resolved at this stage.
 Issue: [specific check — exact description]
 This requires returning to a previous stage.
 Options:
   'return to integrate' — restart Stage 3
   'return to plan'      — restart Stage 2
   'abort'               — end this session"

Wait for user instruction.
```

### CRITICAL issue detected

```
Stop everything. Report immediately:

"A critical issue was found. The environment cannot be trusted for plugin execution.
 Issue: [specific check — exact description]
 Proceeding is not permitted.
 Options:
   'return to integrate' — restart Stage 3
   'return to plan'      — restart Stage 2
   'abort'               — end this session"

Wait for user instruction.
```

---

## ReviewBug Output Block

Produce this block at the end of Stage 4. This is the input to Verify.

```
REVIEWBUG OUTPUT
─────────────────────────────────────────────────
Structural checks:
  S1 — PASS / FAIL
  S2 — PASS / FAIL — [missing section if failed]
  S3 — PASS / FAIL
  S4 — PASS / FAIL
  S5 — PASS / FAIL

Logical checks:
  L1 — PASS / FAIL
  L2 — PASS / FAIL
  L3 — PASS / FAIL
  L4 — PASS / FAIL / N/A

Operational checks:
  O1 — PASS / FAIL
  O2 — PASS / FAIL / N/A
  O3 — PASS / FAIL

Issues found:        [enumerated list — or NONE]
Classification:      [TRIVIAL / STRUCTURAL / CRITICAL — or N/A]
Patch attempts used: [0 / 1 / 2]
Patch result:        [RESOLVED / UNRESOLVED / N/A]
─────────────────────────────────────────────────
Proceed to Verify:   YES / BLOCKED — [reason]
```

---

## What ReviewBug Does NOT Do

- Does not evaluate the quality of plugin output or task results
- Does not make more than 2 patch attempts under any circumstance
- Does not autopatch STRUCTURAL or CRITICAL issues
- Does not modify installed plugin files
- Does not re-run the full check suite after a patch — only affected checks
- Does not write to `output/session_log.md` — this is done at Verify
- Does not proceed to Verify with any unresolved STRUCTURAL or CRITICAL issue