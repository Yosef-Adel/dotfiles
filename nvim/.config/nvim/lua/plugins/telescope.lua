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
					-- telescope's treesitter-based preview highlighter still calls
					-- nvim-treesitter's old API (ft_to_lang), which no longer exists
					-- on nvim-treesitter's "main" branch. Fall back to plain syntax
					-- highlighting in previews instead (telescope#3547, unresolved).
					preview = {
						treesitter = false,
					},
					layout_config = {
						width = 0.95,
						horizontal = {
							preview_width = 0.4,
						},
					},
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
					file_ignore_patterns = {
						"node_modules/.*",
						"%.git/.*",
						"%.next/.*",
						"dist/.*",
						"build/.*",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- Load all keymaps from config module
			require("config.telescope").setup()
		end,
	},
}
