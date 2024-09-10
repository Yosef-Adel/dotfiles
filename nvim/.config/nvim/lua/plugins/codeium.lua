return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			chat = {
				enable = true,
				keymaps = {
					open = "<leader>cc", -- Open chat window
					reply = "<leader>cr", -- Send reply in chat
					close = "<leader>cq", -- Close chat window
				},
			},

			disable_bindings = false,
		})
	end,
}
