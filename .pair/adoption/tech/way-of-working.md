# Way of Working

- Rapid, iterative development cycles with releases as needed.
- Lightweight code review and testing practices focused on speed and learning.
- Minimal documentation: key decisions and usage documented in markdown files.
- Collaboration and process guidelines follow the standards in `/.pair/tech/knowledge-base/12-collaboration-and-process-guidelines/project-management-framework.md`.
- Azure DevOps is adopted as the primary platform for both **source control** (Azure Repos) and **project management** (Azure Boards). Organization: `https://dev.azure.com/learnn`, Project: `learnn`. See [Azure DevOps Implementation](/.pair/knowledge/guidelines/collaboration/project-management-tool/azure-devops-implementation.md) for usage. Use Azure CLI (`az boards`, `az repos`) for programmatic access to boards, work items, and pull requests.
  - **PBI States**: New → Committed → Approved → Done
  - **Task States**: To Do → In Progress → Done
  - **Story Points = Ore** (1 point = 1 ora, salvati come Remaining Work nel Task)
  - **Task breakdown**: done locally only (e.g. `.pair/stories/[ID]-tasks.md`). Do not update the PBI description or create/update Task work items on Azure. Propose the task list (titles, hours, AC, dependencies) to PM/developer and wait for approval before finalising the local breakdown.
- High risk tolerance: quick rollbacks and fast recovery from errors.
- Team communication is informal and direct, with decisions validated collaboratively.
- **Base branch for feature work:** Feature branches are created from `Development`. Naming: `feature/#<PBI-ID>-<brief-description>` (see [branch template](/.pair/knowledge/guidelines/collaboration/templates/branch-template.md)).
- **Commit History Policy:**: All feature branches must be squashed into a single commit before opening a pull request, unless otherwise specified by the story or epic. See [commit template](/.pair/knowledge/guidelines/collaboration/templates/commit-template.md) for details.
- **PR creation:** Create PR with `az repos pr create` (source/target branch, title, description). Use [PR template](/.pair/knowledge/guidelines/collaboration/templates/pr-template.md) for the description body. Link PBI/work items with `az repos pr work-item add --id <PR_ID> --work-items <PBI_ID> --org https://dev.azure.com/learnn`. See [Azure DevOps Implementation](/.pair/knowledge/guidelines/collaboration/project-management-tool/azure-devops-implementation.md).
- **PR review / diff:** To get a PR diff: have the branch locally (e.g. `az repos pr checkout --id <PR_ID>` or already present), then `git diff origin/Development --name-status` for file list, `git diff origin/Development -- <path>...` for the diff. Lightweight process: local branch + diff, no REST/PAT.

---

## Enabled How-To Guides

Only the following how-to guides are relevant for this project. Agents must not invoke skills or workflows related to disabled how-tos.

| # | File | Skill |
|---|------|-------|
| 05 | `05-how-to-breakdown-user-stories.md` | `/process-plan-stories` |
| 06 | `06-how-to-refine-a-user-story.md` | `/process-refine-story` |
| 07 | `07-how-to-create-tasks.md` | `/process-plan-tasks` |
| 08 | `08-how-to-implement-a-task.md` | `/process-implement` |
| 09 | `09-how-to-code-review.md` | `/process-review` |

**Disabled** (not applicable to this project): `01-how-to-create-PRD.md`, `02-how-to-complete-bootstrap-checklist.md`, `03-how-to-create-and-prioritize-initiatives.md`, `04-how-to-breakdown-epics.md`.

---

All development activities must follow these adopted practices. For process and rationale, see [way-of-working.md](../../knowledge/way-of-working.md).
