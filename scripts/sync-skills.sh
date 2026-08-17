#!/usr/bin/env bash
# Sync vendored skill content from upstream source-of-truth repositories.
# Skills are vendored (not git submodules) so Claude plugin installs work on a
# plain checkout without `git submodule update --init`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

DATABASE_SKILLS_REPO="${DATABASE_SKILLS_REPO:-https://github.com/planetscale/database-skills.git}"
SKILLS_REPO="${SKILLS_REPO:-https://github.com/planetscale/skills.git}"
DATABASE_SKILLS_REF="${DATABASE_SKILLS_REF:-main}"
SKILLS_REF="${SKILLS_REF:-main}"

TMP="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP"
}
trap cleanup EXIT

echo "Cloning database-skills (${DATABASE_SKILLS_REF})..."
git clone --depth 1 --branch "$DATABASE_SKILLS_REF" "$DATABASE_SKILLS_REPO" "$TMP/database-skills"
DATABASE_SKILLS_SHA="$(git -C "$TMP/database-skills" rev-parse HEAD)"

echo "Cloning planetscale/skills (${SKILLS_REF})..."
git clone --depth 1 --branch "$SKILLS_REF" "$SKILLS_REPO" "$TMP/planetscale-skills"
SKILLS_SHA="$(git -C "$TMP/planetscale-skills" rev-parse HEAD)"

echo "Vendoring database-skills/skills @ ${DATABASE_SKILLS_SHA}..."
rm -rf database-skills
mkdir -p database-skills
cp -a "$TMP/database-skills/skills" database-skills/skills
cp "$TMP/database-skills/LICENSE" database-skills/LICENSE
cp "$TMP/database-skills/README.md" database-skills/README.md

echo "Vendoring planetscale-skills @ ${SKILLS_SHA}..."
rm -rf planetscale-skills
mkdir -p planetscale-skills
tar -C "$TMP/planetscale-skills" --exclude='.git' -cf - . | tar -C planetscale-skills -xf -

cat > .skills-versions.json <<EOF
{
  "database-skills": {
    "repository": "https://github.com/planetscale/database-skills",
    "ref": "${DATABASE_SKILLS_REF}",
    "sha": "${DATABASE_SKILLS_SHA}"
  },
  "planetscale-skills": {
    "repository": "https://github.com/planetscale/skills",
    "ref": "${SKILLS_REF}",
    "sha": "${SKILLS_SHA}"
  }
}
EOF

echo "Synced:"
echo "  database-skills     -> ${DATABASE_SKILLS_SHA}"
echo "  planetscale-skills  -> ${SKILLS_SHA}"
