#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is required. Install it with: brew install fzf (or your package manager)"
    exit 1
fi

# Define programming languages, core utilities, and DevOps tools with headers
languages="golang\nc\ncpp\ntypescript\npython\njavascript\nrust\njava\nruby\nphp\nswift\nkotlin"
core_utils="docker\nkubectl\ngit\ntar\nfind\nxargs\nsed\nawk\njq\ncurl\nwget\ngrep"
devops_tools="terraform\nansible\nhelm\nprometheus\ngrafana\nargo-cd\njenkins\ngithub-actions\ngitlab-ci"

# Combine with category headers
options=$(echo -e "# Languages\n$languages\n# Core Utils\n$core_utils\n# DevOps\n$devops_tools")

# Use fzf with better UI
selected=$(echo -e "$options" | grep -v "^#" | fzf \
    --prompt="🔍 Select tool: " \
    --height=40% \
    --border \
    --preview="echo 'cht.sh/{}'" \
    --preview-window=up:1)

# Exit if no selection
if [ -z "$selected" ]; then
    exit 0
fi

# Prompt for query with the selected tool shown
read -p "Query for $selected: " query

# Exit if no query
if [ -z "$query" ]; then
    exit 0
fi

# URL encode the query
query_encoded=$(echo "$query" | tr ' ' '+')

# Check if we're in a tmux session
if [ -n "$TMUX" ]; then
    # Open in new tmux window
    tmux new-window bash -c "curl -s cht.sh/$selected/$query_encoded | less -R"
else
    # Fallback: just open in current terminal
    curl -s "cht.sh/$selected/$query_encoded" | less -R
fi
