-- for highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Create the autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Notify if the buffer is within node_modules",
	callback = function()
		-- Get the current buffer's file path
		local notify = require("notify")
		local buf_path = vim.fn.expand("%:p")
		-- Check if the path contains 'node_modules'
		if string.find(buf_path, "node_modules") then
			-- Trigger the notification
			notify("Warning: You are writing a file in node_modules!", "warn", {
				title = "Node Modules Warning",
			})
		end
	end,
})
