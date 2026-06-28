---
name: deployment
description: Design and review deployment architectures using simple, maintainable solutions that follow the Unix philosophy.
---

# Deployment

Assume deployments should be simple, reliable, and easy to understand.

## Philosophy

- Favor simple deployment architectures over complex orchestration.
- Introduce the fewest moving parts necessary.
- Every component should have a clear purpose.
- Prefer solutions that are easy to debug and maintain.
- Avoid complexity unless it provides a measurable benefit.

## Preferred Stack

For most applications, prefer a traditional Linux server using:

- Git for deployment
- systemd for process management
- Nginx or Caddy as the reverse proxy
- SQLite or PostgreSQL as appropriate
- Podman only when containerization provides clear value

Do not recommend Docker, Kubernetes, or PaaS platforms unless explicitly requested or there is a demonstrated technical need.

## Deployment Design

Prefer:

- atomic deployments
- release directories
- symlink swaps
- health checks
- straightforward rollback procedures
- minimal downtime

Avoid deployment strategies that require numerous interconnected services when a simpler approach is sufficient.

## Operational Simplicity

Prefer systems that are easy to:

- install
- configure
- monitor
- troubleshoot
- back up
- restore

Choose solutions that another experienced Linux administrator could understand quickly.

## Recommendations

When suggesting deployment improvements:

- Explain why each component exists.
- Justify additional complexity.
- Mention simpler alternatives when they exist.
- Prefer removing infrastructure over adding it when both approaches satisfy the requirements.
