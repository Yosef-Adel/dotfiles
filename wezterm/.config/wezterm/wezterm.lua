local wezterm = require("wezterm")
local b = require("utils/background")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")
local w = require("utils/wallpaper")

local wallpapers_glob = os.getenv("HOME") .. "/Pictures/Tremenal Wallpaper/*"
local wallpapers = w.load_wallpapers(wallpapers_glob)

local config = {
	background = {
		w.get_wallpaper(wallpapers),
		b.get_background(0.3, 0.3),
	},
	macos_window_background_blur = 500,
	font_size = 16.0,
	line_height = 1.1,
	font = f.get_font({
		"MesloLGS NF",
	}),
	color_scheme = cs.get_color_scheme(),
	window_padding = {
		left = 15,
		right = 15,
		top = 15,
		bottom = 0,
	},
	set_environment_variables = {
		BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
		TERM = "xterm-256color",
		LC_ALL = "en_US.UTF-8",
	},
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = true,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	keys = {
		k.cmd_to_tmux_prefix("t", "c"),
		k.cmd_to_tmux_prefix(",", ","),
		k.cmd_to_tmux_prefix("j", "T"),
		k.cmd_to_tmux_prefix("k", "K"),
		k.cmd_to_tmux_prefix("l", "L"),
		k.cmd_to_tmux_prefix("n", "%"),
		k.cmd_to_tmux_prefix("N", '"'),
		k.cmd_to_tmux_prefix("w", "x"),
		k.cmd_to_tmux_prefix("g", "g"),
		k.cmd_to_tmux_prefix("o", "u"),
		k.cmd_to_tmux_prefix("z", "z"),
		k.cmd_to_tmux_prefix("[", "["),
		k.cmd_to_tmux_prefix("1", "1"),
		k.cmd_to_tmux_prefix("2", "2"),
		k.cmd_to_tmux_prefix("3", "3"),
		k.cmd_to_tmux_prefix("4", "4"),
		k.cmd_to_tmux_prefix("5", "5"),
		k.cmd_to_tmux_prefix("6", "6"),
		k.cmd_to_tmux_prefix("7", "7"),
		k.cmd_to_tmux_prefix("8", "8"),
		k.cmd_to_tmux_prefix("9", "9"),
		k.cmd_to_alt_key("f"),
		k.cmd_to_alt_key("b"),
		{
			mods = "CMD",
			key = "RightArrow",
			action = wezterm.action_callback(function()
				wezterm.log_info("CMD+RightArrow pressed")
				w.next_wallpaper(wallpapers)
				wezterm.reload_configuration()
			end),
		},
		{
			mods = "CMD",
			key = "LeftArrow",
			action = wezterm.action_callback(function()
				wezterm.log_info("CMD+LeftArrow pressed")
				w.previous_wallpaper(wallpapers)
				wezterm.reload_configuration()
			end),
		},
	},
}

return config
