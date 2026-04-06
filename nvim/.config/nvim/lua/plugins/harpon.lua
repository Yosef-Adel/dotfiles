return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		vim.keymap.set("n", "ma", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "mm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon menu" })

		-- Navigate to files by index (1-9)
		for i = 1, 9 do
			vim.keymap.set("n", "m" .. i, function()
				harpoon:list():select(i)
			end, { desc = "Navigate to harpoon file " .. i })
		end
	end,
}
