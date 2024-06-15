#!/bin/bash
#
languages=$(echo "mongodb express angular react nodejs golang c cpp typescript python javascript lua java" | tr " " "\n")
core_Utils=$(echo "find xargs sed awk git docker" | tr " " "\n")  # Added Git and Docker

selected=$(echo -e "$languages\n$core_Utils" | fzf)
# if not found it wil be empty use the query as your input

read -p "Query: " query

if echo "$languages" | grep -qs "$selected"; then
    tmux new-window bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
    tmux new-window bash -c "curl cht.sh/$selected~$query | less"
fi

