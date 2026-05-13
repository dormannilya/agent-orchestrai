---
name: Define
description: Stage 1 of 5. Reads all available input sources, extracts structured signals, detects language, and produces a single context block passed to Plan. Makes no decisions — only collects and classifies.
---

# Stage 1: Define

> Before doing anything else, read `safety/rules.md` in full.

---

## Pre-Check: Prompt Required

Before entering this stage, verify that the user has provided a prompt describing their task.

If no prompt is present:

MUST NOT proceed into Define or any subsequent stage.

Respond to the user immediately:

> I'm ready to work — but I don't know what to do yet. Please describe your task, and we'll get started.

Wait for a prompt. Do not guess. Do not proceed.

---

## Input Sources

Read in this exact order:

### Level 1 — Contextual (optional)

1. `USER_INFO.md` — who the user is: role, competencies, priorities, typical tasks
2. `PROJECT_INFO.md` — project, product, domain, brand, constraints

If either file is absent, empty, or partially filled: mark affected fields as `MISSING`. Do not halt. Do not invent.

### Level 0 — Required

3. **User prompt** — the specific task for this session

The prompt is the only mandatory input. It takes priority over all Level 1 data in the event of any conflict.

---

## What to Extract

### From USER_INFO.md + PROJECT_INFO.md (if present)

- User role and competency domain (e.g. marketer, UX designer, backend developer)
- Project domain (e.g. EdTech, SaaS, e-commerce, agency)
- Known constraints or preferences explicitly stated
- **Session language** — detected here, fixed for the entire session

### From the user prompt

- **Primary task domain** — Design / Marketing / Development / Content / Other
- **Secondary task domain** — only if the task explicitly spans two domains (`MULTI-DOMAIN`)
- **Task type** — one of: `create` / `audit` / `analyze` / `optimize` / `research` / `other`
- **Expected output format** — document, strategy, code, UI spec, report, etc.
- **Platform or tool** — if explicitly mentioned
- **Constraints** — deadlines, format restrictions, scope limits, if any

---

## Edge Case Handling

**Conflict between prompt and Level 1 files**
Prompt wins. Level 1 data remains as supporting context. Log the conflict explicitly in the Define Output block.

**Multi-domain task**
If the task clearly spans two domains (e.g. UX strategy + copywriting), mark both. Plan will search both categories in the registry. Do not force a single domain.

**Fully empty context (no USER_INFO, no PROJECT_INFO)**
Acceptable. Extract all signals from the prompt alone. Mark all non-prompt fields as `MISSING`. Proceed normally.

**Ambiguous task domain**
If the primary domain cannot be determined from any available source — ask the user exactly one clarifying question. Wait for the answer. Do not guess. Do not proceed until the domain is clear.

---

## Language Detection

Determine the session language from the following, in order of priority:

1. `USER_INFO.md` — if language or locale is explicitly stated
2. `PROJECT_INFO.md` — if language context is present
3. User prompt — language of the prompt text itself

Once detected, the session language is fixed. All orchestrator responses from this point forward are in that language.

If language cannot be determined: default to English.

---

## Define Output Block

Produce this block at the end of Stage 1. This is the input to Plan.

```
DEFINE OUTPUT
─────────────────────────────────────────────────
Session language:   [language]
User role:          [value — CONFIRMED / INFERRED / MISSING]
Project domain:     [value — CONFIRMED / INFERRED / MISSING]
Task domain:        [primary] / [secondary if MULTI-DOMAIN]
Task type:          [create / audit / analyze / optimize / research / other]
Output format:      [value — CONFIRMED / INFERRED / MISSING]
Platform / tool:    [value — or MISSING]
Constraints:        [value — or NONE]
Conflicts:          [description — or NONE]
─────────────────────────────────────────────────
Proceed to Plan:    YES / BLOCKED — [reason]
```

`BLOCKED` is only valid if a clarifying question was asked and the user's answer still did not resolve the task domain. In all other cases, proceed.

---

## What Define Does NOT Do

- Does not open or read any file in `registry/`
- Does not suggest or evaluate plugins
- Does not draw conclusions about whether a matching skill exists
- Does not write to `output/session_log.md`
- Does not perform any installation or preparation actions