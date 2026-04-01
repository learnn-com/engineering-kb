#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Create a GitHub Release with the latest KB package zip.

Usage:
  scripts/release.sh --version X.Y.Z [--tag vX.Y.Z] [--draft] [--prerelease] [--notes "text"] [--title "text"] [--no-package]

Defaults:
  - Builds package with `npx @foomakers/pair-cli package ...` (unless --no-package)
  - Attaches latest dist/kb-package-*.zip

Env overrides:
  PAIR_AUTHOR   (default: Learnn)
  PAIR_ORG_NAME (default: Learnn)
  PAIR_LAYOUT   (default: source)
  PAIR_CONFIG   (default: pair.config.json)
EOF
}

VERSION=""
TAG=""
TITLE=""
NOTES=""
DRAFT=0
PRERELEASE=0
NO_PACKAGE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version) VERSION="${2:-}"; shift 2 ;;
    --tag) TAG="${2:-}"; shift 2 ;;
    --title) TITLE="${2:-}"; shift 2 ;;
    --notes) NOTES="${2:-}"; shift 2 ;;
    --draft) DRAFT=1; shift ;;
    --prerelease) PRERELEASE=1; shift ;;
    --no-package) NO_PACKAGE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ -z "$VERSION" ]]; then
  echo "Missing required --version (e.g. --version 1.0.0)" >&2
  usage
  exit 2
fi

if [[ -z "$TAG" ]]; then
  TAG="v$VERSION"
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "gh is required. Install GitHub CLI first." >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "gh is not authenticated. Run: gh auth login -h github.com" >&2
  exit 1
fi

GIT=(git)
if [[ -f "$HOME/.gitconfig" ]]; then
  # Avoid failures due to broken global git config. This keeps behavior local to this script.
  GIT=(env GIT_CONFIG_GLOBAL=/dev/null git)
fi

PAIR_AUTHOR="${PAIR_AUTHOR:-Learnn}"
PAIR_ORG_NAME="${PAIR_ORG_NAME:-Learnn}"
PAIR_LAYOUT="${PAIR_LAYOUT:-source}"
PAIR_CONFIG="${PAIR_CONFIG:-pair.config.json}"

if [[ "$NO_PACKAGE" -eq 0 ]]; then
  if [[ ! -f "$PAIR_CONFIG" ]]; then
    echo "Missing $PAIR_CONFIG. Pass PAIR_CONFIG or create it." >&2
    exit 1
  fi

  echo "Packaging KB (version=$VERSION, layout=$PAIR_LAYOUT, config=$PAIR_CONFIG)..."
  npx @foomakers/pair-cli package -s . \
    --config "$PAIR_CONFIG" \
    --layout "$PAIR_LAYOUT" \
    --author "$PAIR_AUTHOR" \
    --org-name "$PAIR_ORG_NAME" \
    --pkg-version "$VERSION"
fi

ZIP="$(ls -1t dist/kb-package-*.zip 2>/dev/null | head -n 1 || true)"
if [[ -z "$ZIP" ]]; then
  echo "No package zip found at dist/kb-package-*.zip" >&2
  exit 1
fi

if [[ -z "$TITLE" ]]; then
  TITLE="$TAG"
fi
if [[ -z "$NOTES" ]]; then
  NOTES="KB package release ($TAG)."
fi

echo "Using asset: $ZIP"

if "${GIT[@]}" rev-parse -q --verify "refs/tags/$TAG" >/dev/null; then
  echo "Tag already exists: $TAG"
else
  "${GIT[@]}" tag "$TAG"
fi

echo "Pushing tag: $TAG"
if ! "${GIT[@]}" push origin "$TAG"; then
  echo "Failed to push tag. Check your git remote/auth." >&2
  exit 1
fi

args=(release create "$TAG" "$ZIP" --title "$TITLE" --notes "$NOTES")
if [[ "$DRAFT" -eq 1 ]]; then args+=(--draft); fi
if [[ "$PRERELEASE" -eq 1 ]]; then args+=(--prerelease); fi

echo "Creating GitHub release..."
gh "${args[@]}"
