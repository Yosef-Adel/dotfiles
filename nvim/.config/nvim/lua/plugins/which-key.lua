return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")
		wk.setup()

		wk.add({
			{ "<leader>s", group = "Search" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>c", group = "Code" },
			{ "<leader>p", group = "Project" },
			{ "<leader>v", group = "View" },
			{ "<leader>f", group = "Find/Float" },
			{ "<leader>n", group = "Notes/Tabs" },
			{ "<leader>t", group = "Tree" },
			{ "m", group = "Marks/Harpoon" },
		})
	end,
}
