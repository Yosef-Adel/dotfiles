-- Lua function to open a scratch buffer on the right
function Open_scratch_buffer()
	-- Create a new vertical split
	vim.cmd("vsplit")

	-- Create a new buffer
	vim.cmd("enew")

	-- Set buffer options
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.wo.wrap = false
end
