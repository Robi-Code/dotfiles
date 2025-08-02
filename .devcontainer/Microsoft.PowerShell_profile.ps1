# PowerShell Profile for GitHub Codespaces
# Comprehensive setup to match local PowerShell environment with oh-my-posh

#region Oh My Posh Setup
# Initialize Oh My Posh with custom development theme
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    # Use custom development theme
    $customTheme = "$env:HOME/.config/powershell/robi-dev-theme.omp.json"
    if (Test-Path $customTheme) {
        oh-my-posh init pwsh --config $customTheme | Invoke-Expression
    } else {
        # Fallback to popular theme if custom theme not found
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/agnoster.omp.json" | Invoke-Expression
    }
    
    # Alternative popular themes you can switch to:
    # oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/paradox.omp.json" | Invoke-Expression
    # oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression
    # oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/atomic.omp.json" | Invoke-Expression
} else {
    Write-Host "Oh My Posh not found. Installing..." -ForegroundColor Yellow
}
#endregion

#region PSReadLine Configuration
# Enhanced command line editing and history
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    
    # Set the prediction source to history and plugin
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    
    # Set the prediction view style
    Set-PSReadLineOption -PredictionViewStyle ListView
    
    # Enable syntax highlighting
    Set-PSReadLineOption -Colors @{
        Command   = 'Green'
        Parameter = 'Gray'
        Operator  = 'DarkCyan'
        Variable  = 'DarkGreen'
        String    = 'Yellow'
        Number    = 'Red'
        Type      = 'Cyan'
        Comment   = 'DarkGray'
    }
    
    # Key bindings for better navigation
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Key Alt+d -Function DeleteWord
    Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
    Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    
    # Enable intelligent history search
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory
}
#endregion

#region Terminal Icons
# Beautiful file and folder icons in terminal
if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Import-Module Terminal-Icons
}
#endregion

#region Z Directory Jumper
# Quick directory navigation
if (Get-Module -ListAvailable -Name z) {
    Import-Module z
}
#endregion

#region Utilities and Functions
# Enhanced ls command with colors and icons
function ll { Get-ChildItem -Force @args | Format-Table -AutoSize }
function la { Get-ChildItem -Force -Hidden @args }
function ls { Get-ChildItem @args }

# Navigation shortcuts
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }
function ..... { Set-Location ../../../.. }

# Git shortcuts
function gs { git status @args }
function ga { git add @args }
function gc { git commit @args }
function gp { git push @args }
function gl { git log --oneline @args }
function gd { git diff @args }
function gb { git branch @args }
function gco { git checkout @args }

# Common development shortcuts
function nrd { npm run dev @args }
function nrs { npm run start @args }
function nrb { npm run build @args }
function nrt { npm run test @args }
function ni { npm install @args }

# Docker shortcuts
function dps { docker ps @args }
function di { docker images @args }
function dc { docker-compose @args }

# System information
function Get-Weather { 
    param([string]$City = "")
    if ($City) {
        Invoke-RestMethod "http://wttr.in/$City"
    } else {
        Invoke-RestMethod "http://wttr.in"
    }
}

# Quick file editing
function Edit-Profile { code $PROFILE }
function Reload-Profile { . $PROFILE }

# System utilities
function Get-DiskUsage { Get-PSDrive | Where-Object {$_.Used -gt 0} | Select-Object Name, @{Name="Size(GB)";Expression={[math]::round($_.Used/1GB,2)}}, @{Name="Free(GB)";Expression={[math]::round($_.Free/1GB,2)}} }

# Process management
function Get-ProcessByName { 
    param([string]$Name)
    Get-Process | Where-Object {$_.ProcessName -like "*$Name*"}
}

# Network utilities
function Get-PublicIP { 
    try {
        (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content
    } catch {
        Write-Error "Could not retrieve public IP address"
    }
}

# JSON formatting
function Format-Json {
    param([Parameter(ValueFromPipeline)]$InputObject)
    $InputObject | ConvertTo-Json -Depth 10 | Out-String
}

# Base64 encoding/decoding
function ConvertTo-Base64 {
    param([string]$Text)
    [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($Text))
}

function ConvertFrom-Base64 {
    param([string]$Base64)
    [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($Base64))
}
#endregion

#region Development Environment
# Set environment variables for development
$env:EDITOR = "code"
$env:VISUAL = "code"

# PowerShell execution policy for scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue

# History configuration
$MaximumHistoryCount = 10000
#endregion

#region Auto-completion
# Enable tab completion for common tools
if (Get-Command git -ErrorAction SilentlyContinue) {
    # Git completion is usually built-in with newer PowerShell versions
    Register-ArgumentCompleter -Native -CommandName git -ScriptBlock {
        param($commandName, $wordToComplete, $cursorPosition)
        $Local:word = $wordToComplete
        $Local:cmd = $commandName
        git completion -- $word
    }
}

# Docker completion
if (Get-Command docker -ErrorAction SilentlyContinue) {
    Register-ArgumentCompleter -Native -CommandName docker -ScriptBlock {
        param($commandName, $wordToComplete, $cursorPosition)
        docker completion powershell | Out-String | Invoke-Expression
    }
}
#endregion

#region Welcome Message
Write-Host ""
Write-Host "🚀 " -ForegroundColor Blue -NoNewline
Write-Host "PowerShell Profile Loaded! " -ForegroundColor Green -NoNewline
Write-Host "Welcome to your GitHub Codespace" -ForegroundColor Cyan

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    Write-Host "✨ Oh My Posh: " -ForegroundColor Yellow -NoNewline
    Write-Host "Enabled" -ForegroundColor Green
} else {
    Write-Host "⚠️  Oh My Posh: " -ForegroundColor Yellow -NoNewline
    Write-Host "Not installed" -ForegroundColor Red
}

if (Get-Module -ListAvailable -Name PSReadLine) {
    Write-Host "📚 PSReadLine: " -ForegroundColor Blue -NoNewline
    Write-Host "Enabled with IntelliSense" -ForegroundColor Green
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Write-Host "🎨 Terminal Icons: " -ForegroundColor Magenta -NoNewline
    Write-Host "Enabled" -ForegroundColor Green
}

Write-Host ""
Write-Host "💡 Quick tips:" -ForegroundColor Cyan
Write-Host "   • Type 'help' for PowerShell help" -ForegroundColor Gray
Write-Host "   • Use 'gs' for git status, 'ga' for git add" -ForegroundColor Gray
Write-Host "   • Use 'nrd' for npm run dev, 'ni' for npm install" -ForegroundColor Gray
Write-Host "   • Use 'Edit-Profile' to edit this profile" -ForegroundColor Gray
Write-Host "   • Use 'Get-Weather [city]' for weather info" -ForegroundColor Gray
Write-Host ""
#endregion
