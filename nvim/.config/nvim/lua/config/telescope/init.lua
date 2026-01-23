-- Telescope configuration entry point
local M = {}

function M.setup()
	local builtin = require("telescope.builtin")
	local map = vim.keymap.set

	-- Load core keymaps
	require("config.telescope.keymaps").setup(builtin, map)

	-- Load architecture layer searches
	require("config.telescope.architecture").setup(builtin, map)
end

return M
