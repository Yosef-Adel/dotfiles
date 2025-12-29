return {
	"theprimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "ma", mark.add_file, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "mm", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

		-- Navigate to files by index (1-9)
		for i = 1, 9 do
			vim.keymap.set("n", "m" .. i, function()
				ui.nav_file(i)
			end, { desc = "Navigate to " .. i .. " file" })
		end
	end,
}
