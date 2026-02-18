-- =========================
-- 0) Extensions (optional)
-- =========================
CREATE EXTENSION IF NOT EXISTS pgcrypto; -- gen_random_uuid()

-- =========================
-- 1) Templates (container)
-- =========================
CREATE TABLE IF NOT EXISTS templates (
  template_id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug                 TEXT UNIQUE NOT NULL,         -- e.g. "readme-ai"
  template_name         TEXT NOT NULL,                -- e.g. "README (AI Auto-Fill Optimized)"
  category              TEXT NOT NULL,                -- e.g. "overview_orientation"
  doc_type              TEXT NOT NULL,                -- e.g. "README.md"
  output_format         TEXT NOT NULL DEFAULT 'markdown',
  is_public             BOOLEAN NOT NULL DEFAULT TRUE,
  is_archived           BOOLEAN NOT NULL DEFAULT FALSE,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- =========================
-- 2) Template Versions (immutable)
-- =========================
CREATE TABLE IF NOT EXISTS template_versions (
  template_version_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id           UUID NOT NULL REFERENCES templates(template_id) ON DELETE CASCADE,

  version               TEXT NOT NULL,                -- semver-ish: "1.0.0"
  status                TEXT NOT NULL DEFAULT 'draft',-- draft|published|deprecated
  change_notes          TEXT,

  modes                 JSONB NOT NULL DEFAULT '["lean","standard","advanced"]'::jsonb,
  rules                 JSONB NOT NULL DEFAULT '[]'::jsonb,  -- array of strings

  markdown_template      TEXT NOT NULL,               -- the actual markdown template body
  metadata              JSONB NOT NULL DEFAULT '{}'::jsonb,   -- extra flags

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  published_at          TIMESTAMPTZ,

  UNIQUE (template_id, version)
);

CREATE INDEX IF NOT EXISTS idx_template_versions_template_id
  ON template_versions(template_id);

-- =========================
-- 3) Template Sections (per version)
-- =========================
CREATE TABLE IF NOT EXISTS template_sections (
  section_id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_version_id   UUID NOT NULL REFERENCES template_versions(template_version_id) ON DELETE CASCADE,

  section_key           TEXT NOT NULL,                -- e.g. "overview"
  title                 TEXT NOT NULL,                -- e.g. "Overview"
  sort_order            INT NOT NULL DEFAULT 0,

  required              BOOLEAN NOT NULL DEFAULT TRUE,
  mode_min              TEXT NOT NULL DEFAULT 'standard', -- lean|standard|advanced

  prompt_hint           TEXT,                         -- optional guidance snippet
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (template_version_id, section_key)
);

CREATE INDEX IF NOT EXISTS idx_template_sections_version_id
  ON template_sections(template_version_id);

-- =========================
-- 4) Template Variables (per version)
-- =========================
CREATE TABLE IF NOT EXISTS template_variables (
  variable_id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_version_id   UUID NOT NULL REFERENCES template_versions(template_version_id) ON DELETE CASCADE,

  var_key               TEXT NOT NULL,                -- e.g. "project_name"
  label                 TEXT NOT NULL,
  var_type              TEXT NOT NULL,                -- string|enum|string_array|multiline_string|number|boolean|json
  required              BOOLEAN NOT NULL DEFAULT FALSE,

  options               JSONB NOT NULL DEFAULT '[]'::jsonb,  -- for enums
  constraints           JSONB NOT NULL DEFAULT '{}'::jsonb,  -- min/max, regex, minItems, etc.
  example               JSONB,                                 -- store example as json

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (template_version_id, var_key)
);

CREATE INDEX IF NOT EXISTS idx_template_variables_version_id
  ON template_variables(template_version_id);

-- =========================
-- 5) Prompt Sets (container)
-- =========================
CREATE TABLE IF NOT EXISTS template_prompts (
  prompt_id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id           UUID NOT NULL REFERENCES templates(template_id) ON DELETE CASCADE,

  name                  TEXT NOT NULL,                -- e.g. "README Generator (Section-Aware)"
  generation_strategy   TEXT NOT NULL DEFAULT 'single_pass', -- single_pass|section_by_section
  is_archived           BOOLEAN NOT NULL DEFAULT FALSE,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_template_prompts_template_id
  ON template_prompts(template_id);

-- =========================
-- 6) Prompt Versions (immutable)
-- =========================
CREATE TABLE IF NOT EXISTS template_prompt_versions (
  prompt_version_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prompt_id             UUID NOT NULL REFERENCES template_prompts(prompt_id) ON DELETE CASCADE,

  version               TEXT NOT NULL,
  status                TEXT NOT NULL DEFAULT 'draft', -- draft|published|deprecated
  global_rules          JSONB NOT NULL DEFAULT '[]'::jsonb,
  system_prompt         TEXT NOT NULL,
  section_prompts       JSONB NOT NULL DEFAULT '[]'::jsonb, -- [{id,title,prompt}, ...]

  input_contract        JSONB NOT NULL DEFAULT '{}'::jsonb,
  output_contract       JSONB NOT NULL DEFAULT '{}'::jsonb,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  published_at          TIMESTAMPTZ,

  UNIQUE (prompt_id, version)
);

CREATE INDEX IF NOT EXISTS idx_prompt_versions_prompt_id
  ON template_prompt_versions(prompt_id);

-- =========================
-- 7) Input Schema Versions (immutable)
-- =========================
CREATE TABLE IF NOT EXISTS template_input_schemas (
  schema_id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id           UUID NOT NULL REFERENCES templates(template_id) ON DELETE CASCADE,

  name                  TEXT NOT NULL,                -- e.g. "README Input Schema"
  is_archived           BOOLEAN NOT NULL DEFAULT FALSE,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_template_input_schemas_template_id
  ON template_input_schemas(template_id);

CREATE TABLE IF NOT EXISTS template_input_schema_versions (
  schema_version_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  schema_id             UUID NOT NULL REFERENCES template_input_schemas(schema_id) ON DELETE CASCADE,

  version               TEXT NOT NULL,
  status                TEXT NOT NULL DEFAULT 'draft', -- draft|published|deprecated
  json_schema           JSONB NOT NULL,                -- store the JSON Schema

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  published_at          TIMESTAMPTZ,

  UNIQUE (schema_id, version)
);

CREATE INDEX IF NOT EXISTS idx_schema_versions_schema_id
  ON template_input_schema_versions(schema_id);

-- =========================
-- 8) Documents (instance created from template_version)
-- =========================
CREATE TABLE IF NOT EXISTS documents (
  document_id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id           UUID REFERENCES templates(template_id),
  template_version_id   UUID REFERENCES template_versions(template_version_id),

  title                 TEXT NOT NULL,
  status                TEXT NOT NULL DEFAULT 'draft', -- draft|published|archived
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_documents_template_version_id
  ON documents(template_version_id);

-- =========================
-- 9) Document Versions (immutable snapshots)
-- =========================
CREATE TABLE IF NOT EXISTS document_versions (
  document_version_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  document_id           UUID NOT NULL REFERENCES documents(document_id) ON DELETE CASCADE,

  version_num           INT NOT NULL,                 -- 1,2,3...
  input_payload         JSONB NOT NULL DEFAULT '{}'::jsonb, -- values for variables
  rendered_markdown     TEXT NOT NULL,                -- final generated markdown
  notes                TEXT,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (document_id, version_num)
);

CREATE INDEX IF NOT EXISTS idx_document_versions_document_id
  ON document_versions(document_id);

-- =========================
-- 10) Exports
-- =========================
CREATE TABLE IF NOT EXISTS exports (
  export_id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  document_version_id   UUID NOT NULL REFERENCES document_versions(document_version_id) ON DELETE CASCADE,

  export_type           TEXT NOT NULL,                -- markdown|pdf|zip|json|yaml
  status                TEXT NOT NULL DEFAULT 'queued', -- queued|success|failed
  file_path             TEXT,                         -- or storage key
  meta                  JSONB NOT NULL DEFAULT '{}'::jsonb,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at          TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_exports_doc_version_id
  ON exports(document_version_id);
