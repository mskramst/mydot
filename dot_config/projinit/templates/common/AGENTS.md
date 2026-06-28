# AGENTS.md

## Project Overview

This project is written in Go and uses SQLite for storage.

## Philosophy

Favor simple, understandable solutions in the spirit of the Unix philosophy.
When several approaches are correct, choose the one that is easiest to understand, maintain, and debug.
Prefer composition over unnecessary abstraction.
Prefer removing code over adding code when both are equally correct.
Minimize dependencies.
Use the standard library whenever practical.
Assume long-term maintainability is more important than cleverness.

## General Rules

- Make the smallest correct change.
- Never rewrite unrelated code.
- Preserve backward compatibility unless the requested change requires otherwise.
- Explain non-obvious design decisions.
- Do not introduce frameworks unless explicitly requested.
- Avoid unnecessary configuration.

## Development Environment

- Assume a traditional Linux server deployment.
- Do not suggest Docker, Kubernetes, or PaaS unless explicitly requested.
- Use Podman if containerization is necessary.
- Use SQLite for local development and automated tests whenever practical.

## Go

- Favor simple, idiomatic Go.
- Avoid unnecessary interfaces.
- Prefer small, focused functions.

## Error Handling

- Check every returned error.
- Do not ignore errors with `_` unless there is a clear written reason.
- Wrap errors with useful context using `fmt.Errorf("...: %w", err)`.
- Prefer returning errors over calling `panic` or `log.Fatal`.
- When writing files, check errors from `Close()` when data integrity matters.

## Testing

- Consider whether new or modified code should include tests.
- Prefer table-driven tests where appropriate.
- Keep tests simple, deterministic, and readable.

## Git Safety

- Before large edits, suggest creating a checkpoint commit or working branch.
- Do not commit changes unless explicitly requested.
- Do not rewrite Git history unless explicitly requested.
