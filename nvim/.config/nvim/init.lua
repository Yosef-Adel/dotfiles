local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Set global options, keymaps
require("config.settings")
require("config.keymap")
require("config.autocmds")

-- Load plugins
require("lazy").setup("plugins")
-- Load Snippets
require("after.functions")
require("snippets.luasnip")
require("snippets.rest-snippets")
