#!/bin/bash

# --- Configuration ---
# URL to your main pre-commit script (with Gitleaks logic)
# Replace this with the actual URL of your script!
PRE_COMMIT_SCRIPT_URL="https://raw.githubusercontent.com/monakhovm/gitleaks-pre-commit-hook/refs/heads/main/hook/pre-commit"

# --- Helper Functions ---
log_info() {
    echo "💡 INFO: $1"
}

log_error() {
    echo "❌ ERROR: $1" >&2
}

# --- 1. Check if we are inside a Git repository ---
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    log_error "You are not inside a Git repository. Please navigate to the root directory of your repository."
    exit 1
fi

GIT_ROOT=$(git rev-parse --show-toplevel)
cd "$GIT_ROOT" || { log_error "Failed to navigate to the Git repository root."; exit 1; }

log_info "You are in the Git repository root: $GIT_ROOT"

# --- 2. Check for curl or wget availability ---
DOWNLOAD_TOOL=""
if command -v curl &> /dev/null; then
    DOWNLOAD_TOOL="curl -fsSL" # -f: fail silently, -s: silent, -S: show errors, -L: follow redirects
elif command -v wget &> /dev/null; then
    DOWNLOAD_TOOL="wget -qO-" # -q: quiet, -O-: output to stdout
else
    log_error "Neither 'curl' nor 'wget' found. Please install one of them."
    exit 1
fi

# --- 3. Download and install the pre-commit script ---
PRE_COMMIT_HOOK_PATH=".git/hooks/pre-commit"

log_info "Downloading pre-commit script from $PRE_COMMIT_SCRIPT_URL..."
$DOWNLOAD_TOOL "$PRE_COMMIT_SCRIPT_URL" > "$PRE_COMMIT_HOOK_PATH"

if [ $? -ne 0 ]; then
    log_error "Failed to download the pre-commit script."
    exit 1
fi

log_info "Granting executable permissions to the script: $PRE_COMMIT_HOOK_PATH"
chmod +x "$PRE_COMMIT_HOOK_PATH"

if [ $? -ne 0 ]; then
    log_error "Failed to grant executable permissions to the script."
    exit 1
fi

log_info "Pre-commit hook installed successfully."

# --- 4. Activate Gitleaks hook via git config ---
log_info "Activating Gitleaks hook using 'git config core.gitleaks-enable true'..."
git config core.gitleaks-enable true

log_info "Success! Gitleaks will now check your code before each commit."
log_info "Try making a commit to test the hook."
log_info "You can disable Gitleaks using: git config core.gitleaks-enable false"

exit 0