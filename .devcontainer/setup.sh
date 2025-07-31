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
echo "   • Development tools and aliases"
echo ""
echo "💡 Quick tips:"
echo "   • Use 'gs' for git status"
echo "   • Use 'nrd' for npm run dev"
echo "   • Press Shift+Space for autocomplete (as configured)"
echo ""
echo "Happy coding! 🚀"
