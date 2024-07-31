return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Import lspconfig plugin
		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true, noremap = true } -- noremap ensures no recursive mapping

				-- Define key mappings
				local mappings = {
					{ key = "gr", cmd = "<cmd>Telescope lsp_references<CR>", desc = "Show LSP references" },
					{ key = "gD", cmd = vim.lsp.buf.declaration, desc = "Go to declaration" },
					{ key = "gd", cmd = "<cmd>Telescope lsp_definitions<CR>", desc = "Show LSP definitions" },
					{ key = "gi", cmd = "<cmd>Telescope lsp_implementations<CR>", desc = "Show LSP implementations" },
					{ key = "gt", cmd = "<cmd>Telescope lsp_type_definitions<CR>", desc = "Show LSP type definitions" },
					{
						key = "<leader>ca",
						cmd = vim.lsp.buf.code_action,
						mode = { "n", "v" },
						desc = "See available code actions",
					},
					{ key = "<leader>rn", cmd = vim.lsp.buf.rename, desc = "Smart rename" },
					{
						key = "<leader>D",
						cmd = "<cmd>Telescope diagnostics bufnr=0<CR>",
						desc = "Show buffer diagnostics",
					},
					{ key = "[d", cmd = vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
					{ key = "]d", cmd = vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
					{ key = "K", cmd = vim.lsp.buf.hover, desc = "Show documentation for what is under cursor" },
					{ key = "<leader>rs", cmd = ":LspRestart<CR>", desc = "Restart LSP" },
				}

				-- Set the defined key mappings
				for _, map in ipairs(mappings) do
					opts.desc = map.desc
					if map.mode then
						keymap.set(map.mode, map.key, map.cmd, opts)
					else
						keymap.set("n", map.key, map.cmd, opts)
					end
				end
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Setup LSP servers
		local nvim_lsp = require("lspconfig")

		-- Setup tsserver for TypeScript/JavaScript
		nvim_lsp.tsserver.setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false -- Disable tsserver formatting if using another formatter
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			end,
			flags = {
				debounce_text_changes = 150,
			},
		})
	end,
}
