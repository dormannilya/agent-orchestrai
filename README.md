<div align="center">

# 🤖 Agent-Orchestrai

**The open-source Claude Code orchestrator that finds the right skill for any task — automatically.**

[![License: MIT](https://img.shields.io/badge/License-MIT-black?style=flat-square)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Compatible-orange?style=flat-square)](https://docs.anthropic.com/en/docs/claude-code)
[![Skills: Design](https://img.shields.io/badge/Skills-Design_✓-green?style=flat-square)](#skill-registry)
[![Status](https://img.shields.io/badge/Status-PoC_Complete-blue?style=flat-square)](#)

</div>

---

<details open>
<summary><b>🇬🇧 English</b> &nbsp;·&nbsp; <a href="#russian">Русский ↓</a></summary>

<br>

## What is Agent-Orchestrai?

Agent-Orchestrai is a **Claude Code orchestrator** — not an agent that solves tasks directly, but one that finds the right specialist agent for each task, installs it, briefs it with your context, and hands control over.

Think of it as a staffing agency: you describe what you need, the orchestrator finds the best available expert, and the expert does the work.

```
You describe a task → Orchestrator finds the right skill → Skill executes → You get the result
```

**No configuration. No skill selection. Just describe your task.**

---

## How It Works

Every session runs through a fixed 5-stage pipeline:

```
📋 Define  →  🎯 Plan  →  ⚙️ Integrate  →  🔍 ReviewBug  →  ✅ Verify → 🚀 Execute
```

| Stage | What happens |
|---|---|
| **📋 Define** | Reads your task, context files, and detects language. No decisions yet. |
| **🎯 Plan** | Scans the skill registry using a 3-level matching algorithm. Scores every candidate. Reads READMEs of top picks. |
| **⚙️ Integrate** | Installs the selected skill. Injects your user/project context. Resolves the SKILL.md path. |
| **🔍 ReviewBug** | Verifies the environment is correct. Up to 2 auto-patches for minor issues. Escalates anything structural. |
| **✅ Verify** | Presents a summary. Waits for your explicit `yes`. Writes session log. |
| **🚀 Execute** | Reads the plugin's SKILL.md and executes your task following its instructions — in the same session. |

### Matching Algorithm

The Plan stage uses a **3-level algorithm** to find the best skill:

1. **Category Filter** — maps your task domain to the right registry file (`design`, `marketing`, etc.)
2. **Semantic Scoring** — scores every plugin: `+2` for direct match, `+1` for partial, `−2` for explicit exclusion
3. **README Verification** — fetches and reads the actual README of top candidates to confirm coverage

---

## Who Is It For?

| User | Use case |
|---|---|
| **Marketers** | Generate landing pages, campaigns, content specs without writing a prompt from scratch |
| **Designers** | Get the right design tool activated with your project brand context already loaded |
| **Developers** | Delegate repetitive tasks to verified skill agents |
| **Founders & consultants** | Describe what you need in plain language — the orchestrator handles the rest |
| **Teams** | Share `USER_INFO.md` and `PROJECT_INFO.md` across the team for consistent context |

**Minimum technical requirement:** able to run `bash` and clone a git repository. No coding required.

---

## Skill Registry

The orchestrator selects skills from a curated, hand-verified registry. Quality over quantity.

| Domain | Available Skills | Status |
|---|---|---|
| 🎨 **Design** | UI/UX Pro Max · Designer Skills (8 plugins) · Mobile App UI · Mobile App Design Standards · UI Design System | ✅ Active |
| 📣 **Marketing** | — | 🔜 Coming |
| 💻 **Development** | — | 🔜 Coming |
| ✍️ **Content** | — | 🔜 Coming |

> Skills are sourced from verified public GitHub repositories. Each entry includes `best_for`, `not_for`, `readme_url`, and exact install commands. No hallucinated capabilities.

---

## Quick Start

**One command to install:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dormannilya/agent-orchestrai/main/installer.sh)
```

Or manually:

```bash
git clone https://github.com/dormannilya/agent-orchestrai.git
cd agent-orchestrai
```

**Then:**

1. *(Optional)* Fill in `USER_INFO.md` — your role, skills, preferences
2. *(Optional)* Fill in `PROJECT_INFO.md` — your project context
3. Open [Claude Code](https://docs.anthropic.com/en/docs/claude-code), connect this repository
4. Describe your task in plain language

**That's it.** The orchestrator handles everything else.

---

## Context Files

Two optional files that make every result more relevant:

**`USER_INFO.md`** — who you are
```
Role: UX Designer
Industry: EdTech
Primary skills: Figma, user research, usability testing
Output style: Concise, structured documents
Language: Russian
```

**`PROJECT_INFO.md`** — your project
```
Name: MyApp
Type: B2B SaaS
Stage: MVP
Tone of voice: Professional, data-driven
Hard limits: WCAG 2.1 AA required
```

If neither file is filled in — the orchestrator works from your prompt alone. No blocking.

---

## Example Session

<details>
<summary><b>📋 View real session log — fitness app landing page design</b></summary>

```
Prompt (Russian): "Спроектируй дизайн лендинга для фитнес-приложения.
                   Один экран: заголовок, короткое описание и кнопка скачать."

─────────────────────────────────────────────────
Stage 1 — Define
  Language detected:  Russian
  Task domain:        Design (landing page)
  Task type:          create
  User context:       MISSING (files not filled)
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Stage 2 — Plan
  Candidates scored:
    nextlevelbuilder/ui-ux-pro-max-skill  → +4  CONFIRMED
    Owl-Listener/designer-skills/ui-design → +2  CONFIRMED
    ceorkm/mobile-app-ui-design            → -1  not_for: web UI
    awesome-skills/mobile-app-design       → -1  not_for: web UI
  README verified: ui-ux-pro-max — landing pages explicitly confirmed
  Winner: nextlevelbuilder/ui-ux-pro-max-skill
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Stage 3 — Integrate
  Install: npm install -g uipro-cli && uipro init --ai claude
  Result:  SUCCESS — 23 packages
  SKILL.md: .claude/skills/ui-ux-pro-max/SKILL.md  ✓
  USER_CONTEXT.md: WRITTEN
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Stage 4 — ReviewBug
  All checks: PASS (S1–S5, L1–L4, O1–O3)
  Patch attempts: 0
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Stage 5 — Verify → user confirmed "да"
  Session log: WRITTEN
  Plugin SKILL.md: READ
  Task: EXECUTED
─────────────────────────────────────────────────

Result: fitness-landing.html generated
  Pattern:    App Store Style Landing
  Colors:     Primary #0EA5E9 · CTA #F97316
  Typography: Barlow Condensed / Barlow
  Checklist:  WCAG AA · responsive · prefers-reduced-motion ✓
```

</details>

---

## Roadmap

- [x] 5-stage pipeline (Define → Plan → Integrate → ReviewBug → Verify → Execute)
- [x] 3-level matching algorithm with semantic scoring
- [x] Design skill registry (4 sources, 12+ plugins)
- [x] User/project context injection
- [x] Session logging
- [x] Multi-install format support (`claude install`, `npx skills add`, `git clone`, CLI)
- [ ] Marketing skill registry
- [ ] Development skill registry
- [ ] Content skill registry
- [ ] GitHub star-based quality filtering
- [ ] MULTI-DOMAIN session support (two skills per task)
- [ ] GitHub Pages landing

---

## Repository Structure

```
agent-orchestrai/
├── CLAUDE.md               ← Orchestrator brain (entry point)
├── USER_INFO.md            ← Fill in: who you are
├── PROJECT_INFO.md         ← Fill in: your project
├── installer.sh            ← One-command setup
│
├── registry/
│   ├── README.md           ← How the registry works
│   └── design.md           ← Verified design skills
│
├── workflow/
│   ├── define.md           ← Stage 1
│   ├── plan.md             ← Stage 2 (matching algorithm)
│   ├── integrate.md        ← Stage 3 (install + context)
│   ├── reviewbug.md        ← Stage 4 (verification)
│   └── verify.md           ← Stage 5 (confirmation + execution)
│
├── safety/
│   └── rules.md            ← Absolute prohibitions
│
├── templates/
│   ├── USER_INFO.template.md
│   └── PROJECT_INFO.template.md
│
├── skills/                 ← Runtime: USER_CONTEXT.md written here
└── output/                 ← Session logs
```

---

## More Projects

### [🔗 BNLab](https://bnlab.tech)
> *А service for assessing risks and feasibility in the development and implementation of AI*

### [🔗 VibeDev](https://vibedevelopers.ru)
> *AI-assisted development studio with an engineering approach*

---

## License & Contributing

MIT License — use freely, build on top, contribute back.

To add a skill to the registry: verify the install command works, fill in `best_for` / `not_for` / `readme_url`, and open a PR to the relevant `registry/*.md` file.

</details>

---

<a name="russian"></a>

<details>
<summary><b>🇷🇺 Русский</b> &nbsp;·&nbsp; <a href="#">English ↑</a></summary>

<br>

## Что такое Agent-Orchestrai?

Agent-Orchestrai — это **оркестратор для Claude Code**. Он не решает задачи самостоятельно — он находит подходящего специализированного агента для каждой задачи, устанавливает его, передает ему контекст о вас и вашем проекте, и уступает место.

Думайте о нем как о кадровом агентстве: вы описываете задачу, оркестратор подбирает лучшего доступного специалиста, специалист выполняет работу.

```
Вы описываете задачу → Оркестратор находит нужный скилл → Скилл выполняет задачу → Вы получаете результат
```

**Никакой настройки. Никакого выбора скилла вручную. Просто опишите задачу.**

---

## Как это работает

Каждая сессия проходит через фиксированный pipeline из 5 этапов:

```
📋 Define  →  🎯 Plan  →  ⚙️ Integrate  →  🔍 ReviewBug  →  ✅ Verify → 🚀 Execute
```

| Этап | Что происходит |
|---|---|
| **📋 Define** | Читает вашу задачу, контекстные файлы, определяет язык. Решений не принимает. |
| **🎯 Plan** | Сканирует реестр скиллов трехуровневым алгоритмом. Оценивает каждого кандидата. Читает README лучших. |
| **⚙️ Integrate** | Устанавливает выбранный скилл. Инжектирует контекст пользователя/проекта. Фиксирует путь к SKILL.md. |
| **🔍 ReviewBug** | Проверяет корректность окружения. До 2 автоматических патчей для мелких проблем. |
| **✅ Verify** | Показывает итоговое резюме. Ждет явного `да`. Пишет лог сессии. |
| **🚀 Execute** | Читает SKILL.md плагина и выполняет вашу задачу по его инструкциям — в той же сессии. |

### Алгоритм матчинга

На этапе Plan используется **3-уровневый алгоритм** подбора скилла:

1. **Категориальный фильтр** — определяет домен задачи и открывает нужный файл реестра
2. **Семантический скоринг** — оценивает каждый плагин: `+2` за прямое совпадение, `+1` за частичное, `−2` за явное исключение
3. **Верификация README** — загружает и читает реальный README топ-кандидатов для подтверждения покрытия

---

## Для кого

| Пользователь | Сценарий |
|---|---|
| **Маркетологи** | Генерация лендингов, кампаний, контент-спецификаций без самостоятельного выбора инструмента |
| **Дизайнеры** | Нужный дизайн-инструмент активируется с уже загруженным контекстом вашего бренда |
| **Разработчики** | Делегирование повторяющихся задач проверенным агентам |
| **Фаундеры и консультанты** | Описываете задачу на естественном языке — оркестратор разбирается сам |
| **Команды** | Общий `USER_INFO.md` и `PROJECT_INFO.md` для консистентного контекста |

**Минимальный технический порог:** умение запустить `bash` и клонировать git-репозиторий. Кодировать не нужно.

---

## Реестр скиллов

Оркестратор выбирает скиллы из курируемого и проверенного вручную реестра. Качество важнее количества.

| Домен | Доступные скиллы | Статус |
|---|---|---|
| 🎨 **Design** | UI/UX Pro Max · Designer Skills (8 плагинов) · Mobile App UI · Mobile Design Standards · UI Design System | ✅ Активно |
| 📣 **Marketing** | — | 🔜 Скоро |
| 💻 **Development** | — | 🔜 Скоро |
| ✍️ **Content** | — | 🔜 Скоро |

> Скиллы берутся из проверенных публичных GitHub-репозиториев. Каждая запись содержит `best_for`, `not_for`, `readme_url` и точную команду установки. Никаких выдуманных возможностей.

---

## Быстрый старт

**Одной командой:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dormannilya/agent-orchestrai/main/installer.sh)
```

Или вручную:

```bash
git clone https://github.com/dormannilya/agent-orchestrai.git
cd agent-orchestrai
```

**Затем:**

1. *(Опционально)* Заполните `USER_INFO.md` — ваша роль, навыки, предпочтения
2. *(Опционально)* Заполните `PROJECT_INFO.md` — контекст вашего проекта
3. Откройте [Claude Code](https://docs.anthropic.com/en/docs/claude-code), подключите репозиторий
4. Опишите задачу на любом языке

**Все.** Оркестратор делает остальное.

---

## Контекстные файлы

Два опциональных файла, которые делают каждый результат точнее:

**`USER_INFO.md`** — кто вы
```
Role: UX Designer
Industry: EdTech
Primary skills: Figma, user research, usability testing
Output style: Concise, structured documents
Language: Russian
```

**`PROJECT_INFO.md`** — ваш проект
```
Name: MyApp
Type: B2B SaaS
Stage: MVP
Tone of voice: Professional, data-driven
Hard limits: WCAG 2.1 AA required
```

Если файлы не заполнены — оркестратор работает только от вашего промпта. Ничего не блокируется.

---

## Пример сессии

<details>
<summary><b>📋 Реальный лог сессии — дизайн лендинга для фитнес-приложения</b></summary>

```
Промпт: "Спроектируй дизайн лендинга для фитнес-приложения.
          Один экран: заголовок, короткое описание и кнопка скачать."

─────────────────────────────────────────────────
Этап 1 — Define
  Язык сессии:        Русский
  Домен задачи:       Design (лендинг)
  Тип задачи:         create
  Контекст:           MISSING (файлы не заполнены)
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Этап 2 — Plan
  Кандидаты:
    nextlevelbuilder/ui-ux-pro-max-skill  → +4  CONFIRMED
    Owl-Listener/designer-skills/ui-design → +2  CONFIRMED
    ceorkm/mobile-app-ui-design            → -1  not_for: web UI
    awesome-skills/mobile-app-design       → -1  not_for: web UI
  README верифицирован: landing pages явно подтверждены
  Победитель: nextlevelbuilder/ui-ux-pro-max-skill
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Этап 3 — Integrate
  Команда: npm install -g uipro-cli && uipro init --ai claude
  Результат: SUCCESS — 23 пакета
  SKILL.md: .claude/skills/ui-ux-pro-max/SKILL.md  ✓
  USER_CONTEXT.md: WRITTEN
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Этап 4 — ReviewBug
  Все проверки: PASS (S1–S5, L1–L4, O1–O3)
  Патчи: 0
─────────────────────────────────────────────────

─────────────────────────────────────────────────
Этап 5 — Verify → пользователь подтвердил "да"
  Лог сессии: WRITTEN
  SKILL.md плагина: READ
  Задача: ВЫПОЛНЕНА
─────────────────────────────────────────────────

Результат: output/fitness-landing.html
  Паттерн:      App Store Style Landing
  Цвета:        Primary #0EA5E9 · CTA #F97316
  Типографика:  Barlow Condensed / Barlow
  Чеклист:      WCAG AA · responsive · prefers-reduced-motion ✓
```

</details>

---

## Roadmap

- [x] Pipeline из 5 этапов (Define → Plan → Integrate → ReviewBug → Verify → Execute)
- [x] 3-уровневый алгоритм матчинга с семантическим скорингом
- [x] Реестр дизайн-скиллов (4 источника, 12+ плагинов)
- [x] Инжект контекста пользователя/проекта
- [x] Логирование сессий
- [x] Поддержка нескольких форматов установки (`claude install`, `npx skills add`, `git clone`, CLI)
- [ ] Реестр маркетинговых скиллов
- [ ] Реестр скиллов разработки
- [ ] Реестр контентных скиллов
- [ ] Фильтрация по количеству GitHub stars
- [ ] Поддержка MULTI-DOMAIN сессий (два скилла на одну задачу)
- [ ] Лендинг на GitHub Pages

---

## Структура репозитория

```
agent-orchestrai/
├── CLAUDE.md               ← Мозг оркестратора (точка входа)
├── USER_INFO.md            ← Заполните: кто вы
├── PROJECT_INFO.md         ← Заполните: ваш проект
├── installer.sh            ← Установка одной командой
│
├── registry/
│   ├── README.md           ← Как работает реестр
│   └── design.md           ← Проверенные дизайн-скиллы
│
├── workflow/
│   ├── define.md           ← Этап 1
│   ├── plan.md             ← Этап 2 (алгоритм матчинга)
│   ├── integrate.md        ← Этап 3 (установка + контекст)
│   ├── reviewbug.md        ← Этап 4 (верификация)
│   └── verify.md           ← Этап 5 (подтверждение + выполнение)
│
├── safety/
│   └── rules.md            ← Абсолютные запреты
│
├── templates/
│   ├── USER_INFO.template.md
│   └── PROJECT_INFO.template.md
│
├── skills/                 ← Runtime: здесь записывается USER_CONTEXT.md
└── output/                 ← Логи сессий
```

---

## Другие проекты

### [🔗 БНɅаб](https://bnlab.tech)
> *Сервис оценки рисков и целесообразности при разработке и внедрении ИИ*

### [🔗 ВайбДев](https://vibedevelopers.ru)
> *Студия ИИ-ассистированной разработки с инженерным подходом*

---

## Лицензия и вклад

Лицензия MIT — используйте свободно, стройте поверх, присылайте PR.

Чтобы добавить скилл в реестр: проверьте что команда установки работает, заполните `best_for` / `not_for` / `readme_url`, откройте PR в нужный файл `registry/*.md`.

</details>