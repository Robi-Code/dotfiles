# 🚀 PowerShell + Oh My Posh Configuration for GitHub Codespaces

This configuration sets up a complete PowerShell environment in GitHub Codespaces that matches a modern local development setup.

## 🎯 What's Included

### 🔧 **PowerShell Core**
- Latest PowerShell 7+ installation
- PowerShell set as default terminal in VS Code
- Custom profile with development-focused configuration

### 🎨 **Oh My Posh Theme**
- Custom "robi-dev-theme" with development indicators
- Git status, branch info, and stash count
- Node.js, Python, .NET, Docker, and Kubernetes context
- Execution time display for long-running commands
- Beautiful powerline segments with proper icons

### 📚 **Enhanced Modules**
- **PSReadLine**: IntelliSense with history and plugin predictions
- **Terminal-Icons**: Beautiful file and folder icons
- **z**: Smart directory jumping based on frequency
- **posh-git**: Enhanced git integration

### ⚡ **Development Features**
- Auto-completion for git, docker, and other tools
- Custom aliases for common development tasks
- Syntax highlighting with custom colors
- Smart history search and navigation

## 📁 File Structure

```
.devcontainer/
├── Microsoft.PowerShell_profile.ps1    # Main PowerShell profile
├── robi-dev-theme.omp.json             # Custom Oh My Posh theme
├── Test-PowerShellEnvironment.ps1      # Validation script
└── setup.sh                           # Installation script (updated)
```

## 🎨 Theme Features

The custom `robi-dev-theme` includes:

### **Left Side Segments:**
1. **Session**: Username@Hostname with purple background
2. **Path**: Current directory with folder icon
3. **Git**: Branch status, changes, stash count with dynamic colors
4. **Node.js**: Version display when in Node projects
5. **Python**: Version display when in Python projects  
6. **Docker**: Current Docker context
7. **Kubernetes**: Current kubectl context and namespace
8. **Execution Time**: Shows duration for commands taking >5 seconds

### **Right Side Segments:**
1. **Shell**: Current shell (PowerShell indicator)
2. **Time**: Current time in 24-hour format

### **Prompt Line:**
- Clean single-line prompt with status indicator
- Changes color to pink on command errors

## ⚙️ PowerShell Profile Features

### **Git Shortcuts:**
```powershell
gs      # git status
ga      # git add
gc      # git commit  
gp      # git push
gl      # git log --oneline
gd      # git diff
gb      # git branch
gco     # git checkout
```

### **NPM Shortcuts:**
```powershell
nrd     # npm run dev
nrs     # npm run start
nrb     # npm run build
nrt     # npm run test
ni      # npm install
```

### **Navigation:**
```powershell
ll      # Enhanced ls with formatting
la      # List all including hidden
..      # cd ..
...     # cd ../..
....    # cd ../../..
```

### **Docker Shortcuts:**
```powershell
dps     # docker ps
di      # docker images
dc      # docker-compose
```

### **Utility Functions:**
```powershell
Get-Weather [city]          # Weather information
Get-PublicIP               # Your public IP address
Get-DiskUsage             # Disk space information
Format-Json               # Pretty print JSON
ConvertTo-Base64          # Base64 encoding
ConvertFrom-Base64        # Base64 decoding
Edit-Profile              # Edit PowerShell profile
Reload-Profile            # Reload PowerShell profile
```

## 🔧 PSReadLine Configuration

### **Prediction Features:**
- **History + Plugin**: Smart suggestions based on history and commands
- **ListView**: Multi-line prediction display
- **Syntax Highlighting**: Color-coded commands and parameters

### **Key Bindings:**
- **Tab**: Menu completion
- **Ctrl+D**: Delete character
- **Ctrl+W**: Delete word backward
- **Alt+D**: Delete word forward
- **Ctrl+←/→**: Word navigation
- **↑/↓**: History search
- **Ctrl+R**: Reverse history search

### **Color Scheme:**
- **Commands**: Green
- **Parameters**: Gray  
- **Operators**: Dark Cyan
- **Variables**: Dark Green
- **Strings**: Yellow
- **Numbers**: Red
- **Types**: Cyan
- **Comments**: Dark Gray

## 🚀 Installation & Setup

### **Automatic Setup (Recommended):**
The devcontainer automatically installs and configures everything when you create a new Codespace.

### **Manual Validation:**
```powershell
# Run the validation script
pwsh /workspaces/dotfiles/.devcontainer/Test-PowerShellEnvironment.ps1
```

### **Manual Installation (if needed):**
```bash
# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Install PowerShell modules
pwsh -c "Install-Module PSReadLine,Terminal-Icons,z,posh-git -Force"

# Copy profile and theme
cp .devcontainer/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/
cp .devcontainer/robi-dev-theme.omp.json ~/.config/powershell/
```

## 🎯 VS Code Integration

### **Terminal Settings:**
```json
{
    "terminal.integrated.defaultProfile.linux": "pwsh",
    "terminal.integrated.profiles.linux": {
        "pwsh": {
            "path": "pwsh",
            "args": ["-NoLogo"],
            "icon": "terminal-powershell"
        }
    }
}
```

### **PowerShell Extension Settings:**
- PowerShell extension for syntax highlighting
- Integrated console disabled (uses terminal instead)
- Custom PowerShell path configuration

## 🔍 Troubleshooting

### **Profile Not Loading:**
```powershell
# Check profile path
$PROFILE

# Test profile exists
Test-Path $PROFILE

# Reload profile manually
. $PROFILE
```

### **Oh My Posh Not Working:**
```bash  
# Check Oh My Posh installation
which oh-my-posh

# Verify theme file
ls ~/.config/powershell/robi-dev-theme.omp.json

# Test theme manually
oh-my-posh init pwsh --config ~/.config/powershell/robi-dev-theme.omp.json
```

### **Modules Not Loading:**
```powershell
# Check installed modules
Get-Module -ListAvailable

# Install missing modules
Install-Module PSReadLine,Terminal-Icons,z,posh-git -Force -Scope CurrentUser
```

### **Performance Issues:**
```powershell
# Measure profile load time
Measure-Command { . $PROFILE }

# Disable specific modules if needed
# Comment out Import-Module lines in profile
```

## 🎨 Customizing Your Setup

### **Change Oh My Posh Theme:**
```powershell
# Edit your profile
code $PROFILE

# Change the theme line to:
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/[theme-name].omp.json" | Invoke-Expression
```

### **Popular Themes:**
- `agnoster.omp.json` - Classic minimal
- `powerlevel10k_rainbow.omp.json` - Colorful and detailed  
- `atomic.omp.json` - Clean and modern
- `paradox.omp.json` - Balanced information

### **Add Custom Functions:**
```powershell
# Add to your profile
function MyFunction {
    param([string]$Parameter)
    # Your code here
}
```

## 📊 Validation Results

Run the validation script to check your setup:
```powershell
pwsh .devcontainer/Test-PowerShellEnvironment.ps1
```

Expected results:
- ✅ PowerShell 7+ installed
- ✅ Oh My Posh with custom theme  
- ✅ All required modules installed
- ✅ Profile loaded with functions
- ✅ Development tools available
- ✅ PSReadLine predictions working

## 🚀 Benefits

### **Productivity:**
- ⚡ Fast directory navigation with `z`
- 🔍 Intelligent command suggestions
- 📋 Comprehensive git integration
- 🎯 One-letter shortcuts for common tasks

### **Visual:**
- 🎨 Beautiful themed prompt
- 🌈 Syntax highlighting
- 📁 File type icons
- 📊 Rich git status information

### **Developer Experience:**
- 🔄 Same experience as local setup
- 🛠 All development tools integrated
- ⚙️ Automatic environment detection
- 📚 Helpful utility functions

---

**Happy PowerShell coding in your GitHub Codespace! 🚀✨**
