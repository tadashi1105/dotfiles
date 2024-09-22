local wezterm = require("wezterm")

---@param window any
---@param new_opacity number|nil
local function change_opacity(window, new_opacity)
	local overrides = window:get_config_overrides() or {}
	overrides.window_background_opacity = new_opacity
	window:set_config_overrides(overrides)
end

local M = {}

M.leader = { key = "A", mods = "CTRL|SHIFT", timeout_milliseconds = 1000 }

M.keys = {
	{
		key = "¥",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "¥" }),
	},
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "vim", os.getenv("WEZTERM_CONFIG_FILE") },
		}),
	},
	-- Toggle simple fullscreen
	{
		key = "f",
		mods = "CTRL|CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	-- Increase background opacity
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local current = window:get_config_overrides().window_background_opacity
			change_opacity(window, math.min(current + 0.1, 1.0))
		end),
	},
	-- Decrease background opacity
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local current = window:get_config_overrides().window_background_opacity
			change_opacity(window, math.max(current - 0.1, 0.1))
		end),
	},
	-- Make background fully opaque
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			change_opacity(window, 1.0)
		end),
	},
	-- Reset background opacity
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			change_opacity(window, nil)
		end),
	},
	-- Set background to 50% transparency
	{
		key = "t",
		mods = "ALT|CMD",
		action = wezterm.action_callback(function(window, pane)
			change_opacity(window, 0.5)
		end),
	},
}

return M
