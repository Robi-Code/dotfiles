# 🚀 Robi's Development Environment - Dotfiles

This repository contains my complete VS Code development environment configuration, designed to ensure consistency between local development and GitHub Codespaces.

## 📦 What's Included

### 🔧 **VS Code Configuration**
- **Settings**: Complete `settings.json` with all preferences
- **Keybindings**: Custom shortcuts (Shift+Space for autocomplete)
- **Extensions**: 33+ carefully selected extensions

### 🎨 **Theme & Appearance**
- **Theme**: Default Dark Modern
- **Icons**: VS Code Icons + El VSC Product Icons
- **Font**: JetBrains Mono with ligatures
- **Font Sizes**: Editor (16px), Terminal (14px)

### 🛠 **Development Tools**
- **Formatters**: Prettier with custom configuration
- **Linters**: ESLint with format on save
- **Git**: GitLens with enhanced features
- **AI**: GitHub Copilot + Copilot Chat
- **Testing**: Playwright, Wallaby.js, Quokka.js
- **Terminal**: PowerShell with Oh My Posh theme
- **Shell**: Custom aliases and productivity functions

## 🏗 **Project Structure**

```
dotfiles/
├── .config/Code/User/          # VS Code user settings
│   ├── settings.json           # All VS Code settings
│   └── keybindings.json        # Custom keybindings
├── .devcontainer/              # GitHub Codespace configuration
│   ├── devcontainer.json       # Container configuration
│   ├── setup.sh               # Post-creation setup script
│   └── keybindings.json       # Keybindings for Codespace
├── install-extensions.sh       # Extension installation script
├── sync-settings.sh           # Bidirectional settings sync
├── validate-environment.sh    # Environment validation
├── POWERSHELL-SETUP.md        # PowerShell + Oh My Posh documentation
└── README.md                  # This file
```

## 🚀 **Quick Start**

### **For Local Development**
```bash
# Clone this repository
git clone <your-repo-url> ~/dotfiles

# Install all extensions
cd ~/dotfiles
./install-extensions.sh

# Copy settings (backup your existing ones first!)
cp .config/Code/User/settings.json ~/.config/Code/User/
cp .config/Code/User/keybindings.json ~/.config/Code/User/
```

### **For GitHub Codespaces**
1. Push this repository to GitHub
2. Open any repository in GitHub Codespaces
3. The `.devcontainer/devcontainer.json` will automatically:
   - Install all extensions
   - Apply all settings
   - Set up the development environment
   - Install JetBrains Mono font

## 📋 **Installed Extensions (33 total)**

### **🔧 Development Tools**
- `esbenp.prettier-vscode` - Code formatter
- `dbaeumer.vscode-eslint` - JavaScript/TypeScript linting
- `ms-vscode.vscode-typescript-next` - Advanced TypeScript support
- `formulahendry.auto-rename-tag` - Auto rename paired HTML tags
- `kuscamara.remove-unused-imports` - Clean up unused imports

### **🌿 Git & Collaboration**
- `eamodio.gitlens` - Supercharge Git capabilities
- `github.copilot` - AI-powered code completion
- `github.copilot-chat` - AI chat assistant
- `github.vscode-github-actions` - GitHub Actions support
- `ms-vsliveshare.vsliveshare` - Real-time collaboration

### **🎨 Visual Enhancements**
- `vscode-icons-team.vscode-icons` - File/folder icons
- `elanandkumar.el-vsc-product-icon-theme` - Product icons
- `aaron-bond.better-comments` - Enhanced comment highlighting
- `naumovs.color-highlight` - CSS color visualization
- `kamikillerto.vscode-colorize` - Color string highlighting
- `gruntfuggly.todo-tree` - TODO management
- `usernamehw.errorlens` - Inline error/warning display
- `wayou.vscode-todo-highlight` - TODO keyword highlighting

### **⚡ Productivity**
- `streetsidesoftware.code-spell-checker` - Spell checking
- `wix.vscode-import-cost` - Display import sizes
- `sleistner.vscode-fileutils` - File operation utilities
- `adpyke.codesnap` - Code screenshot generation

### **🌐 Framework/Language Specific**
- `bradlc.vscode-tailwindcss` - Tailwind CSS support
- `rodrigovallades.es7-react-js-snippets` - React snippets
- `ms-playwright.playwright` - Playwright testing
- `davidanson.vscode-markdownlint` - Markdown linting

### **🔧 Development Tools**
- `ritwickdey.liveserver` - Live reload server
- `wallabyjs.console-ninja` - Advanced console logging
- `wallabyjs.quokka-vscode` - Live JavaScript playground
- `wallabyjs.wallaby-vscode` - Continuous testing

### **🤖 AI/Productivity**
- `codeium.codeium` - Alternative AI completion
- `intlayer.intlayer-vs-code-extension` - Internationalization
- `kilocode.kilo-code` - Code metrics

## ⚙️ **Key Settings & Features**

### **🎯 Code Formatting**
- **Format on Save**: Enabled with Prettier
- **Single Quotes**: Preferred over double quotes
- **Trailing Commas**: Added everywhere
- **Tab Width**: 4 spaces
- **Print Width**: 120 characters

### **⌨️ Custom Keybindings**
- **Shift+Space**: Trigger autocomplete (instead of Ctrl+Space)
- All suggestion-related shortcuts use Shift+Space

### **🎨 TODO Highlighting**
Custom highlighting for:
- `TODO` - Red background
- `FIXME` - Orange background  
- `BUG` - Red-orange background
- `HACK` - Magenta background
- `NOTE` - Blue background
- `IDEA` - Purple background
- `IMPORTANT` - Red background
- `DONE` - Green background

### **🔧 Language-Specific Settings**
- **TypeScript/JavaScript**: Auto-remove unused imports
- **Markdown**: Format on save disabled
- **All Languages**: Inlay hints for parameters and types

## 🚀 **GitHub Codespace Features**

The `.devcontainer` configuration provides:

### **🏗 Environment Setup**
- Ubuntu-based universal development image
- Node.js LTS, Python, Git, GitHub CLI
- Automatic port forwarding (3000, 8000, 8080, 5000, 4200)

### **🎨 Font Installation**
- Automatic JetBrains Mono font installation
- Proper font caching for immediate availability

### **⚡ Development Tools**
- Global packages: Playwright, TypeScript, ts-node, nodemon
- Shell aliases for common commands
- Git configuration helpers

### **🔧 Post-Creation Script**
The `setup.sh` script automatically:
- Installs JetBrains Mono font
- Sets up development tools
- Configures shell aliases
- Installs Playwright browsers if detected
- Provides helpful welcome message

## 🛠 **Usage Tips**

### **Useful Aliases (in Codespace)**
```bash
# Git shortcuts
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git log --oneline

# NPM shortcuts  
nrd         # npm run dev
nrs         # npm run start
nrb         # npm run build
nrt         # npm run test
```

### **PowerShell Features**
```powershell
# PowerShell-specific commands (when using PowerShell terminal)
Get-Weather         # Weather information
Get-PublicIP       # Your public IP
Edit-Profile       # Edit PowerShell profile
Reload-Profile     # Reload PowerShell profile

# Validation
pwsh .devcontainer/Test-PowerShellEnvironment.ps1  # Test PowerShell setup
```

### **Extension Verification**
```bash
# Check installed extensions
code --list-extensions

# Count total extensions
code --list-extensions | wc -l
```

## 🔄 **Keeping in Sync**

### **Export Current Settings**
```bash
# Copy current VS Code settings to this repo
cp ~/.config/Code/User/settings.json .config/Code/User/
cp ~/.config/Code/User/keybindings.json .config/Code/User/

# Update extension list
code --list-extensions > extensions-list.txt
```

### **Update DevContainer**
When you add new extensions locally:
1. Update `install-extensions.sh`
2. Update `.devcontainer/devcontainer.json` extensions list
3. Commit and push changes
4. Rebuild Codespace container

## 🤝 **Contributing**

Feel free to suggest improvements or report issues with this configuration!

## 📄 **License**

MIT License - Feel free to use and modify as needed.

---

**Happy Coding!** 🚀✨
