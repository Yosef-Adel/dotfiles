#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "fzf could not be found. Please install fzf to use this script."
    exit 1
fi

# Define programming languages, core utilities, and DevOps tools
languages=$(echo "mongodb express angular react nodejs golang c cpp typescript python javascript lua java rust kotlin ruby php swift scala clojure" | tr " " "\n")
core_utils=$(echo "tar find xargs sed awk git docker kubectl jq curl wget grep" | tr " " "\n")  # Added more core utilities
devops_tools=$(echo "terraform ansible chef puppet helm istio prometheus grafana elasticsearch logstash kibana filebeat telegraf influxdb kapacitor k6 consul vault nomad packer vagrant spinnaker argo-cd argo-workflows jenkins teamcity circleci travisci github-actions gitlab-ci" | tr " " "\n")

# Combine all options
options=$(echo -e "$languages\n$core_utils\n$devops_tools")

# Use fzf to select an option
selected=$(echo "$options" | fzf --prompt="Select a language, utility, or DevOps tool: ")

# Prompt for query
read -p "Query: " query

# Check if selected is empty
if [ -z "$selected" ]; then
    echo "No selection made. Exiting."
    exit 1
fi

# Open a new tmux window with the appropriate query to cht.sh
if echo "$languages" | grep -qs "$selected"; then
    tmux new-window bash -c "curl -s cht.sh/$selected/$(echo "$query" | tr ' ' '+') | less"
else
    tmux new-window bash -c "curl -s cht.sh/$selected~$query | less"
fi
