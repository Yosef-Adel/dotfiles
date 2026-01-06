# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using the Lazy.nvim plugin manager. The configuration is structured around Clean Architecture principles with specialized Telescope searches for navigating codebases organized by architectural layers (Interactors, Gateways, Presenters, Stores, Components, Entities).

## Architecture

### Directory Structure

```
nvim/.config/nvim/
├── init.lua                 # Entry point - bootstraps Lazy.nvim and loads modules
├── CLAUDE.md               # This file - guidance for Claude Code
├── SNIPPETS.md             # Complete snippet reference (100+ snippets)
├── lua/
│   ├── config/             # Core Neovim configuration
│   │   ├── settings.lua    # Vim options and editor settings
│   │   ├── keymap.lua      # Global keybindings (leader = space)
│   │   └── autocmds.lua    # Autocommands (yank highlight, node_modules warnings)
│   ├── plugins/            # Plugin configurations (~34 plugins)
│   │   ├── telescope.lua   # Fuzzy finder with Clean Architecture layer searches
│   │   ├── lsp-config.lua  # LSP setup using modern vim.lsp.config API (Neovim 0.11+)
│   │   ├── formatting.lua  # Conform.nvim with format-on-save
│   │   ├── treesitter.lua  # Syntax highlighting
│   │   ├── blink.lua       # Completion engine with snippet support
│   │   └── ...             # Other plugin configs
│   └── after/
│       └── functions.lua   # Custom functions (e.g., Open_scratch_buffer)
├── snippets/               # Custom VS Code-style snippets
│   ├── package.json        # Snippet manifest
│   ├── react.json          # React components & hooks (16 snippets)
│   ├── react-testing.json  # Testing Library snippets (19 snippets)
│   ├── typescript.json     # TypeScript/JS snippets (31 snippets)
│   ├── css.json            # CSS snippets (10 snippets)
│   ├── html.json           # HTML snippets (7 snippets)
│   └── json.json           # Config file templates (2 snippets)
└── lazy-lock.json          # Plugin version lockfile
```

### Plugin Loading Strategy

- All plugins are defined in `lua/plugins/` directory
- Each plugin file returns a table/array of plugin specifications
- Lazy.nvim automatically loads all files from `lua/plugins/` directory
- Uses lazy-loading with events like `BufReadPre`, `BufNewFile`, `VimEnter`, `InsertEnter`

### LSP Configuration (Modern API)

Located in `lua/plugins/lsp-config.lua`. Uses **Neovim 0.11+ vim.lsp.config API** (not lspconfig.setup):

- LSP servers configured via `vim.lsp.config[server_name]`
- Auto-enabled on FileType autocmd using `vim.lsp.enable(server_name)`
- Mason handles automatic installation of LSP servers
- Default keymaps set via LspAttach autocmd
- Supports folding capabilities for nvim-ufo

**Important**: When modifying LSP configuration, use `vim.lsp.config` API, not the deprecated `require('lspconfig')[server].setup()` pattern.

### Telescope Architecture-Aware Searches

The `lua/plugins/telescope.lua` file contains extensive Clean Architecture navigation:

**Dual search pattern**: Each layer has TWO keybindings:
- Lowercase = Find FILES by pattern (e.g., `<leader>si` finds `*Interactor.ts` files)
- Uppercase = Search CONTENT within files (e.g., `<leader>sI` searches inside interactor code)

**Layer keybindings**:
- `<leader>si/sI` - Interactors (business logic)
- `<leader>ss/sS` - Stores (state management)
- `<leader>sg/sG` - Gateways (external dependencies)
- `<leader>sp/sP` - Presenters (UI logic, includes legacy Containers)
- `<leader>so/sO` - Components (React components)
- `<leader>se` - Entities (domain models)
- `<leader>sa/sA` - Abstract Tokens (DI interfaces)
- `<leader>sd/sD` - DI Containers
- `<leader>st/sT` - Test files
- `<leader>sc/sC` - Core package search
- `<leader>sx` - Execute methods (interactor entry points)
- `<leader>sl` - Interactive layer selector menu

**Assumes monorepo structure**: Searches target `packages/core/`, `packages/gateways/`, etc.

### Custom Features

1. **Scratch Buffer**: `<leader>vs` opens a vertical scratch buffer for temporary notes
2. **Node Modules Protection**: Autocmds warn when entering/editing files in `node_modules/`
3. **Yank Highlight**: Briefly highlights yanked text with custom colors
4. **Format on Save**: Automatically formats files using Conform.nvim (Prettier, Stylua, Black, etc.)
5. **Spell Checking**: Enabled by default with US English dictionary

## Development Workflow

### Modifying Plugin Configuration

1. Edit the relevant file in `lua/plugins/<plugin-name>.lua`
2. Restart Neovim or run `:Lazy reload <plugin-name>`
3. Plugin changes take effect immediately with lazy loading

### Adding New Plugins

Create a new file in `lua/plugins/` that returns a plugin spec:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- or other lazy-loading trigger
  config = function()
    require("plugin-name").setup({
      -- configuration
    })
  end,
}
```

Lazy.nvim will automatically detect and load it.

### Modifying LSP Servers

Edit `lua/plugins/lsp-config.lua`:

1. Add server name to `ensure_installed` table in mason_lspconfig.setup
2. Add server to `servers` array or create special config like lua_ls
3. Configure via `vim.lsp.config[server_name] = { ... }`
4. Add to servers_to_enable array in FileType autocmd

### Formatting Configuration

Edit `lua/plugins/formatting.lua` to:
- Add formatters for new file types in `formatters_by_ft`
- Ensure formatter is installed via mason-tool-installer in lsp-config.lua
- Adjust timeout or toggle format-on-save behavior

### Custom Snippets

Custom snippets are stored in `snippets/` directory using VS Code snippet format:
- See `SNIPPETS.md` for complete reference of 100+ snippets
- Edit JSON files in `snippets/` to add/modify snippets
- Restart Neovim or run `:Lazy reload blink.cmp` after changes
- Snippets are organized by language: react.json, typescript.json, css.json, html.json, etc.

## Key Technologies

- **Plugin Manager**: Lazy.nvim (automatic lazy loading)
- **LSP**: Native Neovim 0.11+ LSP with Mason for server management
- **Fuzzy Finder**: Telescope with ripgrep backend
- **Formatting**: Conform.nvim (Prettier, Stylua, Black, isort)
- **Syntax**: Treesitter with auto-install enabled
- **Completion**: Blink.cmp (alternative to nvim-cmp)
- **Snippets**: Custom VS Code-style snippets for frontend development (see SNIPPETS.md)
- **Notifications**: noice.nvim + nvim-notify

## Important Notes

- Leader key is `<space>`
- Tab width is 2 spaces (expandtab enabled)
- Relative line numbers enabled
- Clipboard synced with system (`unnamedplus`)
- Undo history persisted to `~/.vim/undodir`
- Uses tmux-sessionizer integration (`<C-f>`, `<A-f>`)
- Code assumes monorepo with `packages/` directory structure for architecture searches
