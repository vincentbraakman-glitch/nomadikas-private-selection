#!/usr/bin/env bash
#
# deploy.sh — clone (or update) the Nomadikas private-selection proposal and
# push it to Vercel production, REPLACING the page Darina deployed previously.
#
# This site is static HTML (no build step), so Vercel just serves the files.
# Running this again later re-clones the latest main and re-deploys — that is
# how you ship an update: run it, the production URL/domain swaps to the new build.
#
# ──────────────────────────────────────────────────────────────────────────
# USAGE (from anywhere):
#
#   VERCEL_PROJECT=<existing-project-name> bash deploy.sh
#
# To run it completely from scratch on a fresh machine/agent:
#
#   curl -fsSL https://raw.githubusercontent.com/vincentbraakman-glitch/nomadikas-private-selection/main/scripts/deploy.sh -o deploy.sh
#   VERCEL_PROJECT=<existing-project-name> bash deploy.sh
#
# ──────────────────────────────────────────────────────────────────────────
# REQUIRED:
#   VERCEL_PROJECT  Name of the EXISTING Vercel project that currently serves
#                   Darina's page. Using the same name means this deploy
#                   overwrites it (and any custom domain auto-points to the new
#                   build) instead of creating a second, separate page.
#
# OPTIONAL:
#   VERCEL_TOKEN    Vercel access token, for non-interactive auth. If unset,
#                   you must have run `vercel login` first.
#   VERCEL_SCOPE    Team / org slug, if the project lives under a team.
#   WORKDIR         Where to clone (default: ./nomadikas-private-selection).
# ──────────────────────────────────────────────────────────────────────────

set -euo pipefail

REPO_URL="https://github.com/vincentbraakman-glitch/nomadikas-private-selection.git"
WORKDIR="${WORKDIR:-nomadikas-private-selection}"

: "${VERCEL_PROJECT:?Set VERCEL_PROJECT to the existing Vercel project name to overwrite (e.g. VERCEL_PROJECT=nomadikas-private-selection bash deploy.sh)}"

# 1. Get the latest code (fresh clone, or hard-reset an existing one to origin/main)
if [ -d "$WORKDIR/.git" ]; then
  echo "→ Updating existing clone in '$WORKDIR' to latest main ..."
  git -C "$WORKDIR" fetch origin
  git -C "$WORKDIR" reset --hard origin/main
else
  echo "→ Cloning $REPO_URL ..."
  git clone "$REPO_URL" "$WORKDIR"
fi
cd "$WORKDIR"

# 2. Make sure the Vercel CLI is available
if ! command -v vercel >/dev/null 2>&1; then
  echo "→ Installing Vercel CLI (npm i -g vercel) ..."
  npm i -g vercel
fi

# 3. Assemble optional auth flags
COMMON=()
[ -n "${VERCEL_TOKEN:-}" ] && COMMON+=(--token "$VERCEL_TOKEN")
[ -n "${VERCEL_SCOPE:-}" ] && COMMON+=(--scope "$VERCEL_SCOPE")

# 4. Link this folder to the EXISTING project so the deploy overwrites her page
echo "→ Linking to existing Vercel project '$VERCEL_PROJECT' ..."
vercel link --yes --project "$VERCEL_PROJECT" "${COMMON[@]}"

# 5. Ship to production (static — no framework build)
echo "→ Deploying to production ..."
vercel deploy --prod --yes "${COMMON[@]}"

echo "✓ Done. Production now serves the updated proposal (incl. Indonesia / Sumba)."
