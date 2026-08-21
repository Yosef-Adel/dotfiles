local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
require("lazy").setup("plugins", {
	-- nothing here needs luarocks, and leaving it on makes :checkhealth
	-- report a missing hererocks install as an error
	rocks = { enabled = false },
})
