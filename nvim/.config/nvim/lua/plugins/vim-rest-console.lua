return {
	"mistweaverco/kulala.nvim",
	ft = "http",
	keys = {
		{ "<leader>hr", "<cmd>lua require('kulala').run()<CR>", desc = "Run HTTP request", ft = "http" },
		{ "<leader>hl", "<cmd>lua require('kulala').replay_last()<CR>", desc = "Re-run last request", ft = "http" },
	},
	opts = {},
}
