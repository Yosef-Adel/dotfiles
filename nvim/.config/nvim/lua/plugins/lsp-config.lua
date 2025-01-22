return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" }, -- Load LSP config on buffer read or new file creation
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			{ "antosha417/nvim-lsp-file-operations", config = true }, -- File operations for LSP
			{ "folke/neodev.nvim", opts = {} }, -- Enhanced LSP for Neovim development
		},
		config = function()
			local keymap = vim.keymap -- Aliasing for conciseness
			-- Set up LSP keymaps on LSP attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true } -- Options for keymaps

					-- Define various LSP-related keymaps with descriptions
					opts.desc = "Show LSP references"
					keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					opts.desc = "Show LSP definitions"
					keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

					opts.desc = "Show LSP implementations"
					keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

					opts.desc = "Show LSP type definitions"
					keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Show diagnostic [E]rror messages"
					keymap.set("n", "<leader>rr", vim.diagnostic.open_float, opts)

					opts.desc = "Open diagnostic [Q]uickfix list"
					keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
				end,
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},

	---------------------------------- Mason ------------------------------
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	---------------------------------- Mason LSP Config ------------------------------
	{
		"williamboman/mason-lspconfig.nvim", -- LSP configuration extension for Mason
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-lint", -- Linting support for Neovim
			"zapling/mason-conform.nvim", -- Formatting support for Mason
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()
			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Special configuration for lua_ls
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" }, -- Recognize "vim" global
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})
		end,
	},
	---------------------------------- Mason Tool Installer ------------------------------
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Tool installer for Mason
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"typescript-language-server",
					"html",
					"cssls",
					"tailwindcss",
					"prettier",
					"eslint-lsp",
					"cspell",
					"pyright",
					"pylint",
					"lua_ls",
					"emmet_ls",
					"stylua",
					-- "gopls",
					-- "golangci_lint_ls",
					-- "isort",
					-- "black",
					-- "codespell",
					-- "misspell",
				},
				auto_update = true, -- Automatically update the installed tools
				run_on_start = true, -- Install tools when Neovim starts
			})
		end,
	},
}
