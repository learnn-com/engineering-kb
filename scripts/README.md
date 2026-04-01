# Scripts

## Release

Create a GitHub Release and attach the latest KB package zip:

```bash
chmod +x scripts/release.sh
scripts/release.sh --version 1.0.0
```

Common options:

```bash
scripts/release.sh --version 1.0.0 --draft
scripts/release.sh --version 1.0.0 --notes "Release notes..."
scripts/release.sh --version 1.0.0 --no-package   # reuse existing dist/*.zip
```

If auth fails, re-login:

```bash
gh auth login -h github.com
```
