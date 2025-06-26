local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<C-x>", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
