# 📋 Project TODO List — Dann You Docs 

**Owner:** Nick  
**Rule:** A task is DONE only when the referenced file or folder exists.  
Empty files are acceptable as stubs.

---

## PHASE 0 — Repository & Foundations

### Root Files
- [ ] `README.md`
- [ ] `MASTER_CONTROL_FILE.md`
- [ ] `.gitignore`
- [ ] `.env.example`
- [ ] `docker-compose.yml`

### Root Folders
- [ ] `/docs/`
- [ ] `/frontend/`
- [ ] `/backend/`
- [ ] `/database/`
- [ ] `/infra/`
- [ ] `/scripts/`

---

## PHASE 1 — Overview & Orientation

- [ ] `/docs/README.md`
- [ ] `/docs/overview/PROJECT_OVERVIEW.md`
- [ ] `/docs/overview/VISION_AND_GOALS.md`
- [ ] `/docs/overview/NON_GOALS.md`
- [ ] `/docs/overview/TERMINOLOGY_GLOSSARY.md`

---

## PHASE 2 — Product & Strategy

- [ ] `/docs/product/PRODUCT_BRIEF.md`
- [ ] `/docs/product/TARGET_AUDIENCE.md`
- [ ] `/docs/product/PROBLEM_STATEMENT.md`
- [ ] `/docs/product/VALUE_PROPOSITION.md`
- [ ] `/docs/product/FEATURE_LIST.md`
- [ ] `/docs/product/ROADMAP.md`
- [ ] `/docs/product/PRICING_AND_MONETIZATION.md`

---

## PHASE 3 — Architecture & System Design

- [ ] `/docs/architecture/SYSTEM_ARCHITECTURE_OVERVIEW.md`
- [ ] `/docs/architecture/FRONTEND_ARCHITECTURE.md`
- [ ] `/docs/architecture/BACKEND_ARCHITECTURE.md`
- [ ] `/docs/architecture/DATABASE_ARCHITECTURE.md`
- [ ] `/docs/architecture/AI_OR_ML_ARCHITECTURE.md`
- [ ] `/docs/architecture/INTEGRATIONS_AND_APIS.md`

---

## PHASE 4 — Frontend (Code Files)

### Config
- [ ] `/frontend/package.json`
- [ ] `/frontend/vite.config.ts`
- [ ] `/frontend/tsconfig.json`
- [ ] `/frontend/index.html`

### Entry
- [ ] `/frontend/src/main.tsx`
- [ ] `/frontend/src/App.tsx`

### Layouts
- [ ] `/frontend/src/layouts/AppShell.tsx`
- [ ] `/frontend/src/layouts/TopBar.tsx`
- [ ] `/frontend/src/layouts/Sidebar.tsx`

### Pages
- [ ] `/frontend/src/pages/Home.tsx`
- [ ] `/frontend/src/pages/Templates.tsx`
- [ ] `/frontend/src/pages/TemplateDetail.tsx`
- [ ] `/frontend/src/pages/Documents.tsx`
- [ ] `/frontend/src/pages/DocumentRead.tsx`
- [ ] `/frontend/src/pages/DocumentEditor.tsx`
- [ ] `/frontend/src/pages/DocumentDetails.tsx`
- [ ] `/frontend/src/pages/Exports.tsx`
- [ ] `/frontend/src/pages/Settings.tsx`

### Components
- [ ] `/frontend/src/components/TemplateTile.tsx`
- [ ] `/frontend/src/components/PackTile.tsx`
- [ ] `/frontend/src/components/SectionTree.tsx`
- [ ] `/frontend/src/components/MarkdownEditor.tsx`
- [ ] `/frontend/src/components/ExportPanel.tsx`

---

## PHASE 5 — Backend & API (Code Files)

### Config
- [ ] `/backend/package.json`
- [ ] `/backend/tsconfig.json`

### Core
- [ ] `/backend/src/server.ts`
- [ ] `/backend/src/app.ts`

### GraphQL
- [ ] `/backend/src/graphql/schema.ts`
- [ ] `/backend/src/graphql/context.ts`
- [ ] `/backend/src/graphql/resolvers/index.ts`
- [ ] `/backend/src/graphql/resolvers/templates.ts`
- [ ] `/backend/src/graphql/resolvers/documents.ts`
- [ ] `/backend/src/graphql/resolvers/exports.ts`

### Services
- [ ] `/backend/src/services/markdown.ts`
- [ ] `/backend/src/services/pdf.ts`
- [ ] `/backend/src/services/codeExport.ts`

### Auth
- [ ] `/backend/src/modules/auth/jwt.ts`
- [ ] `/backend/src/modules/auth/rbac.ts`

---

## PHASE 6 — Database & Data Layer

### Schemas
- [ ] `/database/schema/users.sql`
- [ ] `/database/schema/orgs.sql`
- [ ] `/database/schema/templates.sql`
- [ ] `/database/schema/template_versions.sql`
- [ ] `/database/schema/documents.sql`
- [ ] `/database/schema/document_versions.sql`
- [ ] `/database/schema/exports.sql`
- [ ] `/database/schema/audit_events.sql`

### Migrations
- [ ] `/database/migrations/001_init.sql`
- [ ] `/database/migrations/002_templates.sql`
- [ ] `/database/migrations/003_documents.sql`

### Seeds
- [ ] `/database/seeds/base_templates.sql`

---

## PHASE 7 — DevOps & Environment

- [ ] `/infra/docker/Dockerfile.backend`
- [ ] `/infra/docker/Dockerfile.frontend`
- [ ] `/infra/nginx/nginx.conf`
- [ ] `/scripts/setup-dev.sh`
- [ ] `/scripts/setup-dev.ps1`

---

## PHASE 8 — QA & Testing

### Frontend
- [ ] `/frontend/tests/unit/`
- [ ] `/frontend/tests/e2e/`

### Backend
- [ ] `/backend/tests/unit/`
- [ ] `/backend/tests/integration/`

---

## PHASE 9 — Operations & Launch

- [ ] `/docs/operations/RUNBOOK.md`
- [ ] `/docs/operations/INCIDENT_RESPONSE.md`
- [ ] `/docs/operations/DEPLOYMENT_GUIDE.md`

---

## SYSTEM RULES

- No file → task not done  
- Empty stub files are acceptable  
- No orphan files  
- No undocumented features  
- This file is the execution source of truth
