local wezterm = require("wezterm")

-- The powerline symbol
-- "" symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
-- "" symbol
local THIN_RIGHT_ARROW = wezterm.nerdfonts.pl_left_soft_divider
-- "" symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- "" symbol
local THIN_LEFT_ARROW = wezterm.nerdfonts.pl_right_soft_divider

local EXPAND_ZOOM_ARROW = wezterm.nerdfonts.md_arrow_expand

---@type { [string]: string }
local COMMAND_ICONS = {
	["C:\\WINDOWS\\system32\\cmd.exe"] = wezterm.nerdfonts.md_console_line,
	["Topgrade"] = wezterm.nerdfonts.md_rocket_launch,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.md_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.md_arrow_down_box,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["fish"] = wezterm.nerdfonts.md_fish,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.md_chart_areaspline,
	["btop"] = wezterm.nerdfonts.md_chart_areaspline,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.dev_nodejs_small,
	["nvim"] = wezterm.nerdfonts.linux_neovim,
	["pacman"] = "󰮯 ",
	["paru"] = "󰮯 ",
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["pwsh.exe"] = wezterm.nerdfonts.md_console,
	["ruby"] = wezterm.nerdfonts.dev_ruby,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["tmux"] = wezterm.nerdfonts.cod_terminal_tmux,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.md_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["lazygit"] = wezterm.nerdfonts.cod_github,
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
---@param file_path string
local function basename(file_path)
	return string.gsub(file_path, "(.*[/\\])(.*)", "%2")
end

---@param tab any TabInformation struct
---@param max_width number
local function generate_tab_title(tab, max_width)
	local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
	-- local process, other = title:match("^(%S+)%s*%-?%s*(.*)$")
	local process = basename(tab.active_pane.foreground_process_name)

	if COMMAND_ICONS[process] then
		-- title = COMMAND_ICONS[process] .. " " .. process .. (other or "")
		title = COMMAND_ICONS[process] .. " " .. title
	end

	title = tab.tab_index .. " " .. THIN_RIGHT_ARROW .. " " .. title

	local is_zoomed = false
	for _, pane in ipairs(tab.panes) do
		if pane.is_zoomed then
			is_zoomed = true
			break
		end
	end

	if is_zoomed then
		title = EXPAND_ZOOM_ARROW .. " " .. title
	end

	if wezterm.column_width(title) > max_width - 3 then
		title = wezterm.truncate_right(title, max_width - 5) .. "…"
	end

	return " " .. title .. " "
end

---@param pane any Pane object
---@return string cwd The path of the current working directory
---@return string hostname The hostname (without the domain name)
local function get_cwd_and_hostname(pane)
	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	local cwd = ""
	local hostname = ""
	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or wezterm.hostname()
		end

		-- Remove the domain name portion of the hostname
		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end

		if hostname == "" then
			hostname = wezterm.hostname()
		end
	end
	return cwd, hostname
end

local M = {}

---@param config any Config
function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	-- config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true
	local colors = config.color_schemes[config.color_scheme]

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = generate_tab_title(tab, max_width)
		local is_last = tab.tab_index + 1 == #tabs
		-- Add 1 to the current index and take the remainder divided by the total number of tabs, so that the array range is not exceeded.
		local next_tab_index = tab.tab_index + 1 % #tabs
		-- Add 1 to nex_tab_index because the index of Tab starts at 0 and the array starts at 1.
		local next_tab = tabs[next_tab_index + 1]
		local next_tab_is_active = (next_tab and next_tab_index > tab.tab_index) and next_tab.is_active

		-- local colors = config.resolved_palette
		local active_fg = colors.tab_bar.active_tab.fg_color
		local active_bg = colors.tab_bar.active_tab.bg_color
		local inactive_fg = colors.tab_bar.inactive_tab.fg_color
		local inactive_bg = colors.tab_bar.inactive_tab.bg_color

		local arrow = (tab.is_active or is_last or next_tab_is_active) and SOLID_RIGHT_ARROW or THIN_RIGHT_ARROW
		local arrow_fg = colors.tab_bar.inactive_tab_edge
		local arrow_bg = inactive_bg

		if is_last then
			arrow_fg = tab.is_active and active_bg or inactive_bg
			arrow_bg = colors.tab_bar.background
		elseif tab.is_active then
			arrow_fg = active_bg
			arrow_bg = inactive_bg
		elseif next_tab_is_active then
			arrow_fg = inactive_bg
			arrow_bg = active_bg
		end

		-- The elements to be formatted
		local elements = {}
		if tab.tab_index == 0 then
			table.insert(elements, { Foreground = { Color = active_fg } })
			table.insert(elements, { Text = SOLID_RIGHT_ARROW })
			if not tab.is_active and hover then
				table.insert(elements, { Foreground = { Color = active_bg } })
			else
				table.insert(elements, { Foreground = { Color = inactive_fg } })
			end
		end
		if tab.is_active then
			table.insert(elements, { Attribute = { Intensity = "Bold" } })
			table.insert(elements, { Attribute = { Italic = true } })
		end
		table.insert(elements, { Text = title })
		table.insert(elements, { Foreground = { Color = arrow_fg } })
		table.insert(elements, { Background = { Color = arrow_bg } })
		table.insert(elements, { Text = arrow })

		return elements
	end)

	wezterm.on("update-status", function(window, pane)
		local workspace_name = window:active_workspace()

		window:set_left_status(wezterm.format({
			{ Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
			{ Background = { Color = colors.tab_bar.active_tab.bg_color } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = " " .. workspace_name .. " " },
			{ Foreground = { Color = colors.tab_bar.active_tab.bg_color } },
			{ Background = { Color = colors.tab_bar.active_tab.fg_color } },
			{ Text = SOLID_RIGHT_ARROW },
		}))

		local cwd, hostname = get_cwd_and_hostname(pane)
		local date_and_time = wezterm.strftime("%Y-%m-%d " .. THIN_LEFT_ARROW .. " %H:%M")

		-- local cells = {}
		-- -- An entry for each battery (typically 0 or 1 battery)
		-- for _, b in ipairs(wezterm.battery_info()) do
		-- 	table.insert(
		-- 		cells,
		-- 		wezterm.nerdfonts.md_battery_charging .. " " .. string.format("%.0f%%", b.state_of_charge * 100)
		-- 	)
		-- end

		-- The right_elements to be formatted
		local right_elements = {}
		table.insert(right_elements, { Foreground = { Color = colors.ansi[6] } })
		table.insert(right_elements, { Background = { Color = colors.tab_bar.background } })
		table.insert(right_elements, { Text = " " .. cwd .. " " })

		table.insert(right_elements, { Foreground = { Color = colors.tab_bar.inactive_tab.bg_color } })
		table.insert(right_elements, { Background = { Color = colors.tab_bar.background } })
		table.insert(right_elements, { Text = SOLID_LEFT_ARROW })
		table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.bg_color } })
		table.insert(right_elements, { Background = { Color = colors.tab_bar.inactive_tab.bg_color } })
		table.insert(right_elements, { Text = " " .. date_and_time .. " " })

		-- -- Translate a cell into right_elements
		-- local function push(text, is_last)
		-- 	table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.bg_color } })
		-- 	table.insert(right_elements, { Background = { Color = colors.tab_bar.inactive_tab.bg_color } })
		-- 	table.insert(right_elements, { Text = THIN_LEFT_ARROW })
		-- 	table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.bg_color } })
		-- 	table.insert(right_elements, { Background = { Color = colors.tab_bar.inactive_tab.bg_color } })
		-- 	table.insert(right_elements, { Text = " " .. text .. " " })
		-- 	if is_last then
		-- 		table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.bg_color } })
		-- 		table.insert(right_elements, { Text = THIN_LEFT_ARROW })
		-- 	end
		-- end
		--
		-- while #cells > 0 do
		-- 	local cell = table.remove(cells, 1)
		-- 	push(cell, #cells == 0)
		-- end

		table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.bg_color } })
		table.insert(right_elements, { Background = { Color = colors.tab_bar.inactive_tab.bg_color } })
		table.insert(right_elements, { Text = SOLID_LEFT_ARROW })
		table.insert(right_elements, { Foreground = { Color = colors.tab_bar.active_tab.fg_color } })
		table.insert(right_elements, { Background = { Color = colors.tab_bar.active_tab.bg_color } })
		table.insert(right_elements, { Attribute = { Intensity = "Bold" } })
		table.insert(right_elements, { Text = " " .. hostname .. " " })

		window:set_right_status(wezterm.format(right_elements))
	end)
end

return M
