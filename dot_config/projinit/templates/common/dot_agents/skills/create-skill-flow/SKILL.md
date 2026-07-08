---
name: create-skill-flow
description: Use this skill when creating, renaming, or updating shared project skills for projinit-managed .agents templates, including choosing a skill name, running projinit new skill, editing SKILL.md, updating the skills README, validating the skill, and syncing the chezmoi-managed template source into projects.
---

# Create Skill Flow

Use this workflow to add reusable agent behavior to the shared `projinit` template source. A skill belongs here when it describes how an agent should behave for a focused kind of work.

## Source Of Truth

`projinit` prefers the external template source:

```text
~/.config/projinit/templates/common/
```

or this path when `XDG_CONFIG_HOME` is set:

```text
$XDG_CONFIG_HOME/projinit/templates/common/
```

If the external source does not exist, `projinit` falls back to embedded templates from:

```text
cmd/projinit/templates/common/
```

In this setup, chezmoi tracks the external `.agents` template source. Use `projinit source` before changing templates when the active source is uncertain.

## Create A Skill

Run:

```bash
projinit new skill <name>
```

This creates:

```text
~/.config/projinit/templates/common/.agents/skills/<name>/SKILL.md
```

`projinit new` does not overwrite existing files.

Use lowercase hyphenated names. Prefer names that describe the behavior or workflow, such as `capture-context` or `create-skill-flow`.

## Write The Skill

Keep `SKILL.md` focused:

- Include only `name` and `description` in YAML frontmatter.
- Put trigger conditions in `description`; Codex sees that before loading the body.
- Write concise body instructions for how to perform the work.
- Avoid duplicating broad `AGENTS.md` rules.
- Do not add editor-specific details unless the skill is explicitly about that editor.
- Add bundled resources only when they directly support the skill.

Use a skill for behavior. Use `.agents/context`, `.agents/templates`, or `.agents/checklists` when the content is background facts, output structure, or a repeatable procedure instead.

## Update The Index

After adding or renaming a skill, update:

```text
~/.config/projinit/templates/common/.agents/skills/README.md
```

Add one short line that describes when the skill applies. Do not duplicate the full skill body.

## Validate And Sync

Validate the source skill:

```bash
python3 /home/mskramst/.codex/skills/.system/skill-creator/scripts/quick_validate.py ~/.config/projinit/templates/common/.agents/skills/<name>
```

Copy the active template source into a project:

```bash
projinit .
```

Check the result:

```bash
projinit doctor .
```

The new skill should report `OK   .agents/skills/<name>/SKILL.md current`.

## Rename Or Remove

When renaming a skill:

- Create the new skill with `projinit new skill <new-name>`.
- Move the skill content to the new path and update the frontmatter `name`.
- Update `.agents/skills/README.md`.
- Remove the old skill from the template source so new projects do not receive both.
- Run `projinit .` and `projinit doctor .` in a project to verify the new name.

Let chezmoi track the external template changes after reviewing the diff.
