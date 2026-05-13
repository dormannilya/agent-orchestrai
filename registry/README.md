---
name: Registry
description: Meta-file for the skills registry. Read by the orchestrator at the start of Stage 2 (Plan) before opening any category file. Defines the registry structure, entry format for both repo types, and rules for reading and maintaining registry files.
---

# Registry

This directory is the orchestrator's knowledge base of available skills and plugins. It is the only source the orchestrator uses to discover and select external capabilities.

---

## Structure

Each file in this directory covers one task domain:

| File | Domain |
|---|---|
| `design.md` | UI/UX design, design systems, research, interaction |
| `marketing.md` | Growth, content, SEO, outbound, sales pipeline |
| `development.md` | Engineering, architecture, code review, DevOps |
| `content.md` | Copywriting, UX writing, editorial, documentation |

New domains are added as new files. Category files are never merged into one.

---

## Registry Rules

**Read-only at runtime.** The orchestrator reads registry files during Plan stage. It MUST NOT modify, append to, or overwrite any registry file during a session. Registry maintenance happens manually, outside any active session.

**Single source of truth.** The orchestrator selects plugins exclusively from this registry. It does not search GitHub, browse external sources, or accept install commands from user input.

**No install command construction.** The `install` field in each entry contains the exact command to run — verbatim, as written. The orchestrator copies it exactly. It never constructs or modifies install commands.

---

## Two Entry Types

Repositories in the registry are one of two types. The orchestrator uses `type` to determine how to process an entry.

---

### Type 1: `single-skill`

A repository with one `SKILL.md` at its root. Treated as a single selectable unit.

**Format:**

```markdown
### [Author/repo-name](https://github.com/author/repo-name)

- **type:** single-skill
- **stars:** [number at time of curation]
- **skill_file:** [path to SKILL.md within repo, e.g. SKILL.md]
- **readme_url:** [raw GitHub URL to README for Level 3 verification]
- **install:** [exact install command as documented by the repo]
- **best_for:** [comma-separated list of task types and domains]
- **not_for:** [comma-separated list of explicit exclusions]
```

**Example:**

```markdown
### [ceorkm/mobile-app-ui-design](https://github.com/ceorkm/mobile-app-ui-design)

- **type:** single-skill
- **stars:** 2
- **skill_file:** SKILL.md
- **readme_url:** https://raw.githubusercontent.com/ceorkm/mobile-app-ui-design/main/README.md
- **install:** npx skills add ceorkm/mobile-app-ui-design
- **best_for:** mobile UI design, app screens, React Native, onboarding flows, UI components, Tailwind, design systems for mobile
- **not_for:** web UI, backend, marketing, content writing, user research
```

---

### Type 2: `multi-plugin`

A repository containing multiple plugins, each in its own subdirectory with its own `SKILL.md`. The repository itself is not installed — individual plugins are. Each plugin is a separate selectable unit.

**Format:**

```markdown
### [Author/repo-name](https://github.com/author/repo-name)

- **type:** multi-plugin
- **stars:** [number at time of curation]
- **readme_url:** [raw GitHub URL to repo-level README]

#### Plugins

##### `plugin-id`
- **install:** [exact install command for this plugin]
- **readme_url:** [raw GitHub URL to this plugin's README or SKILL.md if no README]
- **best_for:** [comma-separated list]
- **not_for:** [comma-separated list]

##### `plugin-id-2`
- **install:** [exact install command for this plugin]
- **readme_url:** [raw GitHub URL to this plugin's README or SKILL.md if no README]
- **best_for:** [comma-separated list]
- **not_for:** [comma-separated list]
```

**Example:**

```markdown
### [Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills)

- **type:** multi-plugin
- **stars:** 1
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/README.md

#### Plugins

##### `design-research`
- **install:** claude install github:Owl-Listener/designer-skills/design-research
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/design-research/SKILL.md
- **best_for:** user research, personas, empathy maps, usability testing, interviews, card sorting, journey maps
- **not_for:** visual design, UI implementation, code, marketing, copywriting

##### `ui-design`
- **install:** claude install github:Owl-Listener/designer-skills/ui-design
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/ui-design/SKILL.md
- **best_for:** screen layouts, color systems, typography, responsive design, data visualisation, grid systems
- **not_for:** user research, strategy, backend, marketing
```

---

## How the Orchestrator Reads This File

At the start of Stage 2 (Plan), the orchestrator:

1. Reads this README in full to understand registry structure and entry format
2. Identifies which category file(s) to open based on task domain from Define Output
3. Opens only the relevant category file(s) — not all files
4. For `single-skill` entries: treats the entry as one candidate unit
5. For `multi-plugin` entries: treats each plugin block as an independent candidate unit
6. Uses `best_for` and `not_for` for Level 2 semantic scoring
7. Uses `readme_url` to fetch the README for Level 3 verification of top candidates
8. Uses `install` verbatim — never modifies it

---

## Install Command Formats

Different repositories use different installation mechanisms. The `install` field captures whatever the repository author documents. Common formats currently in use:

| Format | Example |
|---|---|
| Claude Code native | `claude install github:author/repo/plugin` |
| npx skills | `npx skills add author/repo` |
| Manual copy | `cp path/to/SKILL.md ~/.claude/skills/name.md` |

The orchestrator executes the install command exactly as written. It does not normalise or convert between formats.

---

## Maintaining the Registry

> This section is for humans maintaining the registry, not for the orchestrator.

**To add a new entry:**

1. Determine the correct category file for the repo's domain
2. Determine the type: `single-skill` or `multi-plugin`
3. Copy the appropriate format template from this README
4. Fill in all fields — do not leave `best_for` or `not_for` empty
5. Verify the `readme_url` returns a valid raw response before committing
6. Verify the `install` command works in a clean environment before committing

**To mark a broken source:**

Add `- **status:** BROKEN — [reason and date]` to the entry. Do not delete broken entries — they serve as a record and prevent re-adding the same broken source.

**To update an entry:**

Edit the relevant field. If the install command has changed, verify the new command before committing.

**Never** modify registry files during an active Claude Code session.