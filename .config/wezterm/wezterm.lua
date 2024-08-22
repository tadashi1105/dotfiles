-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.default_prog = {
	"/bin/zsh",
	"--login",
	"-c",
	"if command -v tmux >/dev/null 2>&1; then tmux attach-session || tmux new-session; else zsh; fi",
}

-- Launch menu
-- config.launch_menu = {
-- 	{
-- 		-- label = '',
-- 		args = { "zsh", "--login" },
-- 	},
-- 	{
-- 		-- label = '',
-- 		args = {
-- 			"zsh",
-- 			"--login",
-- 			"-c",
-- 			"if command -v tmux >/dev/null 2>&1; then tmux attach-session || tmux new-session; else zsh; fi",
-- 		},
-- 	},
-- }

-- Bell
config.audible_bell = "Disabled"

-- Window
config.initial_cols = 130
config.initial_rows = 40
config.window_background_opacity = 0.8
config.macos_window_background_blur = 30
config.window_decorations = "RESIZE"

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 10000

-- Font
config.font = wezterm.font("FiraCode Nerd Font Mono")
-- config.font = wezterm.font("Hack Nerd Font Mono")
-- config.font = wezterm.font("HackGen Console NF")
-- config.font = wezterm.font("MonaspiceNe Nerd Font Mono")
config.font_size = 18

-- Color Scheme
-- config.color_scheme_dirs = { wezterm.config_dir .. "/colorschemes" }
config.color_scheme = "tokyonight_moon"
-- wezterm.add_to_config_reload_watch_list(config.color_scheme_dirs[1] .. config.color_scheme .. ".toml")
local colors, metadata = wezterm.color.load_scheme(wezterm.config_dir .. "/colors/" .. config.color_scheme .. ".toml")
config.color_schemes = {
	[config.color_scheme] = colors,
}

-- Command Palette
config.command_palette_font_size = 16
config.command_palette_fg_color = colors.foreground
config.command_palette_bg_color = colors.tab_bar.active_tab.fg_color

-- Keys
config.keys = {
	{
		key = "¥",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "¥" }),
	},
}

require("tab_bar").setup(config)

return config
