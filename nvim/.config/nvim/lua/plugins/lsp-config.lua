-- Servers we want installed and enabled. One list, used for both, so mason
-- can't drift from what actually gets turned on.
local servers = {
	"lua_ls",
	"ts_ls",
	"html",
	"cssls",
	"emmet_ls",
	"tailwindcss",
	"jsonls",
	"bashls",
	"eslint",
	"pyright",
	"gopls",
	-- DevOps
	"yamlls",
	"dockerls",
	"docker_compose_language_service",
	"terraformls",
	"ansiblels",
	"helm_ls",
	"gitlab_ci_ls",
}

return {
	-- Core LSP configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
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

			vim.lsp.log.set_level(vim.log.levels.WARN)
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
				{
					"n",
					"[d",
					function()
						vim.diagnostic.jump({ count = -1, float = true })
					end,
					"Go to previous diagnostic",
				},
				{
					"n",
					"]d",
					function()
						vim.diagnostic.jump({ count = 1, float = true })
					end,
					"Go to next diagnostic",
				},
				{ "n", "<leader>rr", vim.diagnostic.open_float, "Show diagnostic messages" },
				{ "n", "<leader>D", vim.diagnostic.setloclist, "Open diagnostic list" },
				{ "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
			}

			local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_group,
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					for _, mapping in ipairs(default_keymaps) do
						opts.desc = mapping[4]
						keymap.set(mapping[1], mapping[2], mapping[3], opts)
					end

					-- Fold from the server's folding ranges when it offers them;
					-- settings.lua leaves indent folding as the fallback.
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client:supports_method("textDocument/foldingRange") then
						local win = vim.api.nvim_get_current_win()
						vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
						vim.wo[win][0].foldmethod = "expr"
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = lsp_group,
				callback = function()
					local win = vim.api.nvim_get_current_win()
					if vim.wo[win][0].foldexpr == "v:lua.vim.lsp.foldexpr()" then
						vim.wo[win][0].foldmethod = "indent"
						vim.wo[win][0].foldexpr = "0"
					end
				end,
			})
		end,
	},

	-- Mason core installer
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
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
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-lint",
		},
		config = function()
			-- Capability deltas that apply to every server. Only the difference
			-- from Neovim's defaults belongs here: blink.cmp registers its own
			-- completion capabilities the same way, and handing each server a
			-- freshly built `make_client_capabilities()` table would clobber
			-- blink's list values (resolveSupport, itemDefaults) on merge.
			vim.lsp.config("*", {
				capabilities = {
					textDocument = {
						-- lets `vim.lsp.foldexpr()` fold by server folding ranges
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			vim.lsp.config["lua_ls"] = {
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
				settings = {
					yaml = {
						schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
						schemas = {
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
								".gitlab-ci.yml",
							},
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
								"docker-compose*.yml",
								"docker-compose*.yaml",
							},
						},
					},
				},
			}

			-- mason-lspconfig v2 calls `vim.lsp.enable()` for us; scoping
			-- automatic_enable to this list keeps stray mason packages (stylua,
			-- tflint, ...) from being enabled as if they were servers.
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = servers,
			})

			-- Linting for tools that have no language server of their own.
			-- JS/TS is deliberately absent: eslint-lsp already lints those.
			require("lint").linters_by_ft = {
				python = { "pylint" },
				dockerfile = { "hadolint" },
				yaml = { "yamllint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				terraform = { "tflint" },
			}
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Formatters and linters. Language servers are mason-lspconfig's job.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"prettier",
					"stylua",
					"black",
					"isort",

					-- Linters
					"pylint",
					"hadolint",
					"yamllint",
					"shellcheck",
					"tflint",
					"ansible-lint",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},
}
