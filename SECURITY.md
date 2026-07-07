# Security Policy

## Scope

This repository contains a markdown skill definition, documentation, and small
installation/validation scripts. The skill itself executes no code: it is a set
of instructions interpreted by an AI agent. The only executable files are:

- `install.ps1` / `install.sh` — copy the skill directory to a destination.
- `scripts/validate.sh` / `scripts/validate.ps1` — read-only structure checks.

Review them before running, as you should with any script downloaded from the
internet.

## Reporting a vulnerability

If you find a security issue — for example a way the skill's instructions could
lead an agent to unsafe behavior, or a flaw in the scripts — please use
GitHub's private vulnerability reporting (repository **Security** tab →
**Report a vulnerability**) instead of opening a public issue.

You can expect an acknowledgement within a few days. Please do not disclose the
issue publicly until it has been addressed.

## Supported versions

Only the latest release on `main` is supported.
