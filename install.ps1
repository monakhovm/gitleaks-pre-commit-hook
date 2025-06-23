$hookUrl = "https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/hook/pre-commit"
$hookPath = ".git/hooks/pre-commit"

Invoke-WebRequest -Uri $hookUrl -OutFile $hookPath -UseBasicParsing