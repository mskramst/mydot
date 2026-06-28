---
name: security
description: Review Go web applications and Linux deployments for common security risks, authentication problems, and unsafe assumptions.
---

# Security Review

Review code and deployment changes with a defensive mindset.

## Philosophy

Security should be simple, explicit, and understandable.

Avoid clever security designs.

Prefer well-known, boring, standard approaches over custom mechanisms.

Do not invent custom authentication, session, password storage, or cryptography schemes.

## Review Priorities

Check for:

- broken access control
- authentication mistakes
- SQL injection
- command injection
- path traversal
- unsafe file permissions
- leaked secrets
- insecure cookies
- missing input validation
- unsafe redirects
- missing logging for important security events

## Authentication

- Prefer established authentication libraries or proven patterns.
- Never store plaintext passwords.
- Use strong password hashing.
- Use secure, HttpOnly, SameSite cookies for browser sessions.
- Regenerate sessions after login.
- Do not put secrets or sensitive data in URLs.
- Avoid rolling custom token formats unless there is a clear reason.

## Authorization

- Check authorization on the server for every protected action.
- Deny by default.
- Do not rely on hidden UI elements for security.
- Ensure users can only access their own data unless explicitly allowed.

## SQLite and SQL

- Use parameterized queries.
- Do not build SQL with string concatenation from user input.
- Use transactions when multiple writes must succeed or fail together.
- Validate and constrain user input before database use.

## Files and Paths

- Validate uploaded filenames and paths.
- Prevent path traversal.
- Use safe temporary files.
- Avoid world-writable files and directories.
- Store secrets outside the repository.

## Deployment

- Run services with least privilege.
- Keep systemd units simple and explicit.
- Do not run web services as root unless absolutely necessary.
- Use HTTPS in production.
- Keep logs useful but avoid logging secrets.

## Output Style

When reviewing security:

- Separate real vulnerabilities from hardening suggestions.
- Explain the risk plainly.
- Suggest the simplest safe fix.
- Avoid fear-based language.
