# Installation

The skill is the `skills/final-review/` directory. Installing means copying that directory into the skills location of your client. Nothing else is required — no dependencies, no build step.

## 1. Claude Code — personal skill

Available in every project on your machine.

```sh
# macOS / Linux
./install.sh
# or manually:
cp -R skills/final-review ~/.claude/skills/final-review
```

```powershell
# Windows
.\install.ps1
# or manually:
Copy-Item -Recurse skills\final-review "$HOME\.claude\skills\final-review"
```

## 2. Claude Code — project skill

Available only inside one project, and shared with collaborators if committed to the project's repository.

```sh
# from this repository's root, targeting the current directory's project:
./install.sh project
# or manually, from your project root:
cp -R <path-to-this-repo>/skills/final-review .claude/skills/final-review
```

```powershell
.\install.ps1 -Target project
```

## 3. Other Agent Skills-compatible clients

Copy `skills/final-review/` into whatever skills directory your client supports, keeping the directory name `final-review`. The skill is a single `SKILL.md` with standard YAML frontmatter (`name`, `description`), so any client implementing the Agent Skills format can load it.

## 4. Custom destination

```powershell
.\install.ps1 -Path C:\path\to\skills\final-review
```

```sh
./install.sh /path/to/skills/final-review
```

## Verify the installation

Start a **new** agent session and ask: *"final review of this project"*. The agent should pick up the Final Review skill and return the fixed-format report. In Claude Code, `/final-review` should appear among the available skills.

## Update / uninstall

- **Update:** re-run the install script; it overwrites the destination.
- **Uninstall:** delete the `final-review` directory from your skills location.
