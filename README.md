# Engineering KB — Packaging & Release

Operational guide to validate, package, and publish the **engineering knowledge base (KB)** as a ZIP artifact, then attach it to a **GitHub Release** for consumers to install/update from.

## Audience

- KB maintainers (this repository)
- Platform/DevEx engineers responsible for distributing KB updates

## Prerequisites

- Node.js + npm
- Git
- GitHub CLI (`gh`) (used by the release script)
- Pair CLI (`pair-cli`) installed globally

## 1) One-time CLI setup

### Install GitHub CLI

```bash
gh --version
```

If missing, install it (macOS/Homebrew example):

```bash
brew install gh
```

### Authenticate `gh`

```bash
gh auth login -h github.com
gh auth status
```

### Install `pair-cli`

The release script invokes `pair-cli package ...`. Install it globally:

```bash
npm install -g @foomakers/pair-cli
```

If the package is hosted on **GitHub Packages**, authenticate npm before installing.

#### 1. Create a GitHub Personal Access Token (PAT)

Create a PAT that can read packages from GitHub Packages.

- If the package is in a private org/repo, you typically need:
  - `read:packages`
  - and repository access as needed (depending on org settings)

#### 2. Configure `.npmrc` (do not commit tokens)

This repo ignores `.npmrc` via `.gitignore`. Keep your token **local**.

Option A (recommended): use an environment variable in a repo-local `.npmrc`

Create `./.npmrc` with:

```properties
@foomakers:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```

Then export the token in your shell:

```bash
export GITHUB_TOKEN="YOUR_PAT_HERE"
```

After setup, verify the CLI:

```bash
pair-cli --help
```

## 2) Release (packages + publishes)

Use the release script as the **only supported workflow** in this repository.
It will:

- validate/package the KB into a ZIP (internally)
- tag the version
- create a GitHub Release and upload the ZIP asset

### Usage

```bash
chmod +x scripts/release.sh
scripts/release.sh --version 1.0.1
```

Common options:

```bash
scripts/release.sh --version 1.0.1 --draft
scripts/release.sh --version 1.0.1 --notes "Release notes..."
scripts/release.sh --version 1.0.1 --no-package   # reuse existing dist/*.zip
```

## What gets published

The script publishes:

- a Git tag, e.g. `v1.0.1`
- a GitHub Release named `v1.0.1`
- a ZIP asset under `dist/` (example: `dist/kb-package-<timestamp>.zip`)
- a `manifest.json` inside the ZIP with metadata (including the package version)

## Troubleshooting

### `gh auth status` fails

Re-authenticate:

```bash
gh auth login -h github.com
```

### `pair-cli: command not found`

Install or reinstall globally:

```bash
npm install -g @foomakers/pair-cli
pair-cli --help
```

### Package version vs CLI version

- `pair vX.Y.Z` printed in logs is the **CLI version**
- `--pkg-version A.B.C` is the **package version** that goes into the package manifest
