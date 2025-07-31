#!/bin/bash

# Complete VS Code extensions list (based on current installation)
extensions=(
    # Development Tools
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    ms-vscode.vscode-typescript-next
    formulahendry.auto-rename-tag
    kuscamara.remove-unused-imports
    
    # Git & Collaboration
    eamodio.gitlens
    github.copilot
    github.copilot-chat
    github.vscode-github-actions
    ms-vsliveshare.vsliveshare
    
    # Visual Enhancements
    vscode-icons-team.vscode-icons
    elanandkumar.el-vsc-product-icon-theme
    aaron-bond.better-comments
    naumovs.color-highlight
    kamikillerto.vscode-colorize
    gruntfuggly.todo-tree
    usernamehw.errorlens
    wayou.vscode-todo-highlight
    
    # Productivity
    streetsidesoftware.code-spell-checker
    wix.vscode-import-cost
    sleistner.vscode-fileutils
    adpyke.codesnap
    
    # Framework/Language Specific
    bradlc.vscode-tailwindcss
    rodrigovallades.es7-react-js-snippets
    ms-playwright.playwright
    davidanson.vscode-markdownlint
    
    # Development Tools
    ritwickdey.liveserver
    wallabyjs.console-ninja
    wallabyjs.quokka-vscode
    wallabyjs.wallaby-vscode
    
    # AI/Productivity
    codeium.codeium
    intlayer.intlayer-vs-code-extension
    kilocode.kilo-code
    
    # System Tools
    ms-vscode.powershell
)

echo "🚀 Installing VS Code extensions..."
echo "Total extensions to install: ${#extensions[@]}"

for extension in "${extensions[@]}"
do
    echo "Installing: $extension"
    code --install-extension "$extension"
done

echo "✅ All extensions installed successfully!"
echo ""
echo "💡 To verify installation, run: code --list-extensions"
