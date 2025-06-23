if (-not (git rev-parse --is-inside-work-tree 2>$null)) 
{
    Write-Error "Not a git repo. Exiting."
    exit 1
}

$gitRoot = git rev-parse --show-toplevel
Set-Location $gitRoot

$hookUrl = "https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/hook/pre-commit"
$hookPath = ".git/hooks/pre-commit"

if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
    curl -o $hookPath $hookUrl
} else {
    Invoke-WebRequest -Uri $hookUrl -OutFile $hookPath
}

if ($IsLinux -or $IsMacOS) {
    chmod +x $hookPath
}
