local wezterm = require("wezterm")
local h = require("utils/helpers")
local M = {}

local wallpaper_index_file = os.getenv("HOME") .. "/.config/wezterm/current_wallpaper_index"

M.load_wallpapers = function(dir)
	local wallpapers = {}
	for _, v in ipairs(wezterm.glob(dir)) do
		if not string.match(v, "%.DS_Store$") then
			table.insert(wallpapers, v)
		end
	end
	return wallpapers
end

M.read_wallpaper_index = function()
	local file = io.open(wallpaper_index_file, "r")
	if file then
		local index = tonumber(file:read("*all"))
		file:close()
		return index
	else
		return 1
	end
end

M.write_wallpaper_index = function(index)
	local file = io.open(wallpaper_index_file, "w")
	file:write(tostring(index))
	file:close()
end

M.get_wallpaper = function(wallpapers, index)
	index = index or M.read_wallpaper_index()
	local wallpaper_path = wallpapers[index]
	wezterm.log_info("Setting wallpaper to: " .. wallpaper_path)
	return {
		source = { File = { path = wallpaper_path } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
	}
end

M.next_wallpaper = function(wallpapers)
	local index = M.read_wallpaper_index()
	index = (index % #wallpapers) + 1
	M.write_wallpaper_index(index)
	return M.get_wallpaper(wallpapers, index)
end

M.previous_wallpaper = function(wallpapers)
	local index = M.read_wallpaper_index()
	index = (index - 2) % #wallpapers + 1
	M.write_wallpaper_index(index)
	return M.get_wallpaper(wallpapers, index)
end

return M
