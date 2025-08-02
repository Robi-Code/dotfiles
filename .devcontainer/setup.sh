#!/bin/bash

# Setup script for GitHub Codespace development environment
echo "🚀 Setting up development environment..."

# Install JetBrains Mono font
echo "📦 Installing JetBrains Mono font..."
mkdir -p ~/.local/share/fonts
cd /tmp
wget -q https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip
unzip -q JetBrainsMono-2.304.zip
cp fonts/ttf/*.ttf ~/.local/share/fonts/
fc-cache -f -v > /dev/null 2>&1

# Install additional development tools
echo "🔧 Installing additional development tools..."

# Install pnpm (alternative to npm/yarn)
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Update npm to latest
npm install -g npm@latest

# Install global packages commonly used in development
npm install -g @playwright/test typescript ts-node nodemon

# Install Oh My Posh
echo "🎨 Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

# Install PowerShell modules
echo "📦 Installing PowerShell modules..."
pwsh -NoProfile -Command "
    Write-Host '📚 Installing PSReadLine...' -ForegroundColor Blue
    Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
    
    Write-Host '🎨 Installing Terminal-Icons...' -ForegroundColor Blue  
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
    
    Write-Host '📂 Installing z (directory jumper)...' -ForegroundColor Blue
    Install-Module -Name z -Scope CurrentUser -Force
    
    Write-Host '🔧 Installing posh-git...' -ForegroundColor Blue
    Install-Module -Name posh-git -Scope CurrentUser -Force
    
    Write-Host '✅ PowerShell modules installed successfully!' -ForegroundColor Green
"

# Set up PowerShell profile
echo "⚙️  Setting up PowerShell profile..."
PWSH_PROFILE_DIR="/home/codespace/.config/powershell"
mkdir -p "$PWSH_PROFILE_DIR"

# Copy the profile to the correct location
cp /workspaces/$(basename "$CODESPACE_VSCODE_FOLDER")/.devcontainer/Microsoft.PowerShell_profile.ps1 "$PWSH_PROFILE_DIR/"

# Copy custom Oh My Posh theme
cp /workspaces/$(basename "$CODESPACE_VSCODE_FOLDER")/.devcontainer/robi-dev-theme.omp.json "$PWSH_PROFILE_DIR/"

# Also create a symlink for the standard profile location
mkdir -p "/home/codespace/Documents/PowerShell"
ln -sf "$PWSH_PROFILE_DIR/Microsoft.PowerShell_profile.ps1" "/home/codespace/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"

echo "✅ PowerShell profile configured!"

# Set up git configuration if not already set
echo "⚙️  Setting up git configuration..."
if [ -z "$(git config --global user.name)" ]; then
    echo "Git user.name not set. You may want to configure it:"
    echo "git config --global user.name 'Your Name'"
fi

if [ -z "$(git config --global user.email)" ]; then
    echo "Git user.email not set. You may want to configure it:"
    echo "git config --global user.email 'your.email@example.com'"
fi

# Create useful aliases
echo "🔗 Setting up shell aliases..."
cat >> ~/.bashrc << 'EOF'

# Custom aliases for development
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Development aliases
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'

EOF

# Source the bashrc to apply aliases
source ~/.bashrc

# Set up Node.js environment
echo "📦 Setting up Node.js environment..."
# Ensure we have the latest LTS version of Node.js
# (This will be handled by the devcontainer features)

# Install Playwright browsers if Playwright is detected in any package.json
echo "🎭 Checking for Playwright..."
find /workspaces -name "package.json" -exec grep -l "playwright" {} \; | head -1 | while read package_file; do
    if [ -n "$package_file" ]; then
        echo "Found Playwright in project, installing browsers..."
        cd "$(dirname "$package_file")"
        npx playwright install
        break
    fi
done

# Create a welcome message
echo "✅ Development environment setup complete!"
echo ""
echo "🎉 Your GitHub Codespace is now configured with:"
echo "   • All your VS Code extensions"
echo "   • Your custom settings and keybindings"
echo "   • JetBrains Mono font"
echo "   • PowerShell with Oh My Posh theme"
echo "   • PSReadLine with IntelliSense"
echo "   • Terminal Icons and directory jumper (z)"
echo "   • Development tools and aliases"
echo ""
echo "💡 Quick tips:"
echo "   • Use 'gs' for git status"
echo "   • Use 'nrd' for npm run dev"
echo "   • Press Shift+Space for autocomplete (as configured)"
echo "   • PowerShell is now your default terminal"
echo "   • Type 'Get-Weather' for weather info"
echo ""
echo "🔄 To use PowerShell immediately, run: pwsh"
echo "Happy coding! 🚀"
