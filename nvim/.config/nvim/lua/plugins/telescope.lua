return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
					file_ignore_patterns = {},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
	
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
	
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
	
			map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
			map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>sa", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			map("n", "<space>sg", require("custom.multi-ripgrep"))
			map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>sm", builtin.marks, { desc = " Find marks buffers" })
			map("n", "<leader>sj", builtin.jumplist, { desc = " Find jumplist" })
	
			map("n", "<C-p>", builtin.git_files, { desc = "[P]roject [F]iles" })
			map("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "[P]roject [S]earch" })
	
			map("n", "<leader>f", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
	
			map("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
	
			map("n", "<leader>sc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
			map("n", "<leader>sn", function()
				builtin.find_files({ cwd = "~/Documents/Second Brain/" })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
