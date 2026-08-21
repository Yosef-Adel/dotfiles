# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A Neovim configuration for TypeScript/React and DevOps work, managed with
lazy.nvim. Neovim 0.11+ is required — the config uses `vim.lsp.config`,
`vim.lsp.foldexpr`, `vim.diagnostic.jump` and `vim.hl`, and is developed
against 0.12.

## Layout

```
nvim/.config/nvim/
├── init.lua                  # Bootstraps lazy.nvim, loads config modules, then plugins
├── CLAUDE.md                 # This file
├── SNIPPETS.md               # Snippet reference
├── lua/
│   ├── config/
│   │   ├── settings.lua      # Options, folding defaults, a few global keymaps
│   │   ├── keymap.lua        # Global keybindings (leader = space)
│   │   ├── autocmds.lua      # Yank highlight, node_modules warnings, filetype overrides
│   │   ├── functions.lua     # Custom functions (scratch buffer)
│   │   └── telescope/
│   │       ├── init.lua      # Entry point called from the telescope plugin spec
│   │       ├── keymaps.lua   # Core telescope keymaps
│   │       └── architecture.lua  # DISABLED, see "Clean Architecture searches"
│   └── plugins/              # One file per plugin (or per group); ~50 plugins total
├── snippets/                 # VS Code-style snippets (82 across 6 files)
└── lazy-lock.json            # Plugin lockfile
```

`lua/plugins/` is loaded wholesale by `require("lazy").setup("plugins")`; every
file there returns a plugin spec or a list of them. Adding a file is enough to
add a plugin.

## LSP

`lua/plugins/lsp-config.lua` holds everything LSP: nvim-lspconfig,
mason.nvim, mason-lspconfig.nvim, and mason-tool-installer.nvim.

**One list of servers.** The `servers` table at the top of the file feeds both
`ensure_installed` and `automatic_enable`. To add a server, add it there — no
other edit is needed. Do not add a `vim.lsp.enable()` call; mason-lspconfig v2
does that, and scoping `automatic_enable` to this list is what keeps stray
mason packages (formatters, linters) from being enabled as if they were
servers.

**Per-server settings** go in `vim.lsp.config[name] = { settings = ... }`.
Currently only `lua_ls` and `yamlls` need them. Use this API, never the
deprecated `require("lspconfig")[name].setup()`.

**Capabilities.** Register only deltas from Neovim's defaults, via
`vim.lsp.config("*", { capabilities = ... })`. Do not build a
`vim.lsp.protocol.make_client_capabilities()` table and assign it per server:
blink.cmp registers its own completion capabilities the same way, and a full
table clobbers blink's list values on merge.

**Division of labour.** Language servers belong to mason-lspconfig's
`ensure_installed`; formatters and linters belong to mason-tool-installer's.
Nothing should appear in both.

**Linting.** nvim-lint covers only tools with no language server of their own
(pylint, hadolint, yamllint, shellcheck, tflint). JS/TS is deliberately absent
— eslint-lsp already lints those.

## Folding

Core Neovim, no plugin. `settings.lua` sets indent folding as the baseline;
the `LspAttach` handler in `lsp-config.lua` switches a window to
`vim.lsp.foldexpr()` when the attached server supports
`textDocument/foldingRange`, and `LspDetach` puts it back. `+` and `-` are
`zR` / `zM`.

Note that nvim-ufo cannot be reintroduced: it depends on promise-async, which
ships `lua/async.lua`, and so does the async.nvim that refactoring.nvim
requires. Two plugins, one module name — only one can win.

## Keymaps

Leader is `<space>`. which-key registers the group names in
`lua/plugins/which-key.lua`; keep it in sync when adding a new prefix.

| Prefix | Group |
| ------ | ----- |
| `<leader>s` | Search (telescope) |
| `<leader>r` | Refactor + LSP rename/restart |
| `<leader>g` | Git (gitsigns) |
| `<leader>x` | Trouble |
| `<leader>c` | Code |
| `<leader>p` | Project |
| `<leader>v` | View |
| `<leader>n` | Notes/Tabs |
| `<leader>t` | Tree |
| `m` | Marks/Harpoon |

Refactoring keymaps are **operator-pending expr mappings** — they return an
operator and expect a motion or a visual selection. This is the API
refactoring.nvim exposes now; the older `refactor.refactor("Extract Function")`
string dispatch and the `refactor.debug` table no longer exist.

## Clean Architecture searches

`lua/config/telescope/architecture.lua` defines layer-aware pickers for a
monorepo laid out as `packages/core/`, `packages/gateways/` and so on —
`<leader>si` for Interactors, `<leader>ss` for Stores, and so on, with the
uppercase variant grepping inside the layer instead of finding files.

**It is currently disabled.** The `require` in
`lua/config/telescope/init.lua` is commented out, so none of those keymaps
exist. Re-enable it by uncommenting that line; it only makes sense inside a
repo with that structure.

## Treesitter

nvim-treesitter is on the `main` branch, which has no `master`-era module
system: there is no `nvim-treesitter.configs`, no `nvim-treesitter.query`, and
no `parsers.ft_to_lang`. Plugins that still call those APIs will throw at
runtime rather than at startup, so check before adding one.

`lua/plugins/treesitter.lua` installs the parser list and starts the
highlighter from a FileType autocmd, skipping files over 100 KB. Neovim's own
ftplugins already start it for lua, markdown, help and query.

## Formatting

conform.nvim with format-on-save (`lua/plugins/formatting.lua`), prettier for
web filetypes, stylua for Lua, isort+black for Python, `lsp_format = "fallback"`.
`<leader>mp` formats manually. New formatters need an entry in
`formatters_by_ft` and in mason-tool-installer's `ensure_installed`.

## Other notable behaviour

- **Scratch buffer**: `<leader>vs` (`config.functions.scratch`)
- **node_modules guard**: warns on entering, errors on writing
- **Spell check**: prose filetypes only (markdown, text, gitcommit, html)
- **Jenkinsfile / .gitlab-ci.yml**: mapped to `groovy` and `yaml.gitlab` in
  `autocmds.lua`; `gitlab_ci_ls` only attaches to the compound filetype
- **Go**: gopls comes from Neovim's LSP client; vim-go's own gopls is disabled
  (`g:go_gopls_enabled = 0`) so only one runs
- **Undo**: persisted to `~/.vim/undodir`
- **tmux**: `<C-h/j/k/l>` navigation, `<A-f>` sessionizer

## Testing changes

There is no test suite. To check a change without a UI:

```bash
nvim --headless -c 'lua print("ok")' -c qa      # config loads clean
nvim --headless <file> -c 'lua vim.defer_fn(function()
  print(vim.inspect(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients())))
  vim.cmd("qa!") end, 5000)'                     # which servers attach
```

Two caveats when testing headless: `UIEnter` never fires, so lazy.nvim's
`VeryLazy` plugins stay unloaded unless you force them with
`require("lazy").load({ plugins = { ... } })`; and nothing redraws, so
treesitter never parses a buffer unless you call `parse()` yourself.
