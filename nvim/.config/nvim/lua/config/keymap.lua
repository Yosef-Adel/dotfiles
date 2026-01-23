vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<c-d>", "<C-d>zz")
vim.keymap.set("n", "<c-u>", "<C-u>zz")
vim.keymap.set("n", "G", "Gzz", { desc = "Go to end of file" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "gl", "$")
vim.keymap.set({ "n", "v" }, "gh", "^")
-- for saving files
vim.keymap.set("n", "<leader>w", "<cmd> w<CR>")

vim.keymap.set("n", "<A-f>", "<cmd>!tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

-- tabs
vim.keymap.set("n", "<leader>nt", "<cmd>tabNext<CR>")
vim.keymap.set("n", "<leader>pt", "<cmd>tabprevious<CR>")

-- Scratch buffers
vim.keymap.set("n", "<Leader>vs", function()
	require("config.functions").scratch({ split = "vertical" })
end, { desc = "Vertical scratch buffer" })

vim.keymap.set("n", "<Leader>fs", function()
	require("config.functions").scratch({ split = "float" })
end, { desc = "Floating scratch buffer" })
