return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- Best for long coding sessions
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- Better for eyes
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {
					mocha = {
						-- Slightly warmer background for comfort
						base = "#1e1e2e",
						mantle = "#181825",
						crust = "#11111b",
					},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					telescope = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
					disabled_filetypes = {
						statusline = { "dashboard", "alpha" },
						winbar = {},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
