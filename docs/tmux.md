# tmux Reference

Quick reference for tmux (terminal multiplexer). Use `/` to search in vim.

## Table of Contents

- [tmux Reference](#tmux-reference)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Sessions](#sessions)
    - [Create Session](#create-session)
    - [List Sessions](#list-sessions)
    - [Attach Session](#attach-session)
    - [Detach Session](#detach-session)
    - [Kill Session](#kill-session)
    - [Rename Session](#rename-session)
  - [Windows](#windows)
    - [Create Window](#create-window)
    - [Switch Window](#switch-window)
    - [Rename Window](#rename-window)
    - [Kill Window](#kill-window)
  - [Panes](#panes)
    - [Split Pane](#split-pane)
    - [Navigate Panes](#navigate-panes)
    - [Resize Pane](#resize-pane)
    - [Close Pane](#close-pane)
    - [Zoom Pane](#zoom-pane)
  - [Keyboard Shortcuts](#keyboard-shortcuts)
    - [Session Commands](#session-commands)
    - [Window Commands](#window-commands)
    - [Pane Commands](#pane-commands)
    - [Copy Mode](#copy-mode)
  - [Configuration](#configuration)
    - [Basic Configuration](#basic-configuration)
    - [Key Bindings](#key-bindings)
    - [Colors \& Styling](#colors--styling)
  - [Commands](#commands)
  - [Plugins](#plugins)
  - [Tips \& Tricks](#tips--tricks)

## Installation

Install tmux.

```bash
# macOS (Homebrew)
brew install tmux

# Ubuntu/Debian
sudo apt-get install tmux

# From source
git clone https://github.com/tmux/tmux.git
cd tmux
./configure && make
sudo make install

# Verify
tmux -V
```

## Sessions

### Create Session

```bash
# Create new session
tmux new-session -s myname

# Create named session
tmux new -s myproject

# Create detached session (doesn't attach)
tmux new-session -s myname -d

# Create session with initial command
tmux new-session -s myname -d "cd ~/project && vim"

# Shorthand
tmux new -s myname
tmux new -s myname -d
```

### List Sessions

```bash
# List sessions
tmux list-sessions
tmux ls

# In tmux, using prefix key
Ctrl-b s    # List sessions interactively
```

### Attach Session

```bash
# Attach to session
tmux attach-session -t myname
tmux attach -t myname
tmux a -t myname

# If already in tmux, switch
Ctrl-b s    # Select from list
Ctrl-b (    # Previous session
Ctrl-b )    # Next session
```

### Detach Session

```bash
# Detach from session
Ctrl-b d

# Keep session running in background
# Session remains active for re-attachment
```

### Kill Session

```bash
# Kill session
tmux kill-session -t myname

# Kill all sessions
tmux kill-server

# Kill all but current
Ctrl-b &
```

### Rename Session

```bash
# Rename session
tmux rename-session -t old_name new_name
tmux rename -t old new

# In tmux
Ctrl-b $    # Rename current session
```

## Windows

### Create Window

```bash
# Create new window
Ctrl-b c

# Create window with name
tmux new-window -t myname -n mywindow
```

### Switch Window

```bash
# Next window
Ctrl-b n

# Previous window
Ctrl-b p

# Select by number
Ctrl-b 0    # Window 0
Ctrl-b 1    # Window 1
Ctrl-b 9    # Window 9

# Select window
Ctrl-b w    # Interactive selector
```

### Rename Window

```bash
# Rename current window
Ctrl-b ,

# Set window name
tmux rename-window -t myname:0 newname
```

### Kill Window

```bash
# Kill current window
Ctrl-b &

# Close window (exit shell)
exit
```

## Panes

### Split Pane

```bash
# Split vertically (side-by-side)
Ctrl-b %

# Split horizontally (top-bottom)
Ctrl-b "

# Split with specific size
tmux split-window -h -p 30    # 30% width
```

### Navigate Panes

```bash
# Move to next pane
Ctrl-b o

# Move by direction
Ctrl-b Up / Down / Left / Right

# Cycle through panes
Ctrl-b {    # Previous pane
Ctrl-b }    # Next pane

# Select pane
Ctrl-b ;    # Last pane
Ctrl-b l    # Last pane (same as above)
```

### Resize Pane

```bash
# Increase pane size
Ctrl-b Ctrl-Up      # Increase height
Ctrl-b Ctrl-Down    # Decrease height
Ctrl-b Ctrl-Left    # Decrease width
Ctrl-b Ctrl-Right   # Increase width

# Hold Ctrl-b and use arrows multiple times
Ctrl-b Ctrl-Up Up Up Up

# Command line
tmux resize-pane -t myname:0.0 -x 100 -y 30
```

### Close Pane

```bash
# Kill current pane
Ctrl-b x

# Or simply exit
exit
```

### Zoom Pane

```bash
# Toggle zoom (fullscreen pane)
Ctrl-b z

# Zoom out
Ctrl-b z    # Toggle again
```

## Keyboard Shortcuts

### Session Commands

```
Ctrl-b $    Rename session
Ctrl-b d    Detach session
Ctrl-b s    Select session
Ctrl-b (    Previous session
Ctrl-b )    Next session
```

### Window Commands

```
Ctrl-b c    Create window
Ctrl-b n    Next window
Ctrl-b p    Previous window
Ctrl-b l    Last window
Ctrl-b 0-9  Select window by number
Ctrl-b w    Select window (interactive)
Ctrl-b ,    Rename window
Ctrl-b &    Kill window
```

### Pane Commands

```
Ctrl-b %    Split vertically
Ctrl-b "    Split horizontally
Ctrl-b o    Select next pane
Ctrl-b ;    Toggle last pane
Ctrl-b {    Swap pane left
Ctrl-b }    Swap pane right
Ctrl-b z    Zoom pane
Ctrl-b x    Kill pane
Ctrl-b !    Break pane into window
Ctrl-b j    Join pane
Ctrl-b :join-pane -s :0 -t :1   Join panes
```

### Copy Mode

```
Ctrl-b [    Enter copy mode (scroll)
q           Exit copy mode
Space       Start selection
Enter       Copy selection

Ctrl-b ]    Paste
Ctrl-b =    Choose buffer
Ctrl-b #    List buffers
```

Navigation in copy mode:

```
h/j/k/l     Vim-style movement
w/b         Word forward/backward
^/$         Line start/end
G           End of buffer
g           Start of buffer
/           Search down
?           Search up
n           Next match
N           Previous match
```

## Configuration

Configuration file: `~/.tmux.conf`

### Basic Configuration

```bash
# .tmux.conf

# Change prefix key
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Mouse support
set -g mouse on

# Scroll
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"

# Vi keybindings
setw -g mode-keys vi
bind -T copy-mode-vi 'v' send -X begin-selection
bind -T copy-mode-vi 'y' send -X copy-selection

# Emacs keybindings (default)
setw -g mode-keys emacs

# Base index (default 0)
set -g base-index 1
setw -g pane-base-index 1

# Window naming
setw -g automatic-rename on
set -g renumber-windows on

# Status bar
set -g status-position top
set -g status-left "#S"
set -g status-right "%H:%M %d-%b-%y"

# Colors
set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
```

### Key Bindings

```bash
# Remap split keys
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Vi-style pane movement
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5

# Swap panes
bind -n C-S-Left swap-window -t -1
bind -n C-S-Right swap-window -t +1

# Quick window selection
bind-key -n C-S-Right next-window
bind-key -n C-S-Left previous-window
```

### Colors & Styling

```bash
# Colors (256-color palette)
set -g status-bg colour236
set -g status-fg colour246
setw -g window-status-current-bg colour214
setw -g window-status-current-fg colour233

# Status line format
set -g status-left "#[fg=colour15,bg=colour27] #S #[default] "
set -g status-right "#[fg=colour246] %H:%M #[fg=colour252,bg=colour236] %d %b #[default]"

# Message style
set -g message-bg colour235
set -g message-fg colour245
```

## Commands

```bash
# Send command to pane
tmux send-keys -t session:window.pane "command" Enter

# List commands
tmux list-commands

# Show options
tmux show-options -g          # Global options
tmux show-window-options -g   # Window options

# Get option value
tmux show-options -g | grep status
```

## Plugins

Popular plugins via tpm (tmux plugin manager):

```bash
# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In .tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'          # Copy to clipboard
set -g @plugin 'tmux-plugins/tmux-resurrect'     # Save/restore sessions
set -g @plugin 'tmux-plugins/tmux-continuum'     # Auto-save
set -g @plugin 'tmux-plugins/tmux-pain-control'  # Better pane handling

run '~/.tmux/plugins/tpm/tpm'

# Install plugins
Ctrl-b I

# Update plugins
Ctrl-b U

# Uninstall plugins
Ctrl-b Alt-U
```

## Tips & Tricks

```bash
# Kill all tmux processes
tmux kill-server

# Capture pane content
tmux capture-pane -t myname:0 -p

# Capture and save to file
tmux capture-pane -t myname:0 -p > pane-contents.txt

# Create session with multiple windows
tmux new-session -s myname -n editor \
  -c ~/project && \
tmux new-window -t myname -n server && \
tmux new-window -t myname -n logs

# Attach to session from outside
tmux attach -t myname

# One-liner to create session with split panes
tmux new-session -d -s myname \
  -c ~/project && \
tmux split-window -t myname -h -c ~/project && \
tmux split-window -t myname -v -c ~/project && \
tmux attach -t myname

# SSH + tmux combo (keeps session alive)
ssh user@host -t "tmux new-session -s work -d && tmux attach -t work"

# List all keybindings
tmux list-keys

# Show current configuration
tmux show-options -g | less
```

Common workflow:

```bash
# Start session with project structure
tmux new -s project -n editor -d
tmux send -t project:editor 'cd ~/project && vim' Enter
tmux split -t project -h
tmux send -t project.1 'cd ~/project' Enter
tmux attach -t project

# Switch between panes
Ctrl-b o    # Next pane
Ctrl-b ;    # Toggle last pane

# Detach to background
Ctrl-b d

# Reattach later
tmux a -t project
```
