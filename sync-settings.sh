#!/bin/bash

# Sync VS Code settings script
# This script helps synchronize your local VS Code settings with this dotfiles repo

VSCODE_USER_DIR="$HOME/.config/Code/User"
DOTFILES_CONFIG_DIR="$(pwd)/.config/Code/User"

echo "🔄 VS Code Settings Sync Script"
echo "================================"

# Function to backup existing settings
backup_settings() {
    if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
        echo "📦 Creating backup of existing settings..."
        cp "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✅ Backup created"
    fi
    
    if [ -f "$VSCODE_USER_DIR/keybindings.json" ]; then
        echo "📦 Creating backup of existing keybindings..."
        cp "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✅ Backup created"
    fi
}

# Function to apply settings from dotfiles
apply_from_dotfiles() {
    echo "📥 Applying settings from dotfiles..."
    
    # Ensure VS Code User directory exists
    mkdir -p "$VSCODE_USER_DIR"
    
    # Copy settings
    if [ -f "$DOTFILES_CONFIG_DIR/settings.json" ]; then
        cp "$DOTFILES_CONFIG_DIR/settings.json" "$VSCODE_USER_DIR/"
        echo "✅ Applied settings.json"
    else
        echo "❌ settings.json not found in dotfiles"
    fi
    
    # Copy keybindings
    if [ -f "$DOTFILES_CONFIG_DIR/keybindings.json" ]; then
        cp "$DOTFILES_CONFIG_DIR/keybindings.json" "$VSCODE_USER_DIR/"
        echo "✅ Applied keybindings.json"
    else
        echo "❌ keybindings.json not found in dotfiles"
    fi
}

# Function to export current settings to dotfiles
export_to_dotfiles() {
    echo "📤 Exporting current settings to dotfiles..."
    
    # Ensure dotfiles config directory exists
    mkdir -p "$DOTFILES_CONFIG_DIR"
    
    # Copy settings
    if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
        cp "$VSCODE_USER_DIR/settings.json" "$DOTFILES_CONFIG_DIR/"
        echo "✅ Exported settings.json"
    else
        echo "❌ settings.json not found in VS Code"
    fi
    
    # Copy keybindings
    if [ -f "$VSCODE_USER_DIR/keybindings.json" ]; then
        cp "$VSCODE_USER_DIR/keybindings.json" "$DOTFILES_CONFIG_DIR/"
        echo "✅ Exported keybindings.json"
    else
        echo "❌ keybindings.json not found in VS Code"
    fi
    
    # Update extensions list
    echo "📋 Updating extensions list..."
    code --list-extensions > extensions-list.txt
    echo "✅ Extensions list updated"
}

# Function to compare settings
compare_settings() {
    echo "🔍 Comparing current settings with dotfiles..."
    
    if [ -f "$VSCODE_USER_DIR/settings.json" ] && [ -f "$DOTFILES_CONFIG_DIR/settings.json" ]; then
        if diff -q "$VSCODE_USER_DIR/settings.json" "$DOTFILES_CONFIG_DIR/settings.json" > /dev/null; then
            echo "✅ settings.json - No differences"
        else
            echo "⚠️  settings.json - Differences found"
            echo "Run 'diff $VSCODE_USER_DIR/settings.json $DOTFILES_CONFIG_DIR/settings.json' to see details"
        fi
    else
        echo "❌ Cannot compare settings.json - one or both files missing"
    fi
    
    if [ -f "$VSCODE_USER_DIR/keybindings.json" ] && [ -f "$DOTFILES_CONFIG_DIR/keybindings.json" ]; then
        if diff -q "$VSCODE_USER_DIR/keybindings.json" "$DOTFILES_CONFIG_DIR/keybindings.json" > /dev/null; then
            echo "✅ keybindings.json - No differences"
        else
            echo "⚠️  keybindings.json - Differences found"
            echo "Run 'diff $VSCODE_USER_DIR/keybindings.json $DOTFILES_CONFIG_DIR/keybindings.json' to see details"
        fi
    else
        echo "❌ Cannot compare keybindings.json - one or both files missing"
    fi
}

# Main menu
case "$1" in
    "apply")
        backup_settings
        apply_from_dotfiles
        echo "🎉 Settings applied from dotfiles!"
        ;;
    "export")
        export_to_dotfiles
        echo "🎉 Settings exported to dotfiles!"
        ;;
    "compare")
        compare_settings
        ;;
    "backup")
        backup_settings
        echo "🎉 Settings backed up!"
        ;;
    *)
        echo "Usage: $0 {apply|export|compare|backup}"
        echo ""
        echo "Commands:"
        echo "  apply   - Apply settings from dotfiles to VS Code (with backup)"
        echo "  export  - Export current VS Code settings to dotfiles"
        echo "  compare - Compare current settings with dotfiles"
        echo "  backup  - Create backup of current settings"
        echo ""
        echo "Examples:"
        echo "  $0 apply     # Apply dotfiles settings to VS Code"
        echo "  $0 export    # Save current VS Code settings to dotfiles"
        echo "  $0 compare   # Check differences between current and dotfiles"
        ;;
esac
