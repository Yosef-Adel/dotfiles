return {
	{ "echasnovski/mini.icons", version = false },
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				default = true, -- fallback icons for unknown files
				strict = true,
			})
		end,
	},
}
