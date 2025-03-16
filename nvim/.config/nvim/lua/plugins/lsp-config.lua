return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" }, -- Load LSP config on buffer read or new file creation
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"nvim-lua/plenary.nvim", -- Add this line to include plenary.nvim
			{ "antosha417/nvim-lsp-file-operations", config = true }, -- File operations for LSP
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local keymap = vim.keymap -- Aliasing for conciseness
			-- Use a single source for LSP capabilities for consistency
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Server-specific setup for lua_ls (Neovim-aware)
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					},
				},
			})

			-- Enable LSP logging for debugging server issues
			vim.lsp.set_log_level("warn")

			-- Customizable keymaps table
			local default_keymaps = {
				{ "n", "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
				{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
				{ "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
				{ "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
				{ "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
				{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
				{ "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
				{ "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
				{ "n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
				{ "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
				{ "n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor" },
				{ "n", "<leader>rr", vim.diagnostic.open_float, "Show diagnostic [E]rror messages" },
				{ "n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list" },
				{ "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
			}

			-- Set up LSP keymaps on LSP attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true } -- Options for keymaps
					-- Apply customizable keymaps
					for _, mapping in ipairs(default_keymaps) do
						opts.desc = mapping[4]
						keymap.set(mapping[1], mapping[2], mapping[3], opts)
					end
				end,
			})

			-- Define diagnostic signs
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
				-- Default handler for all servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Override for specific servers if needed (e.g., lua_ls already set above)
			})

			-- Integrate linting with nvim-lint
			require("lint").linters_by_ft = {
				javascript = { "eslint" },
				python = { "pylint" },
			}
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})

			-- Integrate formatting with mason-conform
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "isort" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
				},
				format_on_save = { timeout_ms = 500, lsp_fallback = true },
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
					"lua_ls",
					"emmet_ls",
					"stylua",
					"black",
					"isort",
					"pylint",
					-- "pyright",
				},
				auto_update = true, -- Automatically update tools
				run_on_start = true, -- Avoid startup delay; install manually with :MasonToolsInstall
			})
		end,
	},
}
