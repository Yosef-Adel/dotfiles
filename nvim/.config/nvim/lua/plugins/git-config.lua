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
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
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

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }

					-- rebase always
					vim.keymap.set("n", "<leader>Gp", function()
						vim.cmd.Git({ "pull", "--rebase" })
					end, opts)

					-- NOTE: It allows me to easily set the branch i am pushing and any tracking
					-- needed if i did not set the branch up correctly
					vim.keymap.set("n", "<leader>GP", ":Git push -u origin ", opts)
				end,
			})

			vim.keymap.set("n", "<leader>Gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>Gu", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "<leader>Gh", "<cmd>diffget //3<CR>")
		end,
	},
}
