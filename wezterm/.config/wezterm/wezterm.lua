local wezterm = require("wezterm")
local b = require("utils/background")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")
local w = require("utils/wallpaper")
--local wallpapers_glob = os.getenv("HOME") .. "/Pictures/Terminal Wallpaper/*"
--local wallpapers = w.load_wallpapers(wallpapers_glob)
--
local config = {
	background = {
		--		w.get_wallpaper(wallpapers),
		-- b.get_background(0.9, 0.9),
	},
	macos_window_background_blur = 50,
	font_size = 18.0,
	line_height = 1.2,
	font = f.get_font({
		"JetBrains Mono",
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
		-- {
		-- 	mods = "CMD",
		-- 	key = "RightArrow",
		-- 	action = wezterm.action_callback(function()
		-- 		wezterm.log_info("CMD+RightArrow pressed")
		-- 		w.next_wallpaper(wallpapers)
		-- 		wezterm.reload_configuration()
		-- 	end),
		-- },
		-- {
		-- 	mods = "CMD",
		-- 	key = "LeftArrow",
		-- 	action = wezterm.action_callback(function()
		-- 		wezterm.log_info("CMD+LeftArrow pressed")
		-- 		w.previous_wallpaper(wallpapers)
		-- 		wezterm.reload_configuration()
		-- 	end),
		-- },
	},

-- ===== Helpers =====
local appearance = wezterm.gui.get_appearance()

local function is_dark()
  return appearance:find("Dark")
end

local function get_random_entry(tbl)
  local keys = {}
  for key, _ in ipairs(tbl) do
    table.insert(keys, key)
  end
  local randomKey = keys[math.random(1, #keys)]
  return tbl[randomKey]
end

-- ===== Background =====
local function get_background(dark, light)
  dark = dark or 0.8
  light = light or 0.8
  return {
    source = {
      Gradient = {
        colors = { is_dark() and "#000000" or "#ffffff" },
      },
    },
    width = "100%",
    height = "100%",
    opacity = is_dark() and dark or light,
  }
end

-- ===== Color Scheme =====
local function get_color_scheme()
  return is_dark() and "tokyonight"
end

-- ===== Font =====
local function get_font(fonts)
  local family = get_random_entry(fonts)
  return wezterm.font_with_fallback({
    { family = family, weight = "Bold" },
  })
end

-- ===== Keys =====
local wt_action = wezterm.action

local function key_table(mods, key, action)
  return {
    mods = mods,
    key = key,
    action = action,
  }
end

local function cmd_key(key, action)
  return key_table("ALT", key, action)
end

local function cmd_to_tmux_prefix(key, tmux_key)
  return cmd_key(
    key,
    wt_action.Multiple({
      wt_action.SendKey({ mods = "CTRL", key = "b" }),
      wt_action.SendKey({ key = tmux_key }),
    })
  )
end

-- local function cmd_to_alt_key(key)
--   return cmd_key(key, wt_action.SendKey({ mods = "ALT", key = key }))
-- end

-- ===== Config =====
local config = {
  default_prog                               = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
  background                                 = {
    get_background(.90, .90),
  },
  font_size                                  = 12.0,
  line_height                                = 1.1,
  font                                       = get_font({
    "JetBrains Mono",
  }),
  color_scheme                               = get_color_scheme(),
  window_padding                             = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 0,
  },
  set_environment_variables                  = {
    BAT_THEME = is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
    TERM = "xterm-256color",
    LC_ALL = "en_US.UTF-8",
  },
  adjust_window_size_when_changing_font_size = false,
  debug_key_events                           = true,
  enable_tab_bar                             = false,
  native_macos_fullscreen_mode               = false,
  window_close_confirmation                  = "NeverPrompt",
  -- Remove title bar completely
  window_decorations                         = "RESIZE",
  -- Enable blur effect on Windows
  win32_system_backdrop                      = "Acrylic",
  keys                                       = {
    cmd_to_tmux_prefix("t", "c"),
    cmd_to_tmux_prefix(",", ","),
    cmd_to_tmux_prefix("j", "T"),
    cmd_to_tmux_prefix("k", "K"),
    cmd_to_tmux_prefix("l", "L"),
    cmd_to_tmux_prefix("n", "%"),
    cmd_to_tmux_prefix("N", '"'),
    cmd_to_tmux_prefix("w", "x"),
    cmd_to_tmux_prefix("g", "g"),
    cmd_to_tmux_prefix("o", "u"),
    cmd_to_tmux_prefix("z", "z"),
    cmd_to_tmux_prefix("[", "["),
    cmd_to_tmux_prefix("1", "1"),
    cmd_to_tmux_prefix("2", "2"),
    cmd_to_tmux_prefix("3", "3"),
    cmd_to_tmux_prefix("4", "4"),
    cmd_to_tmux_prefix("5", "5"),
    cmd_to_tmux_prefix("6", "6"),
    cmd_to_tmux_prefix("7", "7"),
    cmd_to_tmux_prefix("8", "8"),
    cmd_to_tmux_prefix("9", "9"),
    -- cmd_to_alt_key("f"),
  },

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
  end),
}

return config
