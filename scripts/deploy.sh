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
# USAGE — no arguments needed; it already targets the live project:
#
#   bash deploy.sh
#
# To run it completely from scratch on a fresh machine/agent:
#
#   curl -fsSL https://raw.githubusercontent.com/vincentbraakman-glitch/nomadikas-private-selection/main/scripts/deploy.sh -o deploy.sh
#   bash deploy.sh
#
# ──────────────────────────────────────────────────────────────────────────
# OPTIONAL:
#   VERCEL_PROJECT  Existing Vercel project to overwrite. Defaults to
#                   'nomadikas-private-selection' (serves the .vercel.app URL
#                   above). Only override if the page is moved elsewhere.
#   VERCEL_TOKEN    Vercel access token, for non-interactive auth. If unset,
#                   you must have run `vercel login` first.
#   VERCEL_SCOPE    Team / org slug, if the project lives under a team.
#   WORKDIR         Where to clone (default: ./nomadikas-private-selection).
# ──────────────────────────────────────────────────────────────────────────

set -euo pipefail

REPO_URL="https://github.com/vincentbraakman-glitch/nomadikas-private-selection.git"
WORKDIR="${WORKDIR:-nomadikas-private-selection}"

# Existing project that serves https://nomadikas-private-selection.vercel.app
# Override only if the page is ever moved to a differently-named project.
VERCEL_PROJECT="${VERCEL_PROJECT:-nomadikas-private-selection}"

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
