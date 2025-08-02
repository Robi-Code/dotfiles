# PowerShell Environment Validation Script
# This script validates that PowerShell and oh-my-posh are configured correctly

# Colors for output
$Colors = @{
    Red     = "`e[31m"
    Green   = "`e[32m"
    Yellow  = "`e[33m"
    Blue    = "`e[34m"
    Magenta = "`e[35m"
    Cyan    = "`e[36m"
    White   = "`e[37m"
    Reset   = "`e[0m"
}

# Counters
$Script:PassCount = 0
$Script:FailCount = 0
$Script:WarnCount = 0

function Write-TestResult {
    param(
        [string]$Test,
        [string]$Status,
        [string]$Message = ""
    )
    
    switch ($Status) {
        "PASS" { 
            Write-Host "$($Colors.Green)✅ PASS:$($Colors.Reset) $Test" 
            if ($Message) { Write-Host "   $Message" -ForegroundColor Gray }
            $Script:PassCount++
        }
        "FAIL" { 
            Write-Host "$($Colors.Red)❌ FAIL:$($Colors.Reset) $Test" 
            if ($Message) { Write-Host "   $Message" -ForegroundColor Gray }
            $Script:FailCount++
        }
        "WARN" { 
            Write-Host "$($Colors.Yellow)⚠️  WARN:$($Colors.Reset) $Test" 
            if ($Message) { Write-Host "   $Message" -ForegroundColor Gray }
            $Script:WarnCount++
        }
        "INFO" { 
            Write-Host "$($Colors.Blue)ℹ️  INFO:$($Colors.Reset) $Test" 
            if ($Message) { Write-Host "   $Message" -ForegroundColor Gray }
        }
    }
}

Write-Host ""
Write-Host "$($Colors.Cyan)🔍 PowerShell Environment Validation$($Colors.Reset)"
Write-Host "========================================"

# Test PowerShell version
Write-Host ""
Write-Host "$($Colors.Blue)🔧 Checking PowerShell Installation...$($Colors.Reset)"
$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -ge 7) {
    Write-TestResult "PowerShell Version" "PASS" "Version: $($psVersion.ToString())"
} else {
    Write-TestResult "PowerShell Version" "WARN" "Version: $($psVersion.ToString()) - Consider upgrading to PowerShell 7+"
}

# Test Oh My Posh
Write-Host ""
Write-Host "$($Colors.Blue)🎨 Checking Oh My Posh...$($Colors.Reset)"
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $ompVersion = (oh-my-posh version)
    Write-TestResult "Oh My Posh Installation" "PASS" "Version: $ompVersion"
    
    # Check if theme is loaded
    if ($env:POSH_THEME) {
        Write-TestResult "Oh My Posh Theme" "PASS" "Theme: $env:POSH_THEME"
    } else {
        Write-TestResult "Oh My Posh Theme" "WARN" "Theme not detected in environment"
    }
} else {
    Write-TestResult "Oh My Posh Installation" "FAIL" "Oh My Posh not found in PATH"
}

# Test PowerShell Modules
Write-Host ""
Write-Host "$($Colors.Blue)📚 Checking PowerShell Modules...$($Colors.Reset)"

$RequiredModules = @(
    @{ Name = "PSReadLine"; MinVersion = "2.0" },
    @{ Name = "Terminal-Icons"; MinVersion = "0.1" },
    @{ Name = "z"; MinVersion = "1.0" },
    @{ Name = "posh-git"; MinVersion = "1.0" }
)

foreach ($Module in $RequiredModules) {
    $installedModule = Get-Module -ListAvailable -Name $Module.Name | Sort-Object Version -Descending | Select-Object -First 1
    if ($installedModule) {
        if ($installedModule.Version -ge [version]$Module.MinVersion) {
            Write-TestResult "$($Module.Name) Module" "PASS" "Version: $($installedModule.Version)"
        } else {
            Write-TestResult "$($Module.Name) Module" "WARN" "Version: $($installedModule.Version) - Update recommended"
        }
    } else {
        Write-TestResult "$($Module.Name) Module" "FAIL" "Module not installed"
    }
}

# Test Profile
Write-Host ""
Write-Host "$($Colors.Blue)⚙️  Checking PowerShell Profile...$($Colors.Reset)"
if (Test-Path $PROFILE) {
    Write-TestResult "Profile File" "PASS" "Location: $PROFILE"
    
    # Check profile content
    $profileContent = Get-Content $PROFILE -Raw
    
    $checks = @(
        @{ Name = "Oh My Posh Initialization"; Pattern = "oh-my-posh.*init" },
        @{ Name = "PSReadLine Configuration"; Pattern = "PSReadLine" },
        @{ Name = "Custom Functions"; Pattern = "function.*gs|function.*ga" },
        @{ Name = "Terminal Icons"; Pattern = "Terminal-Icons" }
    )
    
    foreach ($check in $checks) {
        if ($profileContent -match $check.Pattern) {
            Write-TestResult $check.Name "PASS" "Found in profile"
        } else {
            Write-TestResult $check.Name "WARN" "Not found in profile"
        }
    }
} else {
    Write-TestResult "Profile File" "FAIL" "Profile not found at $PROFILE"
}

# Test Custom Functions
Write-Host ""
Write-Host "$($Colors.Blue)🔧 Checking Custom Functions...$($Colors.Reset)"

$CustomFunctions = @("gs", "ga", "gc", "gp", "nrd", "nrs", "ll", "..")
foreach ($func in $CustomFunctions) {
    if (Get-Command $func -ErrorAction SilentlyContinue) {
        Write-TestResult "Function: $func" "PASS" "Available"
    } else {
        Write-TestResult "Function: $func" "WARN" "Not available"
    }
}

# Test Development Tools
Write-Host ""
Write-Host "$($Colors.Blue)🛠 Checking Development Tools...$($Colors.Reset)"

$DevTools = @(
    @{ Name = "git"; Command = "git" },
    @{ Name = "node"; Command = "node" },
    @{ Name = "npm"; Command = "npm" },
    @{ Name = "code"; Command = "code" }
)

foreach ($tool in $DevTools) {
    if (Get-Command $tool.Command -ErrorAction SilentlyContinue) {
        $version = switch ($tool.Command) {
            "git" { (git --version) -replace "git version " }
            "node" { node --version }
            "npm" { npm --version }
            "code" { "VS Code CLI available" }
            default { "Available" }
        }
        Write-TestResult $tool.Name "PASS" "Version: $version"
    } else {
        Write-TestResult $tool.Name "FAIL" "$($tool.Command) not found"
    }
}

# Test Terminal Features
Write-Host ""
Write-Host "$($Colors.Blue)💻 Checking Terminal Features...$($Colors.Reset)"

# Test PSReadLine predictions
try {
    $psReadLineOptions = Get-PSReadLineOption
    if ($psReadLineOptions.PredictionSource -ne "None") {
        Write-TestResult "PSReadLine Predictions" "PASS" "Source: $($psReadLineOptions.PredictionSource)"
    } else {
        Write-TestResult "PSReadLine Predictions" "WARN" "Predictions not enabled"
    }
} catch {
    Write-TestResult "PSReadLine Predictions" "FAIL" "Could not check PSReadLine options"
}

# Test color support
if ($Host.UI.SupportsVirtualTerminal) {
    Write-TestResult "Terminal Colors" "PASS" "ANSI colors supported"
} else {
    Write-TestResult "Terminal Colors" "WARN" "Limited color support"
}

# Summary
Write-Host ""
Write-Host "$($Colors.Cyan)📊 Validation Summary$($Colors.Reset)"
Write-Host "====================="
Write-Host "$($Colors.Green)✅ Passed: $Script:PassCount$($Colors.Reset)"
Write-Host "$($Colors.Yellow)⚠️  Warnings: $Script:WarnCount$($Colors.Reset)"
Write-Host "$($Colors.Red)❌ Failed: $Script:FailCount$($Colors.Reset)"

Write-Host ""
if ($Script:FailCount -eq 0) {
    Write-Host "$($Colors.Green)🎉 PowerShell environment validation completed successfully!$($Colors.Reset)"
    Write-Host "Your GitHub Codespace PowerShell environment is properly configured."
} else {
    Write-Host "$($Colors.Red)❌ PowerShell environment validation found issues.$($Colors.Reset)"
    Write-Host "Please review the failed checks above."
}

Write-Host ""
Write-Host "$($Colors.Cyan)🔧 Quick fixes:$($Colors.Reset)"
Write-Host "• Run the devcontainer setup script to install missing components"
Write-Host "• Restart your terminal to reload the profile"
Write-Host "• Check that Oh My Posh is in your PATH"

# Test some functions to demonstrate they work
Write-Host ""
Write-Host "$($Colors.Cyan)🎮 Testing Custom Functions:$($Colors.Reset)"
Write-Host "• Current location: $(Get-Location)"
if (Get-Command gs -ErrorAction SilentlyContinue) {
    Write-Host "• Git status shortcut 'gs' is available"
}
if (Get-Command Get-Weather -ErrorAction SilentlyContinue) {
    Write-Host "• Weather function 'Get-Weather' is available"
}

Write-Host ""
Write-Host "$($Colors.Green)Validation complete! Happy coding! 🚀$($Colors.Reset)"
