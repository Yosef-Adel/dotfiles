# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GNU Stow-based dotfiles repository. Each top-level directory is a Stow package whose internal structure mirrors `$HOME`. Running `stow <package>` from the repo root creates symlinks in `~` pointing into the package directory.

Example mappings:
- `zsh/.zshrc` → `~/.zshrc`
- `nvim/.config/nvim/` → `~/.config/nvim/`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `scripts/local/bin/` → `~/.local/bin/`

## Common Commands

```bash
# Install a single package (creates symlinks)
stow nvim
stow tmux
stow zsh

# Remove symlinks for a package
stow -D nvim

# Restow (remove then re-symlink) after restructuring
stow -R nvim

# Install all Homebrew packages from Brewfile (macOS)
brew bundle

# Update Brewfile to reflect currently installed packages
~/.local/bin/update_brewfile

# Set up Java + Spring Boot language server for Neovim
~/.local/bin/setup-java-nvim
```

## Repository Structure

| Directory | Config target | Purpose |
|-----------|--------------|---------|
| `nvim/` | `~/.config/nvim/` | Neovim config (Lazy.nvim, LSP, Telescope, snippets) |
| `zsh/` | `~/.zshrc` | Zsh shell (oh-my-zsh, Powerlevel10k, aliases) |
| `tmux/` | `~/.tmux.conf` | Tmux (TPM plugins, sesh integration, vi-mode) |
| `wezterm/` | `~/.config/wezterm/` | WezTerm terminal emulator (Lua config) |
| `alacrity/` | `~/.config/alacrity/` | Alacritty terminal (TOML, Catppuccin themes) |
| `scripts/` | `~/.local/bin/` | Custom shell scripts (see below) |
| `gitconfig/` | `~/.gitconfig` | Git user settings |
| `karabiner/` | `~/.config/karabiner/` | Keyboard remapping (macOS) |
| `yabai/` | `~/.config/yabai/` | Tiling window manager (macOS) |
| `skhd/` | `~/.config/skhd/` | Hotkey daemon (macOS) |
| `sesh/` | `~/.config/sesh/` | Sesh session manager |
| `tmuxifier/` | layouts | Tmux session layouts |
| `docs/` | standalone | Offline dev reference docs (44 markdown files) |

## Key Scripts (`scripts/local/bin/`)

- **`tmux-sessionizer`** — fzf-based tmux session creator; searches `~/.config/`, `~/dotfiles/`, `~/dev/`, etc.
- **`tmux-cht.sh`** — fuzzy documentation browser; opens any file from `~/dotfiles/docs/` in Neovim read-only
- **`setup-java-nvim`** — installs SDKMAN, Java 21 (Temurin), Spring Boot Language Server, and Mason packages for jdtls; supports macOS and WSL
- **`tldrf.sh`** — tldr pages viewer with fzf preview
- **`update_brewfile`** — regenerates `Brewfile` from currently installed Homebrew packages

## Neovim Configuration

See `nvim/.config/nvim/CLAUDE.md` for detailed guidance on the Neovim setup, including:
- Plugin loading strategy (Lazy.nvim)
- LSP configuration (Neovim 0.11+ `vim.lsp.config` API — not lspconfig)
- Clean Architecture Telescope searches (`<leader>si/sI`, `<leader>sg/sG`, etc.)
- Custom snippets reference (`SNIPPETS.md`)

## Docs System

`docs/` contains 44+ offline markdown reference files (TypeScript, React, Git, Docker, SQL, etc.) browsable via `tmux-cht.sh`. These are copy-paste ready cheat sheets with no external dependencies.

---

## Windows Branch

This `windows` branch targets **native Windows** (no WSL). Stow is not available, so a PowerShell script handles installation and symlinking.

### Quick Start (Windows)

```powershell
# 1. Clone the repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# 2. Allow script execution (once per machine)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 3. Run setup (as Administrator, or with Developer Mode enabled)
.\install.ps1
```

### What `install.ps1` Does

1. Installs tools via **winget**: neovim, lazygit, ripgrep, fzf, fd, WezTerm, git, node, go
2. Installs **Scoop** for extras: lazydocker, yazi, gitmux, lua
3. Installs **PSFzf** and **posh-git** PowerShell modules
4. Creates symlinks:

| Source (in repo) | Windows target |
|-----------------|---------------|
| `nvim/.config/nvim/` | `%LOCALAPPDATA%\nvim\` |
| `gitconfig/.gitconfig` | `~\.gitconfig` |
| `wezterm/.config/wezterm/` | `~\.config\wezterm\` |
| `powershell/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | `$PROFILE` |

### What's Different on Windows vs macOS/Linux

| Feature | macOS/Linux | Windows |
|---------|------------|---------|
| Install script | `brew bundle` + `stow` | `install.ps1` |
| Terminal | WezTerm + tmux | WezTerm (native splits) |
| Shell | zsh (oh-my-zsh) | PowerShell 7 |
| Window manager | yabai + skhd | — (not applicable) |
| Session manager | tmux-sessionizer | — (use WezTerm tabs) |

### WezTerm Keybindings on Windows (replacing tmux)

| Key | Action |
|-----|--------|
| `Ctrl+Shift+E` | Split horizontal |
| `Ctrl+Shift+O` | Split vertical |
| `Ctrl+Shift+H/J/K/L` | Navigate panes |
| `Ctrl+Shift+Z` | Zoom pane |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+W` | Close tab |
| `Ctrl+1-9` | Switch tab |

### Nvim Windows Compatibility

- `settings.lua`: undodir uses `vim.fn.stdpath("state")` (cross-platform)
- `keymap.lua`: `<C-f>` tmux sessionizer is skipped on Windows (`vim.fn.has("win32")` guard)
- `vim-tmux-nav.lua`: pane navigation still works for nvim splits without tmux
