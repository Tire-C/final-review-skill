#!/usr/bin/env bash
# Validates the repository structure and the Final Review skill definition.
# Used by CI and available for local runs: bash scripts/validate.sh
set -u

REPO_ROOT=$(cd -- "$(dirname -- "$0")/.." && pwd)
cd "$REPO_ROOT" || exit 1

ERRORS=0
fail() { echo "FAIL: $1"; ERRORS=$((ERRORS + 1)); }
ok()   { echo "ok:   $1"; }

echo "== Required files =="
REQUIRED_FILES="README.md LICENSE CHANGELOG.md CONTRIBUTING.md CODE_OF_CONDUCT.md SECURITY.md .gitignore install.sh install.ps1 .github/workflows/ci.yml skills/final-review/SKILL.md scripts/validate.sh scripts/validate.ps1"
for f in $REQUIRED_FILES; do
  if [ -f "$f" ]; then ok "$f"; else fail "missing required file: $f"; fi
done

echo
echo "== SKILL.md frontmatter =="
SKILL="skills/final-review/SKILL.md"
if [ -f "$SKILL" ]; then
  if [ "$(head -n 1 "$SKILL")" = "---" ]; then
    ok "frontmatter delimiter present"
  else
    fail "SKILL.md must start with '---' YAML frontmatter"
  fi
  FM=$(awk 'NR==1 && /^---$/ {infm=1; next} infm && /^---$/ {exit} infm {print}' "$SKILL")
  if printf '%s\n' "$FM" | grep -q '^name: final-review$'; then
    ok "name: final-review"
  else
    fail "frontmatter must declare 'name: final-review'"
  fi
  DESC=$(printf '%s\n' "$FM" | sed -n 's/^description:[[:space:]]*//p')
  if [ -n "$DESC" ]; then
    ok "description present (${#DESC} chars)"
    if [ "${#DESC}" -gt 1024 ]; then
      fail "description exceeds 1024 characters"
    fi
  else
    fail "frontmatter must declare a non-empty single-line 'description'"
  fi
fi

echo
echo "== Secret scan =="
SECRET_PATTERN='ghp_[A-Za-z0-9]{20,}|gho_[A-Za-z0-9]{20,}|ghu_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|BEGIN[A-Z ]*PRIVATE KEY'
MATCHES=$(grep -rInE "$SECRET_PATTERN" --exclude-dir=.git . || true)
if [ -n "$MATCHES" ]; then
  echo "$MATCHES"
  fail "potential secrets found"
else
  ok "no secret patterns detected"
fi

echo
echo "== Relative markdown links =="
BROKEN_FILE=$(mktemp)
find . -name '*.md' -not -path './.git/*' -print | sort | while IFS= read -r file; do
  dir=$(dirname "$file")
  grep -oE '\]\([^)]+\)' "$file" 2>/dev/null | sed -e 's/^](//' -e 's/)$//' | while IFS= read -r target; do
    case "$target" in
      http://*|https://*|mailto:*|"#"*) continue ;;
    esac
    clean=${target%%#*}
    [ -z "$clean" ] && continue
    if [ ! -e "$dir/$clean" ]; then
      echo "$file -> $target" >> "$BROKEN_FILE"
    fi
  done
done
if [ -s "$BROKEN_FILE" ]; then
  while IFS= read -r line; do fail "broken relative link: $line"; done < "$BROKEN_FILE"
else
  ok "all relative markdown links resolve"
fi
rm -f "$BROKEN_FILE"

echo
if [ "$ERRORS" -gt 0 ]; then
  echo "Validation FAILED: $ERRORS error(s)."
  exit 1
fi
echo "Validation PASSED."
