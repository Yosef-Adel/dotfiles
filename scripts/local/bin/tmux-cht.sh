#!/bin/bash

# Simple documentation system - like Vim's :help
# All docs stored locally in ~/dotfiles/docs/

# Check if required tools are installed
for cmd in fzf; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is required. Install it with: brew install $cmd"
        exit 1
    fi
done

# Docs directory
DOCS_DIR="${HOME}/dotfiles/docs"

# Setup history file
HISTORY_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-cht-history"
mkdir -p "$(dirname "$HISTORY_FILE")"
touch "$HISTORY_FILE"

# Build list of available docs from directory
build_docs_list() {
    local docs=""
    for file in "$DOCS_DIR"/*.md; do
        if [ -f "$file" ] && [ "$(basename "$file")" != "README.md" ]; then
            local name=$(basename "$file" .md)
            docs="${docs}${name}:${file}\n"
        fi
    done
    echo -e "$docs"
}

# Get documentation source for a tool
get_doc_source() {
    local tool="$1"
    build_docs_list | grep "^$tool:" | cut -d: -f2-
}

# Main loop
while true; do
    # Build options list from actual files in docs directory
    available_docs=$(build_docs_list)
    options=$(echo -e "$available_docs" | cut -d: -f1 | sort)

    # Use fzf for tool selection
    selected=$(echo -e "$options" | fzf \
        --ansi \
        --prompt="📚 Select docs: " \
        --height=100% \
        --border=rounded \
        --margin=1 \
        --padding=1 \
        --header="Select documentation (Esc to exit)" \
        --color="border:#589ed7,header:#589ed7,prompt:#589ed7")

    # Exit if no selection
    if [ -z "$selected" ]; then
        exit 0
    fi

    # Get the documentation source
    source=$(get_doc_source "$selected")

    if [ -z "$source" ]; then
        echo "Error: No documentation found for $selected"
        sleep 2
        continue
    fi

    # Open markdown file (read-only mode)
    if command -v nvim &> /dev/null; then
        nvim -R "$source"
    elif command -v vim &> /dev/null; then
        vim -R "$source"
    else
        less -RSX "$source"
    fi
done
