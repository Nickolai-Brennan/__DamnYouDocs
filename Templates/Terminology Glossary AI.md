# {{project_name}} — Terminology Glossary

{{#each terms}}

## Term: {{this.term}}

Definition:
{{this.definition}}

Context:
{{this.context}}

Related Terms:
{{#each this.related_terms}}
- {{this}}
{{/each}}

Category:
{{this.category}}

{{/each}}
