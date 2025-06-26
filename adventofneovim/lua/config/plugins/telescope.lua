return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
					file_ignore_patterns = {}, -- add nodemodules, build, dist, ....etc here
				},
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			require('telescope').load_extension('fzf')

			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			map("n", "<leader>sa", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			map("n", "<C-p>", builtin.find_files, { desc = "[P]roject [F]iles" })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })

			map("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "[P]roject [S]earch" })

			map("n", "<leader>f", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			require "config.telescope.multigrep".setup()
		end
	},
}
