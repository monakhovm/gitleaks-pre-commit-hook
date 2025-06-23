# 1. Перевіряємо, чи це git-репозиторій
if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Write-Error "Ця директорія не є git-репозиторієм. Вихід."
    exit 1
}

# 2. Переходимо в корінь репозиторію
$gitRoot = git rev-parse --show-toplevel
Set-Location $gitRoot

# 3. Завантажуємо pre-commit hook у .git/hooks/
$hookUrl = "https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/hook/pre-commit"
$hookPath = ".git/hooks/pre-commit"

# Використовуємо curl (або Invoke-WebRequest, якщо curl не встановлено)
if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
    curl -fsSL -o $hookPath $hookUrl
} else {
    Invoke-WebRequest -Uri $hookUrl -OutFile $hookPath
}

# Для Linux/WSL додаємо права на виконання
if ($IsLinux -or $IsMacOS) {
    chmod +x $hookPath
}
