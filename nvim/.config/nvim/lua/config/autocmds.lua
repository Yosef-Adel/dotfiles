local group = vim.api.nvim_create_augroup("NeoJoey_Event_Group", { clear = true })

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#6EACDA", fg = "#021526" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({
			higroup = "YankHighlight",
			timeout = 200,
		})
	end,
	group = group,
})

-- To Warn you when writing in node_modules
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Notify if the buffer is within node_modules",
	callback = function()
		vim.schedule(function()
			local notify = require("notify")
			local buf_path = vim.fn.expand("%:p")
			if string.find(buf_path, "node_modules") then
				notify("Warning: You entered a file in node_modules!", "error", {
					title = "Node Modules Warning",
				})
			end
		end)
	end,
	group = group,
})

-- To warn you when entering node_modules file
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Notify if the buffer is within node_modules",
	callback = function()
		vim.schedule(function()
			local notify = require("notify")
			local buf_path = vim.fn.expand("%:p")
			if string.find(buf_path, "node_modules") then
				notify("Warning: You entered a file in node_modules!", "warn", {
					title = "Node Modules Warning",
				})
			end
		end)
	end,
	group = group,
})
