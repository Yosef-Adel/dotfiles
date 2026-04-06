# Copilot Instructions

This is a dotfiles repository containing Neovim configuration and related development tools.

## Neovim Configuration (`nvim/.config/nvim/`)

### Architecture

- **Plugin Manager**: Lazy.nvim with automatic lazy-loading
- **LSP**: Neovim 0.11+ native LSP via `vim.lsp.config` API (not the deprecated `lspconfig.setup()`)
- **Completion**: Blink.cmp with custom VS Code-style snippets
- **Formatting**: Conform.nvim with format-on-save (Prettier, Stylua, Black)

### Key Conventions

**LSP Configuration** (in `lua/plugins/lsp-config.lua`):
```lua
-- Use vim.lsp.config API, NOT lspconfig.setup()
vim.lsp.config["server_name"] = {
  capabilities = capabilities,
  settings = { ... }
}
vim.lsp.enable("server_name")
```

**Plugin Specs**: Each file in `lua/plugins/` returns a Lazy.nvim spec table. Use lazy-loading events (`BufReadPre`, `VeryLazy`, etc.).

**Snippets**: VS Code JSON format in `snippets/` directory. See `SNIPPETS.md` for the full reference (100+ snippets for React, TypeScript, Testing Library).

### Telescope Clean Architecture Searches

The config includes specialized searches for Clean Architecture codebases:
- `<leader>si/sI` - Interactors (business logic)
- `<leader>sg/sG` - Gateways (external dependencies)  
- `<leader>sp/sP` - Presenters (UI logic)
- `<leader>so/sO` - Components
- `<leader>ss/sS` - Stores (state)

Lowercase = find files, Uppercase = search content within files.

### Important Settings

- Leader key: `<space>`
- Tab width: 2 spaces
- Relative line numbers enabled
- Format-on-save enabled
- Undo persisted to `~/.vim/undodir`

### Adding New Plugins

Create `lua/plugins/<name>.lua`:
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

### Adding LSP Servers

1. Add to `ensure_installed` in mason-lspconfig setup
2. Configure via `vim.lsp.config[server_name] = { ... }`
3. Add to `servers_to_enable` array in FileType autocmd

## Other Configurations

This repo also contains configs for: tmux, zsh, wezterm, karabiner, yabai, skhd, and git.
