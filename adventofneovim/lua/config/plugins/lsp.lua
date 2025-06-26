return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("lspconfig").lua_ls.setup({})
			require("lspconfig").ts_ls.setup({})
			require("lspconfig").eslint.setup({})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('my.lsp', {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					if not client then return end

					if client:supports_method('textDocument/formating', 0) then
						vim.api.nvim_create_autocmd('BufWritePre', {
							group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
							end,
						})
					end
				end,
			})

			vim.keymap.set("n", "<space>mp", function() vim.lsp.buf.format() end)

			local keymap = vim.keymap

			vim.lsp.set_log_level("warn")
			local default_keymaps = {
				{ "n",          "gr",         "<cmd>Telescope lsp_references<CR>",       "Show LSP references" },
				{ "n",          "gD",         vim.lsp.buf.declaration,                   "Go to declaration" },
				{ "n",          "gd",         "<cmd>Telescope lsp_definitions<CR>",      "Show LSP definitions" },
				{ "n",          "gi",         "<cmd>Telescope lsp_implementations<CR>",  "Show LSP implementations" },
				{ "n",          "gt",         "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
				{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,                   "See available code actions" },
				{ "n",          "<leader>rn", vim.lsp.buf.rename,                        "Smart rename" },
				{ "n",          "<leader>D",  "<cmd>Telescope diagnostics bufnr=0<CR>",  "Show buffer diagnostics" },
				{ "n",          "[d",         vim.diagnostic.goto_prev,                  "Go to previous diagnostic" },
				{ "n",          "]d",         vim.diagnostic.goto_next,                  "Go to next diagnostic" },
				{ "n",          "K",          vim.lsp.buf.hover,                         "Show documentation for what is under cursor" },
				{ "n",          "<leader>rr", vim.diagnostic.open_float,                 "Show diagnostic messages" },
				{ "n",          "<leader>q",  vim.diagnostic.setloclist,                 "Open diagnostic quickfix list" },
				{ "n",          "<leader>rs", ":LspRestart<CR>",                         "Restart LSP" },
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
		end
	},
}
