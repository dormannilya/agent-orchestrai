---
name: Project Info Template
description: Annotated reference for filling in PROJECT_INFO.md. Each field includes a description of what to write and an example. Copy the structure into PROJECT_INFO.md — do not work in this file directly.
---

# Project Info — Template & Guide

> This is a reference file. Fill in `PROJECT_INFO.md`, not this file.
> All fields are optional. Fill in what exists and is relevant.
> If you have no active project, leave `PROJECT_INFO.md` empty — the orchestrator handles this gracefully.
> You may add fields that are not listed here — the orchestrator will read them.

---

## Project Identity

**Name**
The name of the product, project, service, or initiative.
```
Examples:
  Orbit — B2B analytics dashboard
  The Growth Newsletter
  Client onboarding redesign (internal project)
  Unnamed MVP (stealth)
```

**Type**
What kind of thing this is.
```
Examples:
  B2B SaaS product
  Mobile application
  E-commerce store
  Content / media brand
  Internal tool
  Agency client project
  Community or membership platform
  Physical product with digital presence
```

**Industry**
The sector this project operates in.
```
Examples:
  FinTech
  EdTech
  Healthcare
  Legal services
  Real estate
  Consumer goods
  Developer tools
```

**Stage**
Where the project currently is in its lifecycle. Plugins will adjust their approach accordingly.
```
Options:
  Idea — concept not yet validated
  MVP — being built or just launched, finding product-market fit
  Live — launched, active user base
  Scaling — growing, optimising, expanding
  Mature — established product, incremental improvements
```

---

## Audience

**Target user**
Who the product or project is for. Be as specific as possible.
```
Examples:
  Early-stage startup founders with no technical background
  Enterprise HR managers at companies with 500+ employees
  Freelance designers looking to grow their client base
  Parents of children aged 6–12 interested in online education
  SMB owners in retail running brick-and-mortar stores
```

**Geography**
The primary market or region. Include language of the audience if it differs from your working language.
```
Examples:
  CIS market — Russian-speaking audience
  Western Europe — English and German
  United States — English
  Global — English primary, Spanish secondary
  Local — [City], [Country]
```

---

## Brand & Tone

**Tone of voice**
How the brand communicates. This guides any plugin producing copy, content, or communication.
```
Examples:
  Friendly and approachable — like a knowledgeable colleague, not a corporation
  Professional and precise — no fluff, data-backed
  Bold and opinionated — takes clear positions, challenges the status quo
  Warm and empathetic — users are going through something difficult
  Playful but credible — wit matters, but we never sacrifice trust
```

**Key values**
What the brand or project stands for. What it always communicates, explicitly or implicitly.
```
Examples:
  Transparency, user privacy, simplicity
  Speed, reliability, developer-first
  Inclusivity, accessibility, affordability
  Craftsmanship, attention to detail, longevity
```

**What to avoid**
What the brand must never do, say, or look like.
```
Examples:
  No corporate jargon or buzzwords
  Never make promises we can't back with data
  Avoid anything that feels aggressive or salesy
  Do not use dark patterns or manipulative UX
  Never position against a specific competitor by name
```

---

## Technical Context

**Stack / tools**
Technologies, platforms, or tools that are part of this project. Relevant for development, design system, or integration tasks.
```
Examples:
  Next.js, PostgreSQL, Vercel, GitHub
  Webflow, Airtable, Zapier
  React Native, Firebase, Expo
  Figma, Storybook, Chromatic
  WordPress, WooCommerce
```

**Integrations**
External systems or services the project connects to.
```
Examples:
  Stripe for payments
  HubSpot CRM
  Intercom for support
  Segment + Amplitude for analytics
  SendGrid for transactional email
```

---

## Constraints

**Deadlines**
Any fixed dates or time pressure relevant to current or upcoming work.
```
Examples:
  Launch target: Q3 2025
  Investor demo in 3 weeks
  No fixed deadline — working iteratively
```

**Budget tier**
General sense of resource constraints. Helps plugins calibrate recommendations.
```
Examples:
  Bootstrapped — cost-sensitive, prefer free or low-cost tools
  Seed-funded — selective spend, ROI-focused
  Series A+ — budget available for the right solutions
  Enterprise — procurement process, vendor approval required
```

**Hard limits**
Things that cannot be changed, moved, or overridden regardless of recommendations.
```
Examples:
  Must remain compatible with existing legacy system X
  Brand guidelines are locked — no changes to logo, colours, or typeface
  All data must remain on-premise — no third-party cloud storage
  Legal review required before any external-facing copy is published
  Must support accessibility standard WCAG 2.1 AA
```