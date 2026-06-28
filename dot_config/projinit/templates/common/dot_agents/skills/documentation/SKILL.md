---
name: documentation
description: Write and review documentation and comments in a concise, idiomatic Go style.
---

# Documentation

Assume well-written code should be self-explanatory whenever practical.

## Philosophy

- Comments should explain **why**, not **what**.
- Prefer improving names over adding comments.
- Comments should add information the code cannot express.
- Keep documentation concise and maintainable.

## Comments

- Do not comment obvious code.
- Remove comments that merely restate the implementation.
- Explain assumptions, invariants, tradeoffs, and non-obvious behavior.
- Document surprising behavior or important implementation details.
- Avoid redundant or outdated comments.

Good:

```go
// Retry because SQLite may temporarily return SQLITE_BUSY.
```

Bad:

```go
// Increment i.
i++
```

## Go Documentation

- Public packages should have package documentation.
- Exported types, functions, methods, and constants should have Go-style documentation comments.
- Describe purpose, important behavior, side effects, and limitations.
- Do not simply repeat the identifier's name.

## Examples

Prefer examples over lengthy explanations when they improve understanding.

## Goal

Documentation should help a future developer understand the intent of the code, not narrate its implementation.
