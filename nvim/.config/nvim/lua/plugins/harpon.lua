return {
	"theprimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "<leader>t", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

		vim.keymap.set("n", "<leader>f", function()
			ui.nav_file(1)
		end, { desc = "Navigate to 1st file" })
		vim.keymap.set("n", "<leader>j", function()
			ui.nav_file(2)
		end, { desc = "Navigate to 2nd file" })
		vim.keymap.set("n", "<leader>g", function()
			ui.nav_file(3)
		end, { desc = "Navigate to 3rd file" })
		vim.keymap.set("n", "<leader>h", function()
			ui.nav_file(4)
		end, { desc = "Navigate to 4th file" })

		-- numbers
		vim.keymap.set("n", "<leader>1", function()
			ui.nav_file(1)
		end, { desc = "Navigate to 1st file" })
		vim.keymap.set("n", "<leader>2", function()
			ui.nav_file(2)
		end, { desc = "Navigate to 2nd file" })
		vim.keymap.set("n", "<leader>3", function()
			ui.nav_file(3)
		end, { desc = "Navigate to 3rd file" })
		vim.keymap.set("n", "<leader>4", function()
			ui.nav_file(4)
		end, { desc = "Navigate to 4th file" })
		vim.keymap.set("n", "<leader>5", function()
			ui.nav_file(5)
		end, { desc = "Navigate to 5th file" })
		vim.keymap.set("n", "<leader>6", function()
			ui.nav_file(6)
		end, { desc = "Navigate to 6th file" })
		vim.keymap.set("n", "<leader>7", function()
			ui.nav_file(7)
		end, { desc = "Navigate to 7th file" })
		vim.keymap.set("n", "<leader>8", function()
			ui.nav_file(8)
		end, { desc = "Navigate to 8th file" })
		vim.keymap.set("n", "<leader>9", function()
			ui.nav_file(9)
		end, { desc = "Navigate to 9th file" })
	end,
}
