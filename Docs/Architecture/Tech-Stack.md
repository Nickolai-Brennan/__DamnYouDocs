# Tech Stack – DamnYouDocs WebApp

This document defines the **official technology stack** for the OmniDocs WebApp.
It serves as the single source of truth for tooling, runtimes, and platform choices.

---

## 🧱 High-Level Stack Overview

| Layer | Technology | Purpose |
|------|-----------|---------|
| Frontend | React + Vite + TypeScript | UI, document editor, previews |
| Data Fetching | GraphQL + TanStack Query | Typed, cached API access |
| Backend | Node.js + Fastify | API & business logic |
| API Layer | Apollo Server (GraphQL) | Schema, resolvers, validation |
| Database | PostgreSQL | Documents, templates, versioning |
| Auth | JWT + RBAC | Authentication & authorization |
| Exports | Markdown / PDF / JSON-YAML | Multi-format document output |
| Infra | Docker Compose | Local & prod parity |

---

## 🖥️ Frontend Stack

**Directory:** `/frontend`

### Core Technologies

- **React** – Component-based UI framework
- **Vite** – Fast dev server and build tool
- **TypeScript** – Static typing and safety
- **TanStack Query** – Server-state management
- **Apollo Client** – GraphQL client
- **Tailwind CSS** – Utility-first styling

### Editor & Validation

- **Monaco Editor** or **MDX Editor** – Markdown-first document editor
- **Zod** – Schema-based form and input validation

---

## 🔌 Backend / API Stack

**Directory:** `/backend`

### Core Technologies

- **Node.js (v20+)** – Runtime
- **Fastify** – High-performance HTTP framework
- **Apollo Server** – GraphQL API engine
- **GraphQL** – Strongly typed API contract
- **Zod** – Runtime validation
- **JWT** – Stateless authentication

### Document & Export Services

- **Unified / Remark** – Markdown parsing & transforms
- **Playwright** or **Puppeteer** – Server-side PDF rendering
- **js-yaml** – YAML serialization for code exports

---

## 🗄️ Database Stack

**Directory:** `/database`

### Core Technologies

- **PostgreSQL (v15+)** – Primary relational database

### ORM / Query Layer (choose one)

- **Prisma** – Strong DX, schema-driven, migrations
- **Drizzle** – SQL-first, lightweight, type-safe
- **Knex** – Flexible query builder

### Data Responsibilities

- Users & organizations
- Templates & template versions
- Documents & document versions
- Exports & audit logs

---

## 📦 Export Formats

OmniDocs supports three first-class export targets:

### 1. Markdown (`.md`)
- Frontmatter support
- Stable section IDs
- Git-friendly diffs

### 2. PDF (`.pdf`)
- Server-rendered
- Title page and table of contents
- Print-ready layout

### 3. Code-Ready Export
- JSON or YAML
- Deterministic structure
- Repository-friendly folder layout

---

## 🐳 Infrastructure & DevOps

### Local Development

- **Docker Compose** – Database & services
- **.env files** – Environment configuration
- **npm / pnpm** – Package management

### Production Considerations

- Stateless backend services
- Horizontal scalability
- Versioned DB migrations
- Deterministic exports

---

## ⏭️ Next Docs to Create

- Template JSON Schema
- GraphQL API Schema
- Database Schema & ERDs
- Export Pipeline Architecture
