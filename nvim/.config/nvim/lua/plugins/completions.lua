return {
	-- "hrsh7th/nvim-cmp",
	-- event = "InsertEnter",
	-- dependencies = {
	-- 	"hrsh7th/cmp-buffer",
	-- 	"hrsh7th/cmp-path",
	-- 	{
	-- 		"L3MON4D3/LuaSnip",
	-- 		version = "v2.*",
	-- 		build = "make install_jsregexp",
	-- 	},
	-- 	"saadparwaiz1/cmp_luasnip",
	-- 	"rafamadriz/friendly-snippets",
	-- 	"onsails/lspkind.nvim",
	-- 	"neovim/nvim-lspconfig",
	-- 	"b0o/schemastore.nvim",
	-- },
	-- config = function()
	-- 	local cmp = require("cmp")
	-- 	local luasnip = require("luasnip")
	-- 	local lspkind = require("lspkind")
	--
	-- 	-- Load VSCode-style snippets
	-- 	require("luasnip.loaders.from_vscode").lazy_load()
	-- 	-- Load custom Lua snippets from ~/.config/nvim/lua/snippets/
	-- 	require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets/" } })
	--
	-- 	cmp.setup({
	-- 		completion = {
	-- 			-- Updated to "select" for auto-selecting the first suggestion
	-- 			completeopt = "menu,menuone,preview,select",
	-- 		},
	-- 		snippet = {
	-- 			expand = function(args)
	-- 				luasnip.lsp_expand(args.body)
	-- 			end,
	-- 		},
	-- 		mapping = cmp.mapping.preset.insert({
	-- 			["<C-p>"] = cmp.mapping.select_prev_item(),
	-- 			["<C-n>"] = cmp.mapping.select_next_item(),
	-- 			["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 			["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 			["<C-Space>"] = cmp.mapping.complete(),
	-- 			["<C-e>"] = cmp.mapping.abort(),
	-- 			["<C-y>"] = cmp.mapping.confirm({ select = false }),
	-- 			["<Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_next_item()
	-- 				elseif luasnip.expand_or_jumpable() then
	-- 					luasnip.expand_or_jump()
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_prev_item()
	-- 				elseif luasnip.jumpable(-1) then
	-- 					luasnip.jump(-1)
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			-- Added for half-page scrolling of documentation
	-- 			["<C-d>"] = cmp.mapping.scroll_docs(4),
	-- 			["<C-u>"] = cmp.mapping.scroll_docs(-4),
	-- 		}),
	-- 		-- Reordered sources to prioritize LSP
	-- 		sources = cmp.config.sources({
	-- 			{ name = "nvim_lsp" },
	-- 			{ name = "codeium" },
	-- 			{ name = "luasnip" },
	-- 			{ name = "buffer" },
	-- 			{ name = "path" },
	-- 		}),
	-- 		formatting = {
	-- 			format = lspkind.cmp_format({
	-- 				mode = "symbol",
	-- 				maxwidth = 50,
	-- 				ellipsis_char = "...",
	-- 				symbol_map = { Codeium = "" },
	-- 			}),
	-- 		},
	-- 		-- Added performance optimizations
	-- 		performance = {
	-- 			debounce = 60, -- ms
	-- 			throttle = 30, -- ms
	-- 			fetching_timeout = 500, -- ms
	-- 		},
	-- 		-- Added bordered windows for better UI
	-- 		window = {
	-- 			completion = cmp.config.window.bordered(),
	-- 			documentation = cmp.config.window.bordered(),
	-- 		},
	-- 	})
	--
	-- 	-- YAML LSP setup with custom tags
	-- 	local nvim_lsp = require("lspconfig")
	-- 	local schemastore = require("schemastore")
	--
	-- 	nvim_lsp.yamlls.setup({
	-- 		settings = {
	-- 			yaml = {
	-- 				schemas = schemastore.yaml.schemas(),
	-- 				customTags = { "!Ref", "!ImportValue" }, -- Add more tags as needed
	-- 			},
	-- 		},
	-- 	})
	--
	-- 	-- SQL-specific setup with luasnip added
	-- 	cmp.setup.filetype({ "sql" }, {
	-- 		sources = {
	-- 			{ name = "vim-dadbod-completion" },
	-- 			{ name = "luasnip" },
	-- 			{ name = "buffer" },
	-- 		},
	-- 	})
	-- end,
}
