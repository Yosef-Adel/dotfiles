return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("obsidian").setup({
			--So Markdown will be rendered in Obsidian
			ui = { enable = false },
			workspaces = {
				{
					name = "Notes",
					path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain"),
					overrides = {
						notes_subdir = "Inbox",
					},
				},
			},
			-- Customize note ID generation to be based on the title only
			note_id_func = function(title)
				-- If a title is provided, use it directly for the ID (file name)
				if title ~= nil then
					return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				end
				-- Fallback for untitled notes, could add random characters or timestamp if desired
				return tostring(os.time()) -- Or replace with a simple random fallback
			end,

			-- Ensure note paths use the title (or ID, which is now the title)
			note_path_func = function(spec)
				-- Use the title directly for the file path
				local path = spec.dir / tostring(spec.id)
				return path:with_suffix(".md")
			end,
		})
	end,
}
