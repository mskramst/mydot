---
name: capture-context
description: Use this skill when a project should capture or retrieve durable knowledge with STARTANEW tools, especially when saving project notes with note, stable references with ref, reusable snippets with snip, or searching saved context with search and how.
---

# Capture Context

Use STARTANEW as the durable knowledge store for project work. Prefer these tools when information should survive beyond the current chat or current repo.

## Assumptions

- `$STARTANEW` points to the STARTANEW repository.
- The scripts directory is on `PATH`, or tools can be called as `$STARTANEW/scripts/<tool>`.
- The `snip` binary is installed or available from `$STARTANEW/gotools/snip`.

## Tool Boundaries

Use `note` for dated project memory:

- decisions made during a project
- summaries of completed work
- debugging findings
- implementation plans that should remain searchable
- project-specific context that may change over time

Use `ref` for stable reference material:

- reusable guides
- command recipes
- explanations that should not be tied to a single day
- project-independent documentation
- canonical notes that should avoid duplication

Use `snip` for reusable text:

- code snippets and templates saved by stable name
- small reusable shell commands
- non-code clips when the user explicitly wants to capture text through `snip clip`

Use `search` to find saved notes, references, snippets, and broader STARTANEW knowledge.

Use `how` when the user wants an answer and saved STARTANEW context should be checked before falling back to the local LLM.

## Storage Model

Notes are stored as timestamped markdown:

```text
$STARTANEW/void/notes/YYYY/MM/YYYYMMDDHHMMSS.md
```

References are stored as slugged markdown:

```text
$STARTANEW/void/reference/<slug>.md
```

Snippets are stored by stable name:

```text
$STARTANEW/void/snippets/<name>
```

## Project Workflow

At the start of a project, check whether durable context already exists:

```bash
search <topic>
refs
snip search <topic>
```

When the user asks to remember, summarize, document, or preserve project context, create a note:

```bash
note "Project summary or decision title"
```

After the editor opens, write a concise markdown note with:

- what changed
- why it changed
- important commands or paths
- verification performed
- unresolved follow-up items

When creating stable reusable documentation, use `ref`:

```bash
ref "Reference title"
```

Before creating a reference, rely on `ref`'s duplicate check. If it opens an existing reference, update that file instead of creating a duplicate.

When saving reusable code or text snippets:

```bash
printf '%s\n' '<snippet text>' | snip save <category/name>
```

Do not overwrite existing snippets. If a snippet exists, use:

```bash
snip edit <category/name>
snip rm <category/name>
```

## Searching

Use broad repository knowledge search with:

```bash
search <query>
```

Use answer-oriented search with:

```bash
how <question>
```

Use snippet-only search with:

```bash
snip search <query>
snip pick <query>
```

Use note/clip-only search with:

```bash
snip notes --list <query>
snip notes <query>
```

## Agent Rules

- Use `note` when the user asks to document what happened in a project.
- Use `ref` when the content is a reusable guide or stable reference.
- Use `snip save` only for reusable snippets/templates; keep notes out of snippet search.
- Keep snippets and notes separate: snippets are inserted into buffers; notes are opened for reading or editing.
- After creating a note or reference, mention the saved path.
- Do not commit generated notes or snippets unless the user asks.
