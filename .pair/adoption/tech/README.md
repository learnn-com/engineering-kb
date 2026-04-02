# 📋 Adopted Standards & Practices

This directory contains the **adopted standards and practices** for the project. These documents serve as the authoritative source for all technical and process decisions, providing strict context for the AI assistant during vibecoding and development.

## 📁 Document Requirements

All adopted documents must:

- Be written in **English**
- Be **concise**: list only choices and decisions without explanations or rationale
- Reference the [guidelines knowledge base](../../knowledge/guidelines/) for details, explanations, and background information
- Be **self-consistent** with compatible choices across library versions, user device targets, and deployment environments
- Be **strict and prescriptive** with no ambiguity or open interpretation
- Address all relevant points from the [bootstrap-checklist](../../knowledge/assets/bootstrap-checklist.md)

## 📁 Document Categories

### 🏗️ System Design

- **[architecture.md](architecture.md)** – Validated architectural decisions and system boundaries
- **[tech-stack.md](tech-stack.md)** – Technology stack components with exact versions
- **[project-structure.md](project-structure.md)** – Monorepo layout, workspace configuration, and service patterns

### 🚀 Implementation & Operations

- **[infrastructure.md](infrastructure.md)** – Infrastructure and deployment choices
- **[way-of-working.md](way-of-working.md)** – Development practices and team workflows
- **[coding-patterns.md](coding-patterns.md)** – Router to local coding pattern contexts (services, utils-be, sdk, apps)

### 🔒 Security

- **[security.md](security.md)** – Security adoption: cookies, redirects, secrets, WordPress hardening, API auth

### 🎨 User Experience

- **[ux-ui.md](ux-ui.md)** – UX/UI patterns and design system choices

## 📝 Usage Guidelines

These documents are **decision records**, not guidelines:

- Contain only **validated choices** proposed by AI and approved by the team
- Must be **implemented as written** with full compliance required
- Reference the [guidelines knowledge base](../../knowledge/guidelines/) for detailed explanations
- Must reflect the current project state and be kept up to date

## 🔄 Update Process

Standards are updated during specific development phases:

1. **Strategic Preparation**: Architecture and tech-stack updates
2. **Customer-Facing Iterations**: UX/UI and infrastructure updates
3. **Continuous Value Delivery**: Way of working and deployment updates

## 🔗 Related Documentation

### Knowledge Base

Detailed technical guidelines and explanations:

- [01-architectural-guidelines.md](../../knowledge/guidelines/architecture/README.md)
- [02-code-design-guidelines.md](../../knowledge/guidelines/code-design/README.md)
- [03-technical-guidelines.md](../../knowledge/guidelines/technical-standards/README.md)
- [04-infrastructure-guidelines.md](../../knowledge/guidelines/infrastructure/README.md)
- [05-ux-guidelines.md](../../knowledge/guidelines/user-experience/README.md)
- [06-definition-of-done.md](../../knowledge/guidelines/quality-assurance/quality-standards/README.md)
- [07-testing-strategy.md](../../knowledge/guidelines/testing/test-strategy/README.md)
- [08-accessibility-guidelines.md](../../knowledge/guidelines/quality-assurance/accessibility/README.md)
- [09-performance-guidelines.md](../../knowledge/guidelines/quality-assurance/performance/README.md)
- [10-security-guidelines.md](../../knowledge/guidelines/quality-assurance/security/README.md)
- [11-observability-guidelines.md](../../knowledge/guidelines/observability/README.md)
- [project-management-framework.md](../../knowledge/guidelines/collaboration/project-management-tool/README.md)
- [README.md](../../knowledge/guidelines/README.md) – Knowledge Base Overview

### Additional Resources

- **[Bootstrap Checklist](../../knowledge/assets/bootstrap-checklist.md)** – Project Setup & Bootstrap Checklist with all relevant questions the adopted standards must address
- **[ADR](./adr/)** – Architecture Decision Records for significant changes
- **[Way of Working](../../knowledge/way-of-working.md)** – Development process and collaboration patterns
