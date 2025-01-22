#!/bin/bash

# Check if required commands exist
for cmd in fzf gum go; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd could not be found. Please install $cmd to use this script."
        exit 1
    fi
done

# Function to get all standard Go packages
get_std_packages() {
    go list std | grep -v "vendor" | grep -v "internal"
}

# Function to get package documentation
get_package_doc() {
    local package=$1
    go doc "$package" 2>/dev/null
}

# Function to get all exported functions/types from a package
get_package_symbols() {
    local package=$1
    # Extract only the symbol names without the full declaration
    go doc "$package" | grep -E "^(func|type|const|var)" | awk '{print $2}' | cut -d'(' -f1
}

# Main menu function
main_menu() {
    local choice
    choice=$(gum choose "Search Package" "List All Packages" "Exit")
    case "$choice" in
        "Search Package")
            search_packages
            ;;
        "List All Packages")
            browse_packages
            ;;
        "Exit")
            exit 0
            ;;
    esac
}

# Function to search packages
search_packages() {
    local selected_package
    selected_package=$(get_std_packages | fzf \
        --prompt="Select a Go package: " \
        --preview="go doc {} 2>/dev/null | head -n 20" \
        --preview-window="right:60%:wrap")
    if [ -n "$selected_package" ]; then
        show_package_details "$selected_package"
    fi
}

# Function to browse all packages
browse_packages() {
    local packages
    packages=$(get_std_packages)
    echo "$packages" | fzf \
        --prompt="Browse packages: " \
        --preview="go doc {} 2>/dev/null" \
        --preview-window="right:60%:wrap" \
        --bind="enter:execute(echo {} | xargs go doc | less)"
}

# Function to show package details and allow symbol selection
show_package_details() {
    local package=$1
    local choice
    
    # Show package overview
    clear
    echo "Package: $package"
    echo "----------------"
    get_package_doc "$package" | head -n 5
    echo "----------------"
    
    choice=$(gum choose "View Full Documentation" "Browse Functions/Types" "Back to Main Menu")
    case "$choice" in
        "View Full Documentation")
            get_package_doc "$package" | less
            main_menu
            ;;
        "Browse Functions/Types")
            browse_symbols "$package"
            ;;
        "Back to Main Menu")
            main_menu
            ;;
    esac
}

# Function to browse symbols within a package
browse_symbols() {
    local package=$1
    local selected_symbol
    
    selected_symbol=$(get_package_symbols "$package" | fzf \
        --prompt="Select a symbol from $package: " \
        --preview="go doc '$package.$1'" \
        --preview-window="right:60%:wrap" \
        --bind="enter:execute(go doc '$package.{}' | less)")
    
    if [ -n "$selected_symbol" ]; then
        main_menu
    fi
}

# Start the script
clear
echo "Go Documentation Browser"
echo "----------------------"
main_menu
