-- Core Telescope keymaps
local M = {}

function M.setup(builtin, map)
	map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
	map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	map("n", "<leader>sb", builtin.builtin, { desc = "[S]earch [B]uiltin Telescope" })
	map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	map("n", "<leader>sz", builtin.diagnostics, { desc = "[S]earch Diagnosti[z]s" })
	map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	map("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
	map("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist" })
	map("n", "<C-p>", builtin.find_files, { desc = "[P]roject [F]iles" })

	-- Grep with input prompt
	map("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end, { desc = "[P]roject [S]earch" })

	-- Fuzzy search in current buffer
	map("n", "<leader>f", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	-- Live grep in open files
	map("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch [/] in Open Files" })

	-- Search Neovim config
	map("n", "<leader>sN", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim config files" })

	-- Search notes
	map("n", "<leader>sn", function()
		builtin.find_files({ cwd = "~/Documents/Second Brain/" })
	end, { desc = "[S]earch [N]otes" })
end

return M
