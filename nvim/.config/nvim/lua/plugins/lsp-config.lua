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
				-- Use native LSP functions (no deprecated API warnings)
				{ "n", "gd", vim.lsp.buf.definition, "Go to definition" },
				{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
				{ "n", "gr", vim.lsp.buf.references, "Show references" },
				{ "n", "gi", vim.lsp.buf.implementation, "Go to implementation" },
				{ "n", "gt", vim.lsp.buf.type_definition, "Go to type definition" },
				{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
				{ "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
				{ "n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor" },
				{ "n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
				{ "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
				{ "n", "<leader>rr", vim.diagnostic.open_float, "Show diagnostic messages" },
				{ "n", "<leader>D", vim.diagnostic.setloclist, "Open diagnostic list" },
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

			-- Add folding capabilities for nvim-ufo
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

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
					-- DevOps
					"yamlls",
					"dockerls",
					"docker_compose_language_service",
					"terraformls",
					"ansiblels",
					"helm_ls",
				},
				automatic_installation = true,
			})

			-- Configure servers using new vim.lsp.config API (Neovim 0.11+)
			-- Special configuration for lua_ls
			vim.lsp.config["lua_ls"] = {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					},
				},
			}

			-- yamlls: enable SchemaStore so GitLab CI, GitHub Actions,
			-- docker-compose, Kubernetes, etc. get schema-aware completion
			-- based on filename, on top of explicit mappings as a fallback
			vim.lsp.config["yamlls"] = {
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
						schemas = {
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = { ".gitlab-ci.yml" },
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
								"docker-compose*.yml",
								"docker-compose*.yaml",
							},
						},
					},
				},
			}

			-- Configure other servers with default settings
			local servers = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"jsonls",
				"bashls",
				"eslint",
				"pyright",
				"dockerls",
				"docker_compose_language_service",
				"terraformls",
				"ansiblels",
				"helm_ls",
			}
			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
			end

			-- Auto-enable LSP servers when their filetypes are detected
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserLspStart", {}),
				callback = function(args)
					-- Enable LSP for known servers
					local servers_to_enable = {
						"lua_ls",
						"ts_ls",
						"html",
						"cssls",
						"tailwindcss",
						"jsonls",
						"bashls",
						"eslint",
						"pyright",
						"yamlls",
						"dockerls",
						"docker_compose_language_service",
						"terraformls",
						"ansiblels",
						"helm_ls",
					}
					for _, server in ipairs(servers_to_enable) do
						if not vim.lsp.get_clients({ bufnr = args.buf, name = server })[1] then
							vim.lsp.enable(server)
						end
					end
				end,
			})

			-- Linting
			require("lint").linters_by_ft = {
				javascript = { "eslint" },
				python = { "pylint" },
				dockerfile = { "hadolint" },
				yaml = { "yamllint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				terraform = { "tflint" },
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

					-- DevOps
					"yaml-language-server",
					"dockerfile-language-server",
					"docker-compose-language-service",
					"terraform-ls",
					"hadolint",
					"yamllint",
					"shellcheck",
					"tflint",
					"ansible-language-server",
					"ansible-lint",
					"helm-ls",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
}
