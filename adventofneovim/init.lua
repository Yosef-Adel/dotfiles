require("config.lazy")
require("config.customs.keymaps")
require("config.customs.settings")


-- Highlight when yanking (copying) text
-- try it with yap in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#6EACDA", fg = "#021526" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({
			higroup = "YankHighlight",
			timeout = 200,
		})
	end,
})
