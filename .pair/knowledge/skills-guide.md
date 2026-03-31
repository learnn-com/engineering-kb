# Agent Skills Guide

## Overview

Agent Skills are structured, composable instructions that AI coding agents follow to perform development tasks. They follow the [Agent Skills](https://agentskills.io) open standard, supported by Claude Code, Cursor, VS Code Copilot, and OpenAI Codex.

Skills provide idempotency, composability, and graceful degradation.

## Quick Start

Run `/next` at the start of every session. It reads project adoption files and PM tool state, then recommends the most relevant skill to invoke.

## Skill Types

| Type | Count | Purpose |
|------|-------|---------|
| **Process** | 9 | Lifecycle phases — orchestrate capability skills |
| **Capability** | 19 | Atomic units — perform a single focused operation |
| **Navigator** | 1 | Recommend the next most relevant skill |

Process skills compose capability skills. Capability skills are independently invocable. Total: 29 (9 process + 19 capability + 1 navigator).

## Full Catalog

### Process Skills (9)

| Skill | How-To | Phase | Description |
|-------|--------|-------|-------------|
| `/process-specify-prd` | 01 | Induction | Create/update PRD |
| `/process-bootstrap` | 02 | Induction | Full project setup |
| `/process-plan-initiatives` | 03 | Strategic | Create and prioritize initiatives |
| `/process-plan-epics` | 06 | Strategic | Break initiatives into epics |
| `/process-plan-stories` | 07 | Iteration | Break epics into user stories |
| `/process-refine-story` | 08 | Iteration | Refine stories with AC + technical analysis |
| `/process-plan-tasks` | 09 | Iteration | Break stories into tasks |
| `/process-implement` | 10 | Execution | Implement tasks with TDD |
| `/process-review` | 11 | Review | Code review with merge flow |

### Capability Skills (19)

#### Assessment Skills (8)

| Skill | Scope |
|-------|-------|
| `/capability-assess-stack` | Tech stack evaluation + dependency validation |
| `/capability-assess-architecture` | Architecture pattern selection |
| `/capability-assess-methodology` | Development methodology selection |
| `/capability-assess-pm` | PM tool selection |
| `/capability-assess-testing` | Testing strategy evaluation |
| `/capability-assess-infrastructure` | Infrastructure strategy evaluation |
| `/capability-assess-observability` | Observability strategy evaluation |
| `/capability-assess-ai` | AI development tools evaluation |

#### Verification Skills (4)

| Skill | Scope |
|-------|-------|
| `/capability-verify-quality` | Quality gate checking |
| `/capability-verify-done` | Definition of Done checking |
| `/capability-verify-adoption` | Adoption compliance checking |
| `/capability-assess-debt` | Technical debt detection + prioritization |

#### Operational Skills (5)

| Skill | Scope |
|-------|-------|
| `/capability-record-decision` | ADR/ADL creation + adoption update |
| `/capability-write-issue` | PM tool issue creation/update |
| `/capability-estimate` | Story estimation |
| `/capability-setup-gates` | CI/CD quality gate configuration |
| `/capability-setup-pm` | PM tool configuration |

#### Testing Skills (2)

| Skill | Scope |
|-------|-------|
| `/capability-design-manual-tests` | Manual test suite generation from project analysis |
| `/capability-execute-manual-tests` | Manual test suite execution + report generation |

#### Code Quality Skills (2)

| Skill | Scope |
|-------|-------|
| `/capability-assess-code-quality` | Code quality metrics assessment |
| `/capability-manage-flags` | Feature flag lifecycle management |

## Directory Structure

```text
.cursor/skills/
├── next/
├── process-*/
├── capability-*/
└── agent-browser/
    └── SKILL.md
```

Each skill directory contains a `SKILL.md` file with YAML frontmatter (`name` + `description`) and a structured algorithm using the **check → skip → act → verify** pattern.

## Composition Pattern

Process skills compose capability skills with optional graceful degradation:

```text
/process-implement
├── /capability-verify-quality       (required)
├── /capability-record-decision      (required)
├── /capability-assess-stack         (optional — warns if missing)
└── /capability-verify-adoption      (optional — warns if missing)
```

Optional skills degrade gracefully: if not installed, the process skill warns and continues without blocking.

## How Skills Relate to How-To Guides

- **How-to guides** = workflow orchestrators (the "what" and "when")
- **Skills** = operational detail (the "how")
- No duplication: skills contain the algorithm, how-to guides describe the workflow context

When skills are installed, invoke them directly. When not installed, follow the how-to guide manually.

## Adoption Files

Skills read from and write to adoption files in `.pair/adoption/`:

| Area | Adoption File | Skills That Read | Skills That Write |
|------|--------------|------------------|-------------------|
| Tech stack | `tech/tech-stack.md` | `/capability-verify-adoption`, `/process-review` | `/capability-assess-stack`, `/process-bootstrap` |
| Architecture | `tech/architecture.md` | `/capability-verify-adoption`, `/process-review` | `/capability-assess-architecture` |
| Way of working | `tech/way-of-working.md` | `/process-implement`, `/process-review`, `/capability-estimate` | `/capability-assess-methodology`, `/capability-setup-pm` |
| Decisions (ADR) | `tech/adr/*.md` | `/capability-verify-adoption`, `/process-review` | `/capability-record-decision` |
| Decisions (ADL) | `decision-log/*.md` | `/capability-verify-adoption` | `/capability-record-decision` |

## Navigation

- **Start here**: Run `/next` to determine what to do
- **Process flow**: `/process-specify-prd` → `/process-bootstrap` → `/process-plan-initiatives` → ... → `/process-implement` → `/process-review`
- **Independent capability**: Any capability skill can be invoked directly (e.g., `/capability-estimate`, `/capability-assess-debt`)
