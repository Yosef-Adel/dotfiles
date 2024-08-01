return {
	{
		"rhysd/git-messenger.vim",
		config = function()
			vim.keymap.set("n", "<leader>Gm", "<cmd>GitMessenger<CR>")
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
		},
	},
	{

		"tpope/vim-fugitive",
		config = function()
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end
				end,
			})
			vim.keymap.set("n", "<leader>Gu", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "<leader>Gh", "<cmd>diffget //3<CR>")
		end,
	},
	-- optional for floating window border decoration
}
