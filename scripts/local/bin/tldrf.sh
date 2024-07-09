# Define the tldr command
tldr_command="tldr --list | fzf --preview 'tldr {1} | bat --color=always --paging=never' --preview-window=right,70% | xargs tldr"

# Execute the tldr command in a new tmux window
tmux new-window bash -c "$tldr_command | less"

