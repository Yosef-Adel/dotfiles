local M = {}

--- Open a scratch buffer
--- @param opts? { split?: "vertical"|"horizontal"|"float", filetype?: string }
function M.scratch(opts)
	opts = opts or {}
	local split = opts.split or "vertical"

	if split == "float" then
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = math.floor((vim.o.lines - height) / 2),
			col = math.floor((vim.o.columns - width) / 2),
			style = "minimal",
			border = "rounded",
		})
	elseif split == "horizontal" then
		vim.cmd("split | enew")
	else
		vim.cmd("vsplit | enew")
	end

	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.bo.buflisted = false

	if opts.filetype then
		vim.bo.filetype = opts.filetype
	end
end

-- Keep global function for backward compatibility with existing keymap
function Open_scratch_buffer()
	M.scratch({ split = "vertical" })
end

return M
