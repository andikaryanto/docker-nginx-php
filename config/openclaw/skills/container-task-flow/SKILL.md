---
name: container-task-flow
description: Use when the user (usually over Telegram) asks to create a task, run a task, or do work inside one of the project containers. Drives a guided flow (choose container -> choose project -> collect requirements -> propose plan -> confirm -> create + run a task through that project's .ai/ pipeline).
metadata: { "openclaw": { "emoji": "🛠️", "requires": { "bins": ["docker"] } } }
---

# Container Task Flow

Use this whenever the user says something like "create task", "new task", "run a task", or otherwise asks you to do work inside one of the project containers below. Follow the steps in order — do not skip ahead or free-form chat through this.

## Containers

| Container | Project root |
| --- | --- |
| `docker-php` | `/var/www/` |
| `docker-nodejs` | `/projects/` |

Only ever target these two containers by name. Never touch anything outside the chosen project's own directory inside the chosen container.

## Step 1 — Choose container

Send a message asking which container, with buttons:

```json
{"blocks":[{"type":"buttons","buttons":[{"label":"docker-php","value":"container:docker-php"},{"label":"docker-nodejs","value":"container:docker-nodejs"}]}]}
```

A button click arrives back to you as a normal user message of the form `callback_data: container:<name>`. Parse `<name>` and remember it as the target container and its project root. Treat any `callback_data: ...` message as structured input for this flow, not conversation.

## Step 2 — Choose project, and check it's actually wired up

List real projects with `docker exec <container> ls -1 <project-root>`. Send them back as buttons (value `project:<name>`), and tell the user they can type a name instead.

- If the reply is `callback_data: project:<name>`, accept it.
- If the user typed free text, check it exists in the list you fetched (or `docker exec <container> test -d <project-root>/<typed-name>`). If it doesn't exist, reply that the project was not found and ask again — do not proceed.

**A project only supports this flow if BOTH of these exist** (check with `docker exec <container> test -d <project-root>/<project>/.ai/tasks` and `docker exec <container> test -d <project-root>/<project>/.claude/commands/backend`):

- `<project-root>/<project>/.ai/tasks/`
- `<project-root>/<project>/.claude/commands/backend/`

If either is missing, tell the user plainly that this project has no task automation set up yet, and stop the flow there — do not try to create files, bootstrap scaffolding, or run anything for it.

If both exist, remember the resolved project path `<project-root>/<project>` and continue.

## Step 3 — Requirements

Ask the user, in plain language, what they want done in that project. Wait for one free-text reply. Treat each distinct instruction/sentence they give as one requirement item.

## Step 4 — Build the task and confirm

Figure out the available `command` types for this project by listing `.claude/commands/backend/*.yml` (`docker exec <container> ls -1 <project-root>/<project>/.claude/commands/backend`). Based on the requirements, pick the single best-fitting command (e.g. `new-feature` for something new, `feature-enhancement` for changing/extending existing behavior). If genuinely unclear, default to `feature-enhancement`.

Get a real timestamp for the task id — do not guess one:

```bash
docker exec <container> date -u +%Y%m%d%H%M%S
```

Build a short kebab-case slug from the title (2-5 words), and combine as `<id>` = `<timestamp>-<slug>`.

Compose the task JSON (this exact shape — extra/missing fields will break the pipeline):

```json
{
  "id": "<id>",
  "title": "<short title>",
  "description": "<one paragraph summary of what's being asked>",
  "command": "<chosen command>",
  "status": "ready-to-develop",
  "project": "<project>",
  "assignee": "developer-agent",
  "created_at": "<UTC ISO8601 now>",
  "updated_at": "<UTC ISO8601 now>",
  "requirements": [{"message": "<requirement 1>"}, {"message": "<requirement 2>"}],
  "comments": []
}
```

Send the user a short plan: the container, project, chosen command, and the requirements list as you understood them — then confirm/cancel buttons:

```json
{"blocks":[{"type":"buttons","buttons":[{"label":"Confirm","value":"confirm:run"},{"label":"Cancel","value":"confirm:cancel"}]}]}
```

Wait for `callback_data: confirm:run` or `callback_data: confirm:cancel`. Never write the task file or run anything before an explicit `confirm:run`. On `confirm:cancel`, stop and tell the user the task was cancelled.

## Step 5 — Create and launch the task

Only after confirmation:

1. Write the task JSON to a local file (e.g. under your own workspace) exactly as composed above.
2. Copy it into place: `docker cp <local-file> <container>:<project-root>/<project>/.ai/tasks/<id>.json`
3. Launch the pipeline **detached** (it can run for several minutes — do not block waiting on it):
   ```bash
   docker exec -d -w <project-root>/<project> <container> sh -c "python3 .ai/task_and_push.py <id> > .ai/tasks/<id>.log 2>&1"
   ```
4. Immediately tell the user the task `<id>` was created and started in the background, and that they can ask you to check its status any time.

## Step 6 — Checking status later

When asked to check a task (by id, or "the last task"), inspect it rather than guessing:

```bash
docker exec <container> cat <project-root>/<project>/.ai/tasks/<id>.json
docker exec <container> tail -n 60 <project-root>/<project>/.ai/tasks/<id>.log
```

Report the JSON `status` field plainly. If it's `human-review`, explain the pipeline paused for a decision and that running `python3 .ai/resolve_task.py <id> approve` or `... revise "<message>"` (inside the container, in the project dir) resolves it — offer to run it if the user tells you which.

## Rules

- Never target a container other than `docker-php` or `docker-nodejs`.
- Never skip the Step 2 scaffolding check or the Step 4 confirmation.
- Never treat a `callback_data: ...` message as anything other than the expected step's structured input.
- If any `docker exec`/`docker cp` command fails, report the real error instead of retrying blindly or guessing what happened.
