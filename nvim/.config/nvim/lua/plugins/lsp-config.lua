return {
	-- Core LSP configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim", -- Added missing dependency
			{ "antosha417/nvim-lsp-file-operations", config = true },
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
			local keymap = vim.keymap

			vim.lsp.set_log_level("warn")
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
				{ "n", "<leader>rr", vim.diagnostic.open_float, "Show diagnostic messages" },
				{ "n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic quickfix list" },
				{ "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					for _, mapping in ipairs(default_keymaps) do
						opts.desc = mapping[4]
						keymap.set(mapping[1], mapping[2], mapping[3], opts)
					end
				end,
			})
		end,
	},
	-- Mason core installer
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
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

	-- Auto-LSP setup with mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-lint",
			"stevearc/conform.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",
					"bashls",
					"eslint",
					"pyright",
				},
				automatic_installation = true,
			})

			-- Manual setup for each LSP server
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						},
					},
				},
				html = {},
				cssls = {},
				tailwindcss = {},
				jsonls = {},
				bashls = {},
				eslint = {},
				pyright = {},
			}

			-- Setup each server
			for server, config in pairs(servers) do
				lspconfig[server].setup(config)
			end

			-- Linting
			require("lint").linters_by_ft = {
				javascript = { "eslint" },
				python = { "pylint" },
			}
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Tool installer helper
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Language servers
					"html-lsp",
					"css-lsp",
					"tailwindcss-language-server",
					"lua-language-server",
					"emmet-ls",
					"pyright",
					"eslint-lsp",
					"json-lsp",
					"bash-language-server",

					-- Formatters
					"prettier",
					"stylua",
					"black",
					"isort",

					-- Linters
					"pylint",
					"cspell",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
}
