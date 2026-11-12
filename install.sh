#!/usr/bin/env sh
# Installs the Final Review skill for Claude Code or any Agent Skills-compatible client.
#
# Usage:
#   ./install.sh                 personal -> ~/.claude/skills/final-review (default)
#   ./install.sh project         project  -> ./.claude/skills/final-review
#   ./install.sh /custom/dir     custom destination (other Agent Skills clients)
set -eu

usage() {
  cat <<'EOF'
Usage:
  ./install.sh                 personal -> ~/.claude/skills/final-review (default)
  ./install.sh project         project  -> ./.claude/skills/final-review
  ./install.sh /custom/dir     custom destination (other Agent Skills clients)
EOF
}

if [ "$#" -gt 1 ]; then
  echo "error: too many arguments" >&2
  usage >&2
  exit 1
fi

case "${1:-personal}" in
  -h|--help)
    usage
    exit 0
    ;;
  -*)
    echo "error: unknown option '$1'" >&2
    usage >&2
    exit 1
    ;;
  personal) DEST="$HOME/.claude/skills/final-review" ;;
  project)  DEST="$(pwd)/.claude/skills/final-review" ;;
  *)        DEST="$1" ;;
esac

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE="$SCRIPT_DIR/skills/final-review"

if [ ! -f "$SOURCE/SKILL.md" ]; then
  echo "error: source skill not found at $SOURCE (run from the repository root)" >&2
  exit 1
fi

mkdir -p -- "$DEST"
cp -R "$SOURCE"/. "$DEST"/

echo "Final Review skill installed to: $DEST"
echo "Start a new agent session to pick up the skill."
