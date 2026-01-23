return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			-- Set as default notification handler
			vim.notify = notify
		end,
	},
	-- {
	--
	-- 	"akinsho/bufferline.nvim",
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
	-- 		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
	-- 	},
	-- 	opts = {
	-- 		options = {
	-- 			mode = "tabs",
	-- 			show_buffer_close_icons = false,
	-- 			show_close_icon = false,
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"b0o/incline.nvim",
	-- 	dependencies = {},
	-- 	event = "BufReadPre",
	-- 	priority = 1200,
	-- 	config = function()
	-- 		local helpers = require("incline.helpers")
	-- 		require("incline").setup({
	-- 			window = {
	-- 				padding = 0,
	-- 				margin = { horizontal = 0 },
	-- 			},
	-- 			render = function(props)
	-- 				local relpath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
	-- 				local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(relpath)
	-- 				local modified = vim.bo[props.buf].modified
	-- 				local buffer = {
	-- 					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
	-- 						or "",
	-- 					" ",
	-- 					{ relpath, gui = modified and "bold,italic" or "bold" },
	-- 					" ",
	-- 					guibg = "#363944",
	-- 				}
	-- 				return buffer
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
