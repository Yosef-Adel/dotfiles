local h = require("utils/helpers")
local M = {}

M.get_color_scheme = function()
	return h.is_dark() and "Catppuccin Mocha"
end

return M
