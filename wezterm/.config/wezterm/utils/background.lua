local M = {}
local h = require("utils/helpers")

M.get_background = function(dark, light)
	dark = dark or 0.8
	light = light or 0.8
	return {
		source = {
			Gradient = {
				colors = { h.is_dark() and "#000000" or "#ffffff" },
			},
		},
		width = "100%",
		height = "100%",
		opacity = h.is_dark() and dark or light,
	}
end

return M
