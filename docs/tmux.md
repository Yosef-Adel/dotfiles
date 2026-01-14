*tmux.txt*  tmux Reference

==============================================================================
CONTENTS                                                        *tmux-contents*

1. Installation .......................... |tmux-install|
2. Sessions .............................. |tmux-sessions|
3. Windows ............................... |tmux-windows|
4. Panes ................................. |tmux-panes|
5. Keyboard Shortcuts .................... |tmux-shortcuts|
6. Configuration ......................... |tmux-config|
7. Commands .............................. |tmux-commands|
8. Plugins ............................... |tmux-plugins|
9. Tips & Tricks ......................... |tmux-tips|

==============================================================================
1. INSTALLATION                                                 *tmux-install*

Install tmux~
>
    # macOS (Homebrew)
    brew install tmux

    # Ubuntu/Debian
    sudo apt-get install tmux

    # Verify
    tmux -V
<

==============================================================================
2. SESSIONS                                                    *tmux-sessions*

Create session~                                         *tmux-session-create*
>
    # Create new session
    tmux new-session -s myname
    tmux new -s myproject

    # Create detached session
    tmux new-session -s myname -d

    # Create with initial command
    tmux new-session -s myname -d "cd ~/project && vim"
<

List sessions~                                            *tmux-session-list*
>
    # List sessions
    tmux list-sessions
    tmux ls

    # In tmux (prefix key)
    Ctrl-b s    # List sessions interactively
<

Attach session~                                         *tmux-session-attach*
>
    # Attach to session
    tmux attach-session -t myname
    tmux attach -t myname
    tmux a -t myname

    # Switch from within tmux
    Ctrl-b s    # Select from list
    Ctrl-b (    # Previous session
    Ctrl-b )    # Next session
<

Detach session~                                        *tmux-session-detach*
>
    # Detach from session
    Ctrl-b d
<

Kill session~                                            *tmux-session-kill*
>
    # Kill session
    tmux kill-session -t myname

    # Kill all sessions
    tmux kill-server

    # Kill all but current
    Ctrl-b &
<

Rename session~                                        *tmux-session-rename*
>
    # Rename session
    tmux rename-session -t old_name new_name
    tmux rename -t old new

    # In tmux
    Ctrl-b $    # Rename current session
<

==============================================================================
3. WINDOWS                                                      *tmux-windows*

Create window~                                          *tmux-window-create*
>
    # Create new window
    Ctrl-b c

    # Create window with name
    tmux new-window -t myname -n mywindow
<

Switch window~                                          *tmux-window-switch*
>
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
<

Rename window~                                          *tmux-window-rename*
>
    # Rename current window
    Ctrl-b ,

    # Set window name
    tmux rename-window -t myname:0 newname
<

Kill window~                                              *tmux-window-kill*
>
    # Kill current window
    Ctrl-b &

    # Close window (exit shell)
    exit
<

==============================================================================
4. PANES                                                          *tmux-panes*

Split pane~                                                *tmux-pane-split*
>
    # Split vertically (side-by-side)
    Ctrl-b %

    # Split horizontally (top-bottom)
    Ctrl-b "

    # Split with specific size
    tmux split-window -h -p 30    # 30% width
<

Navigate panes~                                         *tmux-pane-navigate*
>
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
<

Resize pane~                                             *tmux-pane-resize*
>
    # Increase/decrease pane size
    Ctrl-b Ctrl-Up      # Increase height
    Ctrl-b Ctrl-Down    # Decrease height
    Ctrl-b Ctrl-Left    # Decrease width
    Ctrl-b Ctrl-Right   # Increase width

    # Hold Ctrl-b and use arrows multiple times
    Ctrl-b Ctrl-Up Up Up Up

    # Command line
    tmux resize-pane -t myname:0.0 -x 100 -y 30
<

Close pane~                                               *tmux-pane-close*
>
    # Kill current pane
    Ctrl-b x

    # Or simply exit
    exit
<

Zoom pane~                                                 *tmux-pane-zoom*
>
    # Toggle zoom (fullscreen pane)
    Ctrl-b z
<

==============================================================================
5. KEYBOARD SHORTCUTS                                        *tmux-shortcuts*

Session commands~                                     *tmux-shortcuts-session*
>
    Ctrl-b $    Rename session
    Ctrl-b d    Detach session
    Ctrl-b s    Select session
    Ctrl-b (    Previous session
    Ctrl-b )    Next session
<

Window commands~                                      *tmux-shortcuts-window*
>
    Ctrl-b c    Create window
    Ctrl-b n    Next window
    Ctrl-b p    Previous window
    Ctrl-b l    Last window
    Ctrl-b 0-9  Select window by number
    Ctrl-b w    Select window (interactive)
    Ctrl-b ,    Rename window
    Ctrl-b &    Kill window
<

Pane commands~                                          *tmux-shortcuts-pane*
>
    Ctrl-b %    Split vertically
    Ctrl-b "    Split horizontally
    Ctrl-b o    Select next pane
    Ctrl-b ;    Toggle last pane
    Ctrl-b {    Swap pane left
    Ctrl-b }    Swap pane right
    Ctrl-b z    Zoom pane
    Ctrl-b x    Kill pane
    Ctrl-b !    Break pane into window
<

Copy mode~                                              *tmux-shortcuts-copy*
>
    Ctrl-b [    Enter copy mode (scroll)
    q           Exit copy mode
    Space       Start selection
    Enter       Copy selection

    Ctrl-b ]    Paste
    Ctrl-b =    Choose buffer
    Ctrl-b #    List buffers
<

Navigation in copy mode~
>
    h/j/k/l     Vim-style movement
    w/b         Word forward/backward
    ^/$         Line start/end
    G           End of buffer
    g           Start of buffer
    /           Search down
    ?           Search up
    n           Next match
    N           Previous match
<

==============================================================================
6. CONFIGURATION                                                *tmux-config*

Configuration file: ~/.tmux.conf~

Basic configuration~                                    *tmux-config-basic*
>
    # Change prefix key
    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix

    # Mouse support
    set -g mouse on

    # Vi keybindings
    setw -g mode-keys vi
    bind -T copy-mode-vi 'v' send -X begin-selection
    bind -T copy-mode-vi 'y' send -X copy-selection

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
<

Key bindings~                                          *tmux-config-bindings*
>
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
<

Colors & styling~                                       *tmux-config-colors*
>
    # Colors (256-color palette)
    set -g status-bg colour236
    set -g status-fg colour246
    setw -g window-status-current-bg colour214
    setw -g window-status-current-fg colour233

    # Status line format
    set -g status-left "#[fg=colour15,bg=colour27] #S #[default] "
    set -g status-right "#[fg=colour246] %H:%M #[default]"

    # Message style
    set -g message-bg colour235
    set -g message-fg colour245
<

==============================================================================
7. COMMANDS                                                   *tmux-commands*

Common commands~
>
    # Send command to pane
    tmux send-keys -t session:window.pane "command" Enter

    # List commands
    tmux list-commands

    # Show options
    tmux show-options -g          # Global options
    tmux show-window-options -g   # Window options

    # Get option value
    tmux show-options -g | grep status
<

==============================================================================
8. PLUGINS                                                     *tmux-plugins*

Popular plugins via tpm (tmux plugin manager)~
>
    # Install tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # In .tmux.conf
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-yank'          # Copy to clipboard
    set -g @plugin 'tmux-plugins/tmux-resurrect'     # Save/restore
    set -g @plugin 'tmux-plugins/tmux-continuum'     # Auto-save
    set -g @plugin 'tmux-plugins/tmux-pain-control'  # Better panes

    run '~/.tmux/plugins/tpm/tpm'

    # Install plugins
    Ctrl-b I

    # Update plugins
    Ctrl-b U

    # Uninstall plugins
    Ctrl-b Alt-U
<

==============================================================================
9. TIPS & TRICKS                                                 *tmux-tips*

Common operations~
>
    # Kill all tmux processes
    tmux kill-server

    # Capture pane content
    tmux capture-pane -t myname:0 -p

    # Capture and save to file
    tmux capture-pane -t myname:0 -p > pane-contents.txt

    # List all keybindings
    tmux list-keys

    # Show current configuration
    tmux show-options -g | less
<

Create session with multiple windows~
>
    tmux new-session -s myname -n editor -c ~/project && \
    tmux new-window -t myname -n server && \
    tmux new-window -t myname -n logs
<

One-liner with split panes~
>
    tmux new-session -d -s myname -c ~/project && \
    tmux split-window -t myname -h -c ~/project && \
    tmux split-window -t myname -v -c ~/project && \
    tmux attach -t myname
<

SSH + tmux combo~
>
    ssh user@host -t "tmux new-session -s work -d && tmux attach -t work"
<

Common workflow~
>
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
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
