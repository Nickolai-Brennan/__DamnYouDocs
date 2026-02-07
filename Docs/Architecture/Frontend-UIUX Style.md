# Frontend UI/UX Style Sheet – OmniDocs

This document defines the **UI/UX system** for the OmniDocs frontend: layout rules, components, typography, colors, spacing, states, accessibility, and interaction patterns.

---

## 1) Product UI Goals

### Primary Outcomes
- Users can **find templates fast**
- Users can **generate a high-quality document with low effort**
- Users can **export instantly** (Markdown / PDF / Code-ready)
- Users can **version + duplicate** without friction

### UX Principles
- **Clarity > Cleverness** (docs are functional tools)
- **Speed of navigation** (search + filters everywhere)
- **Doc-first interface** (editor is the core)
- **Minimal chrome** (reduce distractions)
- **Safe editing** (autosave + version history)

---

## 2) Global Layout System

### App Shell
- **Top Bar:** global search, create button, user menu
- **Left Sidebar:** Library nav + Categories + Filters
- **Main Panel:** content (grid list OR editor)
- **Right Drawer (optional):** template guidance, export, section notes

### Page Grid Rules
- Max content width: **1200–1400px**
- Editor view can expand to **full width**
- Use **2-column** layout for most pages:
  - Left: navigation + filters
  - Right: content
- In Editor mode:
  - Left: section tree
  - Center: editor
  - Right: preview/export panel (collapsible)

---

## 3) Typography System

### Font Families
- Headings: `Inter` (or `Barlow Condensed` for brand)  
- Body: `Inter`

### Type Scale (suggested)
- H1: 32–36px / 700
- H2: 24–28px / 700
- H3: 18–20px / 600
- Body: 14–16px / 400
- Small: 12–13px / 400
- Mono: `ui-monospace` for code blocks

### Content Readability Rules
- Body line-height: **1.55–1.75**
- Paragraph width: **60–90 chars**
- Use lists + tables often; avoid long prose walls

---

## 4) Color & Theme Tokens

> Use tokens (CSS variables) so dark mode is automatic.

### Semantic Tokens
- `--bg`, `--panel`, `--muted`
- `--text`, `--text-muted`
- `--border`
- `--primary`, `--primary-contrast`
- `--success`, `--warning`, `--danger`
- `--focus` (keyboard outline)

### Theme Rules
- Default: **dark-ish neutral** for editor comfort
- Light mode supported
- Never rely on color alone for meaning (icons + labels)

---

## 5) Spacing, Radius, Shadows

### Spacing Scale (Tailwind mental model)
- 4px, 8px, 12px, 16px, 24px, 32px, 48px

### Corners & Elevation
- Default radius: **12px**
- Cards: subtle shadow, no heavy glow
- Hover: slight elevation + border emphasis

---

## 6) Navigation & IA

### Left Sidebar
- Library
- Categories
- Recent Docs
- Favorites
- Templates (Tech / Business / Project / Ops)
- Settings

### Global Search
- Always visible in Top Bar
- Supports:
  - template name
  - tags
  - category
  - doc title
  - full-text (Phase 2)

### Filters (standard)
- Category
- Tags
- Difficulty
- Estimated time
- Favorites
- “Only my org”

---

## 7) Core Pages & UX Specs

## 7.1 Template Library
**Goal:** browse + select a template quickly

UI
- Template grid cards
- Filters left
- Sort: Popular / Recent / A–Z / Time

Template Card Must Show
- Name
- Category
- Tags (up to 3 visible)
- Estimated time
- “Use Template” CTA

---

## 7.2 Template Preview
**Goal:** understand structure before generating

UI
- Overview panel (what it’s for, when to use)
- Section outline preview
- Example snippet
- “Create Document” CTA

---

## 7.3 Document Editor (Core)
**Goal:** create a document with guidance + exports

Editor Layout
- Left: Section Tree (collapsible)
- Center: Markdown editor
- Right: Live Preview + Export Panel (collapsible)

Must-Have UX
- Autosave indicator: `Saving…` → `Saved`
- Version snapshots: “Create Version” button
- Inline guidance per section (toggle)
- Export buttons always visible

---

## 7.4 Version History
**Goal:** confidence + rollback

UI
- Timeline list of versions with:
  - timestamp
  - author
  - label (optional)
- Diff view:
  - “Markdown diff” mode
  - “Section diff” mode (Phase 2)

---

## 7.5 Export Center
**Goal:** one place to download outputs

Export Types
- Markdown
- PDF
- Code-ready bundle (zip)

Export UX
- Show last export status (success/fail)
- Re-export button
- Format-specific options:
  - PDF: include TOC, page size
  - Code: JSON vs YAML, folder naming

---

## 8) Component System

### Global Components
- TopBar
- SidebarNav
- SearchBar
- FilterPanel
- TemplateCard
- DocumentRow
- TagBadge
- EmptyState
- Toast / Snackbar
- Modal / Drawer

### Editor Components
- SectionTree
- MarkdownEditor
- DocPreview
- GuidancePanel
- ExportPanel
- VersionBadge

### Buttons
- Primary: Create / Export
- Secondary: Preview / Duplicate
- Destructive: Delete
- Ghost: Icon-only actions

---

## 9) UI States (Required)

Every page must define:
- Loading state (skeletons preferred)
- Empty state (clear CTA)
- Error state (retry, details)
- Offline-ish state (autosave queue)

---

## 10) Accessibility Rules

- Full keyboard navigation
- Visible focus states
- No “color only” meaning
- ARIA labels for icon buttons
- Editor + preview panels must be reachable and resizable

---

## 11) Motion & Microinteractions

- Use subtle motion only:
  - hover elevation
  - drawer slide
  - toast fade
- Keep animations under **200ms**
- Respect reduced motion settings

---

## 12) Design Baselines (MVP)

MVP must include:
- Template Library (grid + filters + search)
- Template Preview
- Document Editor (markdown + preview + export panel)
- Version History list (no diff required for MVP)
- Export Center (download links)

---

## 13) MVP Acceptance Criteria (Frontend)

- User can create a document from any template in < 60 seconds
- Autosave triggers within 2 seconds of stop typing
- Export produces files via backend call and provides download
- Template Library search returns results in < 150ms (client-side)
- All pages have loading/empty/error states
