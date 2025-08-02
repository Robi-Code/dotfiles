#!/bin/bash

# Complete Environment Summary
# Shows the current state of your dotfiles setup

echo "🚀 Robi's Development Environment Summary"
echo "========================================"

# VS Code Extensions
echo ""
echo "📦 VS Code Extensions ($( code --list-extensions | wc -l | tr -d ' ') installed):"
code --list-extensions | head -10
if [ $(code --list-extensions | wc -l) -gt 10 ]; then
    echo "   ... and $(($(code --list-extensions | wc -l) - 10)) more"
fi

# Configuration Files
echo ""
echo "⚙️  Configuration Files:"
echo "✅ VS Code Settings: .config/Code/User/settings.json ($(wc -l < .config/Code/User/settings.json) lines)"
echo "✅ VS Code Keybindings: .config/Code/User/keybindings.json"
echo "✅ DevContainer Config: .devcontainer/devcontainer.json"
echo "✅ PowerShell Profile: .devcontainer/Microsoft.PowerShell_profile.ps1"
echo "✅ Oh My Posh Theme: .devcontainer/robi-dev-theme.omp.json"

# Scripts
echo ""
echo "🔧 Available Scripts:"
echo "• ./install-extensions.sh - Install all VS Code extensions"
echo "• ./sync-settings.sh - Sync settings between local and dotfiles"
echo "• ./validate-environment.sh - Validate complete environment"
echo "• .devcontainer/setup.sh - GitHub Codespace setup script"
echo "• .devcontainer/Test-PowerShellEnvironment.ps1 - PowerShell validation"

# Key Features
echo ""
echo "✨ Key Features Configured:"
echo "• 🎨 Theme: Default Dark Modern with VS Code Icons"
echo "• 🔤 Font: JetBrains Mono with ligatures"
echo "• ⌨️  Custom Keybinding: Shift+Space for autocomplete"
echo "• 🎯 Prettier: Single quotes, 4-space tabs, 120 char width"
echo "• 📝 TODO Highlighting: 8 custom keyword categories"
echo "• 🚀 PowerShell: Default terminal with Oh My Posh theme"
echo "• 📚 PSReadLine: IntelliSense with history predictions"
echo "• 🎮 Custom Aliases: gs, ga, gc, nrd, nrs, etc."

# GitHub Codespace Features
echo ""
echo "☁️  GitHub Codespace Features:"
echo "• 🔄 Automatic extension installation"
echo "• ⚙️  Complete settings synchronization"
echo "• 🎨 Oh My Posh with custom development theme"
echo "• 📦 PowerShell modules: PSReadLine, Terminal-Icons, z, posh-git"
echo "• 🛠 Development tools: Node.js, Python, Git, GitHub CLI"
echo "• ⚡ Port forwarding: 3000, 8000, 8080, 5000, 4200"

# Quick Tests
echo ""
echo "🧪 Quick Environment Tests:"

# Test VS Code
if command -v code &> /dev/null; then
    echo "✅ VS Code CLI available"
else
    echo "❌ VS Code CLI not found"
fi

# Test Git
if command -v git &> /dev/null; then
    echo "✅ Git available ($(git --version | cut -d' ' -f3))"
else
    echo "❌ Git not found"
fi

# Test Node
if command -v node &> /dev/null; then
    echo "✅ Node.js available ($(node --version))"
else
    echo "❌ Node.js not found"
fi

# Test PowerShell (if available)
if command -v pwsh &> /dev/null; then
    echo "✅ PowerShell available ($(pwsh --version | cut -d' ' -f2))"
else
    echo "ℹ️  PowerShell not installed locally (will be available in Codespace)"
fi

echo ""
echo "📖 Documentation:"
echo "• README.md - Complete setup documentation"
echo "• POWERSHELL-SETUP.md - PowerShell + Oh My Posh guide"

echo ""
echo "🔗 Next Steps:"
echo "1. Push to GitHub: git add . && git commit -m 'Complete environment setup' && git push"
echo "2. Create a new GitHub Codespace to test the setup"
echo "3. Run validation scripts to ensure everything works"

echo ""
echo "🎉 Environment setup complete! Happy coding! 🚀"
