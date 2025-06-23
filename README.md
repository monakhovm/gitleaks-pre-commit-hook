# Gitleaks Pre-Commit Hook

This repository provides a pre-commit hook for [Gitleaks](https://github.com/gitleaks/gitleaks), a tool for detecting hardcoded secrets like passwords, API keys, and tokens in your Git repositories.

## Features

- **Automatic secret scanning** before every commit
- **Easy integration** with existing Git workflows
- **Customizable configuration** for Gitleaks

## Prerequisites

- Git
- Git repository

## Installation

1. From the ***root** of your `Git` repository*, run
```sh
curl https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/install.sh | sh
```

## Usage

Enable the pre-commit hook by running the following command in your `Git` repository:
```sh
git config core.gitleaks true
```

If `core.gitleaks` is not set, the pre-commit hook will set it to true automatically.

Once installed and enabled, every `git commit` will trigger Gitleaks to scan staged changes for secrets. If any are found, the commit will be blocked and a report will be shown.

Disable the pre-commit hook by running:
```sh
git config core.gitleaks false
```

## Configuration

- See the [Gitleaks documentation](https://github.com/gitleaks/gitleaks#configuration) for details.

## References

- [Gitleaks Documentation](https://github.com/gitleaks/gitleaks)
- [Git Hooks Documentation](https://git-scm.com/docs/githooks)