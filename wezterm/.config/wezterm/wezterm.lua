local wezterm = require("wezterm")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("apple") ~= nil

local config = {
	background = {},
	font_size = 18.0,
	line_height = 1.2,
	font = f.get_font({ "JetBrains Mono" }),
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
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
}

-- macOS: tmux key passthrough via CMD key
if is_macos then
	config.macos_window_background_blur = 50
	config.native_macos_fullscreen_mode = false
	config.debug_key_events = true
	config.enable_tab_bar = false
	config.keys = {
		k.cmd_to_tmux_prefix("t", "c"),
		k.cmd_to_tmux_prefix("i", "i"),
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
	}
end

-- Windows: WezTerm native pane/tab management (replaces tmux)
if is_windows then
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = false
	config.keys = {
		-- Splits
		{ mods = "CTRL|SHIFT", key = "e", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ mods = "CTRL|SHIFT", key = "o", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- Pane navigation (mirrors vim hjkl)
		{ mods = "CTRL|SHIFT", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
		{ mods = "CTRL|SHIFT", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
		{ mods = "CTRL|SHIFT", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
		{ mods = "CTRL|SHIFT", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
		-- Pane resize
		{ mods = "CTRL|SHIFT", key = "LeftArrow",  action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
		{ mods = "CTRL|SHIFT", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
		{ mods = "CTRL|SHIFT", key = "UpArrow",    action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
		{ mods = "CTRL|SHIFT", key = "DownArrow",  action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
		-- Pane zoom
		{ mods = "CTRL|SHIFT", key = "z", action = wezterm.action.TogglePaneZoomState },
		-- Pane close
		{ mods = "CTRL|SHIFT", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		-- Tabs
		{ mods = "CTRL|SHIFT", key = "t", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ mods = "CTRL|SHIFT", key = "w", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ mods = "CTRL", key = "1", action = wezterm.action.ActivateTab(0) },
		{ mods = "CTRL", key = "2", action = wezterm.action.ActivateTab(1) },
		{ mods = "CTRL", key = "3", action = wezterm.action.ActivateTab(2) },
		{ mods = "CTRL", key = "4", action = wezterm.action.ActivateTab(3) },
		{ mods = "CTRL", key = "5", action = wezterm.action.ActivateTab(4) },
		{ mods = "CTRL", key = "6", action = wezterm.action.ActivateTab(5) },
		{ mods = "CTRL", key = "7", action = wezterm.action.ActivateTab(6) },
		{ mods = "CTRL", key = "8", action = wezterm.action.ActivateTab(7) },
		{ mods = "CTRL", key = "9", action = wezterm.action.ActivateTab(8) },
	}
end

-- ZEN mode (cross-platform)
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
