---
name: Design Registry
description: Curated skills and plugins for design tasks. Covers UI/UX design, design systems, user research, interaction design, mobile UI, prototyping, and visual design. Read by the orchestrator during Plan stage Level 1 category filtering.
---

# Design Registry

Skills and plugins for design tasks. Each entry has been manually verified for install reliability and scope accuracy.

> **Entry types used in this file:**
> - `single-skill` — one SKILL.md, installed as a single unit
> - `multi-plugin` — multiple plugins in subdirectories; each plugin is an independent selectable unit. Some multi-plugin repos install all plugins at once via a single command — noted in `install_note`.

---

## Entries

---

### [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)

- **type:** single-skill
- **stars:** 73600
- **status:** ACTIVE
- **requires:** Python 3.x (for design system search script — verify with `python3 --version` before use)
- **readme_url:** https://raw.githubusercontent.com/nextlevelbuilder/ui-ux-pro-max-skill/main/README.md
- **install:** npm install -g uipro-cli && uipro init --ai claude
- **install_note:** Two-step command — both must succeed. Installs to `~/.claude/skills/`. Alternative via Claude Code Plugin Marketplace: run `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` then `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill` inside Claude Code.
- **best_for:** UI/UX design for any platform, landing pages, SaaS interfaces, dashboards, mobile app UI, design system generation, industry-specific design rules (161 categories), component design, responsive design, visual style selection (67 styles), color palette generation, typography pairing, accessibility audit, anti-pattern checking, React/Next.js/Tailwind/Vue/SwiftUI/Flutter/React Native implementation guidance
- **not_for:** user research, qualitative interviews, usability test planning, content strategy, copywriting without visual component, backend architecture

---

### [Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills)

- **type:** multi-plugin
- **stars:** 1
- **status:** ACTIVE
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/README.md
- **install:** /plugin marketplace add Owl-Listener/designer-skills
- **install_note:** One command adds all 8 plugins to the Marketplace. Then open the Discover tab in Claude Code and install individual plugins as needed.

#### Plugins

##### `design-research`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/design-research/README.md
- **best_for:** user research, personas, empathy maps, journey maps, user interviews, usability testing, card sorting, research synthesis, insight generation
- **not_for:** visual design, UI implementation, code, marketing, copywriting, design systems

##### `design-systems`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/design-systems/README.md
- **best_for:** design tokens, component specifications, accessibility standards, theming, design system documentation, component scaffolding, system auditing
- **not_for:** user research, marketing, code implementation, content writing

##### `ux-strategy`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/ux-strategy/README.md
- **best_for:** competitive analysis, design principles, experience mapping, product direction, UX strategy, stakeholder alignment, problem framing
- **not_for:** visual design, UI implementation, user research execution, code

##### `ui-design`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/ui-design/README.md
- **best_for:** screen layouts, layout grids, color systems, typography systems, responsive design, data visualisation, UI component design
- **not_for:** user research, UX strategy, backend, marketing, content writing

##### `interaction-design`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/interaction-design/README.md
- **best_for:** micro-animations, state machines, gesture design, error handling flows, interaction feedback, motion design, transition design
- **not_for:** user research, visual identity, marketing, code implementation

##### `prototyping-testing`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/prototyping-testing/README.md
- **best_for:** prototyping strategies, usability testing plans, heuristic evaluation, A/B experiment design, fidelity decisions, test plan creation
- **not_for:** visual design execution, code, marketing, content

##### `design-ops`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/design-ops/README.md
- **best_for:** design critique frameworks, developer handoff specifications, design sprint planning, team workflows, design process documentation
- **not_for:** user research, visual design, code implementation, marketing

##### `designer-toolkit`
- **readme_url:** https://raw.githubusercontent.com/Owl-Listener/designer-skills/main/designer-toolkit/README.md
- **best_for:** design rationale documentation, design presentations, portfolio case studies, UX writing, design system adoption, design communication
- **not_for:** code, user research execution, marketing strategy, backend

---

### [ceorkm/mobile-app-ui-design](https://github.com/ceorkm/mobile-app-ui-design)

- **type:** single-skill
- **stars:** 2
- **status:** ACTIVE
- **readme_url:** https://raw.githubusercontent.com/ceorkm/mobile-app-ui-design/main/README.md
- **install:** npx skills add ceorkm/mobile-app-ui-design
- **best_for:** mobile app UI design, app screen design, React Native interfaces, Flutter UI, SwiftUI patterns, mobile onboarding flows, mobile navigation design, mobile UI components, Tailwind mobile layouts, 8-point grid, thumb-zone design, industry-specific mobile conventions (AI, crypto, finance, health)
- **not_for:** web UI, desktop interfaces, backend, marketing copy, user research, design systems documentation

---

### [awesome-skills/mobile-app-design](https://github.com/awesome-skills/mobile-app-design)

- **type:** single-skill
- **stars:** 10
- **status:** ACTIVE
- **requires:** Python 3.x (contrast checker script), bash (touch target and accessibility audit scripts)
- **readme_url:** https://raw.githubusercontent.com/awesome-skills/mobile-app-design/main/README.md
- **install:** cd ~/.claude/skills && git clone https://github.com/awesome-skills/mobile-app-design.git
- **install_note:** Manual git clone into global Claude skills directory. No `claude install` or `npx` path available. Restart Claude Code after cloning for the skill to be discovered automatically.
- **best_for:** mobile UI/UX design, iOS Human Interface Guidelines, Android Material Design 3, React Native best practices, WCAG 2.1 AA accessibility compliance, touch target validation (44pt iOS / 48dp Android), color contrast checking, platform-specific design patterns, cross-platform consistency, mobile performance optimisation, accessibility audit
- **not_for:** web UI, desktop, marketing copy, content strategy, backend, design system creation from scratch

---

### [apexscaleai/claude-ui-design-system](https://github.com/apexscaleai/claude-ui-design-system)

- **type:** multi-plugin
- **stars:** 14
- **status:** ACTIVE
- **readme_url:** https://raw.githubusercontent.com/apexscaleai/claude-ui-design-system/main/README.md
- **install_note:** All plugins install together via a single command — there is no per-plugin install path. Choose one install method; all plugins below become available simultaneously after install. Restart Claude Code after installation.
- **install_global:** cd ~/.claude/skills && git clone https://github.com/apexscaleai/claude-ui-design-system
- **install_project:** mkdir -p .claude/skills && cd .claude/skills && git clone https://github.com/apexscaleai/claude-ui-design-system
- **install_marketplace:** /plugin marketplace add apexscaleai/claude-ui-design-system — then run /plugin install ui-design-system@ui-design-system inside Claude Code

#### Plugins

##### `design-system-foundation`
- **skill_path:** foundation/design-system-foundation/
- **best_for:** new project design system setup, design tokens, folder structure, theme system, component library scaffolding, design documentation generation, greenfield projects, React Native design foundation, Next.js design foundation
- **not_for:** refactoring existing UI, marketing, content, user research, backend

##### `design-preset-system`
- **skill_path:** presets/design-preset-system/
- **best_for:** applying design presets, switching visual styles, minimalist modern, bold brutalist, soft neumorphic, glass aesthetic, timeless classic, experimental design, design style migration between presets
- **not_for:** user research, content writing, backend, new project foundation setup

##### `ui-refactoring-workflow`
- **skill_path:** refactoring/ui-refactoring-workflow/
- **best_for:** refactoring existing UI, modernising legacy components, migrating between design systems, brownfield projects, React Native component modernisation, Next.js component modernisation, applying design tokens to existing code, accessibility improvement on existing implementations
- **not_for:** new project setup, user research, content, backend, marketing

##### `aesthetic-excellence`
- **skill_path:** enhancement/aesthetic-excellence/
- **best_for:** improving visual hierarchy, spacing refinement, typography improvement, animation enhancement, accessibility upgrade, WCAG compliance improvement, micro-interactions, universal UI polish regardless of stack or framework
- **not_for:** user research, content strategy, backend, new design system setup from scratch