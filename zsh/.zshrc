# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
plugins=(git zsh-autosuggestions web-search copyfile zsh-syntax-highlighting copybuffer dirhistory jsontools history emoji encode64 jsontools)

export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ==================== Path ====================
export PATH="$HOME/.tmuxifierr/bin:$PATH"
# Python3
export PATH="/Users/yosefsaaid/Library/Python/3.9/bin:$PATH"

# add path for mpj /Users/yosefsaaid/-_-/mpj
export PATH="/Users/yosefsaaid/-_-/mpj:$PATH"

bindkey -s '^f' 'tmux-sessionizer\n'

# n node version control 
export PATH="/usr/local/bin:$PATH"
# for scripts
export PATH="/users/yosefsaaid/local/bin:$PATH"
# java 
#export JAVA_HOME=/usr/local/Cellar/openjdk@11/11.0.12
#export PATH="$JAVA_HOME/bin/:$PATH"
# spark
export SPARK_HOME=/usr/local/Cellar/apache-spark/3.2.1/libexec
export PATH="$SPARK_HOME/bin/:$PATH"

#export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH=$JAVA_HOME/bin:$PATH

# History {{{
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
# }}}

# ==================== Aliases ====================
# Tldr
alias tldrf='tldr --list | fzf --preview "tldr {1} | bat --color=always --paging=never" --preview-window=right,70% | xargs tldr'
# General Aliases
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gl='git log'
alias glp='git log --pretty'
alias ggpush='git push origin '
alias ggpull='git pull origin "$(git_current_branch)"'

# Docker Aliases
alias dao='open -a Docker'
alias dac='pkill Docker'
alias d='docker'
alias dps='docker ps'
alias di='docker images'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias ld='lazydocker'

# System Monitoring Aliases
alias top='htop'
alias df='df -h'
alias free='free -m'

# alias for vim 
alias v='nvim'
alias vim='nvim'


# alias for tmux 
alias tat='tmux new-session -As $(basename "$PWD" | tr . -)' # will attach if session exists, or create a new session
alias tmuxkillall="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions
alias tk="tmux kill-session " # tmux kill session
alias tf="tmuxifier load-window frontend"
alias ta='tmux a'
alias td='tmux detach'



# ==================== Functions ====================
#
function reload_wm() {
    echo "Reloading skhd and restarting yabai..."
    skhd --reload
    yabai --restart-service
    echo "Done!"
}

# Git Add and Commit
function gac() { git add . && git commit -m "$1"; }

# Docker Remove All Containers
function drm() { docker rm $(docker ps -a -q); }

# Tmux {{{
# Makes creating a new tmux session (with a specific name) easier
function tmuxopen() {
  tmux attach -t $1
}

# Makes creating a new tmux session (with a specific name) easier
function tmuxnew() {
  tmux new -s $1
}

# Makes deleting a tmux session easier
function tmuxkill() {
  tmux kill-session -t $1
}
# }}}


# ==================== git Functions ====================
# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%} [%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}u%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}m%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}s%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
function parse_git_state() {
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "on %{$fg[blue]%}${git_where#(refs/heads/|tags/)}$(parse_git_state)"
}

# ====================theme====================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
