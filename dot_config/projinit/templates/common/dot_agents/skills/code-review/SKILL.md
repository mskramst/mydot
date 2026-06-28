---
name: code-review
description: Review Go code for correctness, simplicity, maintainability, security, and idiomatic style.
---

# Code Review

Review code with the project's philosophy in mind: simple, explicit, maintainable Go in the spirit of the Unix philosophy.

## Review Order

Review in this order:

1. Correctness
2. Error handling
3. Security
4. Data integrity
5. Simplicity
6. Maintainability
7. Performance
8. Style

Do not lead with style comments if there are correctness or safety issues.

## Review Principles

- Prefer the smallest correct change.
- Do not suggest unrelated rewrites.
- Prefer removing code over adding code when both are equally correct.
- Avoid unnecessary abstractions, interfaces, frameworks, dependencies, and configuration.
- Favor clear names and simple control flow.
- Separate real bugs from optional improvements.

## Go-Specific Checks

- Are all returned errors checked?
- Are errors wrapped with useful context?
- Are `Close()` errors checked when writes or data integrity matter?
- Are goroutines, channels, mutexes, and shared state used safely?
- Are interfaces introduced only where they simplify the design?
- Are functions small and focused?
- Is the code idiomatic Go without being clever?

## Security Checks

- Is user input validated?
- Are SQL queries parameterized?
- Are file paths protected from traversal problems?
- Are secrets kept out of code, logs, URLs, and commits?
- Are authentication and authorization checks server-side?
- Are permissions as narrow as practical?

## SQLite Checks

- Are transactions used when multiple writes must succeed or fail together?
- Are migrations safe and understandable?
- Are indexes justified by real queries?
- Is database behavior tested where practical?

## Testing Checks

- Should this change add or update tests?
- Are tests deterministic and readable?
- Do tests check behavior rather than implementation details?
- Are table-driven tests useful here?

## Review Output

When giving a review:

- Start with the most important issue.
- Explain why it matters.
- Suggest the simplest safe fix.
- Distinguish required fixes from optional improvements.
- Avoid nitpicks unless the code is otherwise solid.
- Do not overwhelm the review with low-value comments.

## Goal

A good review should improve correctness, safety, and clarity without making the code more complicated.
