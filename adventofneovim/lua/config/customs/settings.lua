vim.opt.guicursor = "" -- making the cursor invisible in GUI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wildignore:append({ "*/node_modules/*" })
