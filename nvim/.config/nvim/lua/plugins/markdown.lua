return {
	-- Lua
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"preservim/vim-pencil",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({})
		end,
	},
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*",
	-- 	lazy = true,
	-- 	ft = "markdown",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("obsidian").setup({
	-- 			--So Markdown will be rendered in Obsidian
	-- 			ui = { enable = false },
	-- 			workspaces = {
	-- 				{
	-- 					name = "second brain",
	-- 					path = "~/Documents/Second Brain",
	-- 					overrides = {
	-- 						notes_subdir = "Inbox",
	-- 					},
	-- 				},
	-- 			},
	-- 			daily_notes = {
	-- 				folder = "Journals/01 Daily",
	-- 				date_format = "%Y/%m/%Y-%m-%d",
	-- 				template = nil,
	-- 			},
	-- 			-- Customize note ID generation to be based on the title only
	-- 			note_id_func = function(title)
	-- 				-- If a title is provided, use it directly for the ID (file name)
	-- 				if title ~= nil then
	-- 					return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
	-- 				end
	-- 				-- Fallback for untitled notes, could add random characters or timestamp if desired
	-- 				return tostring(os.time()) -- Or replace with a simple random fallback
	-- 			end,
	--
	-- 			-- Ensure note paths use the title (or ID, which is now the title)
	-- 			note_path_func = function(spec)
	-- 				-- Use the title directly for the file path
	-- 				local path = spec.dir / tostring(spec.id)
	-- 				return path:with_suffix(".md")
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
