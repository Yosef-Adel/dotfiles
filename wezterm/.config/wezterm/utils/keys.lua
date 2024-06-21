local wt_action = require("wezterm").action
local M = {}

M.key_table = function(mods, key, action)
	return {
		mods = mods,
		key = key,
		action = action,
	}
end

M.cmd_key = function(key, action)
	return M.key_table("CMD", key, action)
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
	return M.cmd_key(
		key,
		wt_action.Multiple({
			wt_action.SendKey({ mods = "CTRL", key = "b" }),
			wt_action.SendKey({ key = tmux_key }),
		})
	)
end

M.cmd_to_alt_key = function(key)
	return M.cmd_key(key, wt_action.SendKey({ mods = "ALT", key = key }))
end

return M
