return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	init = function()
		-- Skip registering the legacy nvim-treesitter module; that path is
		-- deprecated upstream and doesn't exist on nvim-treesitter's main branch
		vim.g.skip_ts_context_commentstring_module = true
	end,
	config = function()
		-- Disable the plugin's own CursorHold autocmd: it errors with
		-- "attempt to index local 'language_tree'" on buffers without an
		-- active parser. Comment.nvim's pre_hook computes the commentstring
		-- on demand instead, which doesn't have that problem.
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		local comment = require("Comment")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
		comment.setup({
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
