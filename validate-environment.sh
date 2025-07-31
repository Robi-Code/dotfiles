#!/bin/bash

# Validation script for GitHub Codespace VS Code environment
# This script validates that the environment is set up correctly

echo "🔍 Validating GitHub Codespace VS Code Environment"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0
WARN=0

# Helper functions
check_pass() {
    echo -e "${GREEN}✅ PASS:${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "${RED}❌ FAIL:${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "${YELLOW}⚠️  WARN:${NC} $1"
    ((WARN++))
}

check_info() {
    echo -e "${BLUE}ℹ️  INFO:${NC} $1"
}

# Check VS Code installation
echo ""
echo "🔧 Checking VS Code Installation..."
if command -v code &> /dev/null; then
    VS_CODE_VERSION=$(code --version | head -n 1)
    check_pass "VS Code is installed (Version: $VS_CODE_VERSION)"
else
    check_fail "VS Code is not installed or not in PATH"
fi

# Check installed extensions
echo ""
echo "📦 Checking Extensions..."
INSTALLED_EXTENSIONS=$(code --list-extensions 2>/dev/null | wc -l | tr -d ' ')
EXPECTED_EXTENSIONS=33

if [ "$INSTALLED_EXTENSIONS" -ge 30 ]; then
    check_pass "Extensions installed: $INSTALLED_EXTENSIONS (Expected: ~$EXPECTED_EXTENSIONS)"
else
    check_fail "Only $INSTALLED_EXTENSIONS extensions installed (Expected: ~$EXPECTED_EXTENSIONS)"
fi

# Check critical extensions
CRITICAL_EXTENSIONS=(
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "eamodio.gitlens"
    "github.copilot"
    "vscode-icons-team.vscode-icons"
)

echo ""
echo "🎯 Checking Critical Extensions..."
for ext in "${CRITICAL_EXTENSIONS[@]}"; do
    if code --list-extensions | grep -q "^$ext$"; then
        check_pass "Critical extension installed: $ext"
    else
        check_fail "Critical extension missing: $ext"
    fi
done

# Check font installation
echo ""
echo "🔤 Checking Font Installation..."
if fc-list | grep -i "jetbrains mono" > /dev/null 2>&1; then
    check_pass "JetBrains Mono font is installed"
else
    check_warn "JetBrains Mono font not detected (may still work in VS Code)"
fi

# Check VS Code settings file
echo ""
echo "⚙️  Checking VS Code Settings..."
SETTINGS_FILE="$HOME/.vscode-server/data/User/settings.json"
if [ ! -f "$SETTINGS_FILE" ]; then
    SETTINGS_FILE="$HOME/.config/Code/User/settings.json"
fi

if [ -f "$SETTINGS_FILE" ]; then
    check_pass "VS Code settings file found: $SETTINGS_FILE"
    
    # Check key settings
    if grep -q "JetBrains Mono" "$SETTINGS_FILE"; then
        check_pass "JetBrains Mono font configured in settings"
    else
        check_warn "JetBrains Mono font not found in settings"
    fi
    
    if grep -q "prettier-vscode" "$SETTINGS_FILE"; then
        check_pass "Prettier configured as default formatter"
    else
        check_warn "Prettier not configured as default formatter"
    fi
    
    if grep -q "vscode-icons" "$SETTINGS_FILE"; then
        check_pass "VS Code Icons theme configured"
    else
        check_warn "VS Code Icons theme not configured"
    fi
else
    check_fail "VS Code settings file not found"
fi

# Check keybindings
echo ""
echo "⌨️  Checking Keybindings..." 
KEYBINDINGS_FILE="$HOME/.vscode-server/data/User/keybindings.json"
if [ ! -f "$KEYBINDINGS_FILE" ]; then
    KEYBINDINGS_FILE="$HOME/.config/Code/User/keybindings.json"
fi

if [ -f "$KEYBINDINGS_FILE" ]; then
    check_pass "Keybindings file found: $KEYBINDINGS_FILE"
    
    if grep -q "shift+space" "$KEYBINDINGS_FILE"; then
        check_pass "Custom Shift+Space keybinding configured"
    else
        check_warn "Custom Shift+Space keybinding not found"
    fi
else
    check_warn "Keybindings file not found (using defaults)"
fi

# Check development tools
echo ""
echo "🛠 Checking Development Tools..."

# Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    check_pass "Node.js is installed ($NODE_VERSION)"
else
    check_fail "Node.js is not installed"
fi

# npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    check_pass "npm is installed ($NPM_VERSION)"
else
    check_fail "npm is not installed"
fi

# Git
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    check_pass "$GIT_VERSION"
else
    check_fail "Git is not installed"
fi

# GitHub CLI
if command -v gh &> /dev/null; then
    GH_VERSION=$(gh --version | head -n 1)
    check_pass "$GH_VERSION"
else
    check_warn "GitHub CLI is not installed"
fi

# Check workspace features
echo ""
echo "🏗 Checking Workspace Features..."

# Check if we're in a Codespace
if [ -n "$CODESPACES" ]; then
    check_pass "Running in GitHub Codespace"
    check_info "Codespace Name: $CODESPACE_NAME"
else
    check_info "Not running in GitHub Codespace (local environment)"
fi

# Check port forwarding capability
if [ -f "/workspaces" ] || [ -n "$CODESPACES" ]; then
    check_pass "Port forwarding should be available"
else
    check_info "Port forwarding not applicable (local environment)"
fi

# Summary
echo ""
echo "📊 Validation Summary"
echo "===================="
echo -e "${GREEN}✅ Passed: $PASS${NC}"
echo -e "${YELLOW}⚠️  Warnings: $WARN${NC}"
echo -e "${RED}❌ Failed: $FAIL${NC}"

echo ""
if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}🎉 Environment validation completed successfully!${NC}"
    echo "Your GitHub Codespace VS Code environment is properly configured."
else
    echo -e "${RED}❌ Environment validation found issues.${NC}"
    echo "Please review the failed checks above and run the setup scripts if needed."
fi

echo ""
echo "🔧 Quick fixes:"
echo "• Run './install-extensions.sh' to install missing extensions"
echo "• Run './sync-settings.sh apply' to apply settings"
echo "• Run '.devcontainer/setup.sh' to set up development environment"

exit $FAIL
