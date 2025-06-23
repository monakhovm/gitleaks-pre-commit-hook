#!/usr/bin/env bash

curl -fsSL -o .git/hooks/pre-commit https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/hook/pre-commit
chmod +x .git/hooks/pre-commit