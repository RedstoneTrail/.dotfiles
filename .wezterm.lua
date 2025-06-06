local wezterm = require("wezterm")
local config  = wezterm.config_builder()

-- pane switching function from github
local function switch_in_direction(dir)
	return function(window)
		local tab = window:active_tab()
		local next_pane = tab:get_pane_direction(dir)
		if next_pane then
			tab.swap_active_with_index(next_pane, true)
		end
	end
end

-- colourscheme (based on the vga ansi colour set)
-- local colourscheme    = {
-- 	dark = {
-- 		black   = "#000000",
-- 		red     = "#AA0000",
-- 		green   = "#00AA00",
-- 		yellow  = "#AA5500",
-- 		blue    = "#0000AA",
-- 		magenta = "#AA00AA",
-- 		cyan    = "#00AAAA",
-- 		white   = "#AAAAAA",
-- 	},
-- 	bright = {
-- 		black   = "#555555",
-- 		red     = "#FF5555",
-- 		green   = "#55FF55",
-- 		yellow  = "#FFFF55",
-- 		blue    = "#5555FF",
-- 		magenta = "#FF55FF",
-- 		cyan    = "#55FFFF",
-- 		white   = "#FFFFFF",
-- 	},
-- }

local colourscheme    = {
	dark = {
		black   = "#000000",
		red     = "#FF0000",
		green   = "#00FF00",
		yellow  = "#FF5500",
		blue    = "#8888FF",
		magenta = "#FF00FF",
		cyan    = "#00DDDD",
		white   = "#FFFFFF",
	},
	bright = {
		black   = "#555555",
		red     = "#FF5555",
		green   = "#55FF55",
		yellow  = "#FFFF55",
		blue    = "#7BE7EE",
		magenta = "#FF55FF",
		cyan    = "#55FFFF",
		white   = "#FFFFFF",
	},
}

local bg_grey         = "#212121"

-- config.font           = wezterm.font "FiraMono Nerd Font"
config.font           = wezterm.font_with_fallback {
	"FiraMono Nerd Font",
	"UnifontExMono",
}

config.font_size      = 9
config.enable_wayland = false

config.window_frame   = {
	inactive_titlebar_bg            = bg_grey,
	active_titlebar_bg              = bg_grey,
	inactive_titlebar_fg            = bg_grey,
	active_titlebar_fg              = bg_grey,
	inactive_titlebar_border_bottom = bg_grey,
	active_titlebar_border_bottom   = bg_grey,
	button_fg                       = bg_grey,
	button_bg                       = bg_grey,
	button_hover_fg                 = bg_grey,
	button_hover_bg                 = bg_grey,

	border_left_width               = "0cell",
	border_right_width              = "0cell",
	border_bottom_height            = "0cell",
	border_top_height               = "0cell",

	font                            = wezterm.font("FiraMono Nerd Font"),
	font_size                       = 9,
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime(" %S:%M:%H / %d-%m-%Y")

	local battery_colour = bg_grey

	local charge = 0

	local battery_info
	local state

	for _, battery in ipairs(wezterm.battery_info()) do
		battery_info = battery
		charge = battery.state_of_charge
		state = battery.state
	end

	if charge <= 0.1 then
		battery_colour = colourscheme.dark.red
	elseif charge <= 0.25 then
		battery_colour = colourscheme.dark.yellow
	elseif charge <= 0.5 then
		battery_colour = colourscheme.bright.yellow
	elseif charge <= 0.75 then
		battery_colour = colourscheme.dark.green
	elseif charge <= 1 then
		battery_colour = colourscheme.bright.green
	end

	if state == "Unknown" then
		state = "Not charging"
	end

	local time_remaining = ""
	local time

	if state == "Charging" then
		time_remaining = time_remaining .. " for"
		time = math.floor(battery_info.time_to_full + 0.5)

		local hours = time // 3600
		local minutes = (time % 3600) // 60
		local seconds = (time & 60)

		if time >= 3600 then
			time_remaining = time_remaining .. " " ..
			    tostring(hours) .. "h"
		end

		if time >= 60 then
			time_remaining = time_remaining .. " " ..
			    tostring(minutes) .. "m"
			time = time - (math.floor(time / 60 + 0.5) * 60)
		end

		time_remaining = time_remaining .. " " .. tostring(seconds) .. "s"
	elseif state == "Discharging" then
		time_remaining = time_remaining .. " for"
		time = math.floor(battery_info.time_to_empty + 0.5)

		local hours = time // 3600
		local minutes = (time % 3600) // 60
		local seconds = time % 60

		if time >= 3600 then
			time_remaining = time_remaining .. " " ..
			    tostring(hours) .. "h"
		end

		if time >= 60 then
			time_remaining = time_remaining .. " " ..
			    tostring(minutes) .. "m"
			time = time - (math.floor(time / 60 + 0.5) * 60)
		end

		time_remaining = time_remaining .. " " .. tostring(seconds) .. "s"
	else
		time_remaining = ""
	end

	window:set_right_status(wezterm.format {
		{
			Foreground = {
				Color = colourscheme.dark.black,
			},
		},
		{
			Background = {
				Color = battery_colour,
			},
		},
		{
			Text = " " .. tostring(math.floor(charge * 100 + 0.5)) .. "% " .. state .. time_remaining .. " ",
		},
		"ResetAttributes",
		{
			Foreground = {
				Color = colourscheme.dark.green,
			},
		},
		{
			Background = {
				Color = bg_grey,
			},
		},
		{
			Text = date,
		},
	})
end)

wezterm.on("bell", function(window, pane)
	os.execute("notify-send -u low -a wezterm \"a bell was rung by tty " ..
		pane:get_tty_name() .. "\" \"time: " .. os.time() .. "\"")
end)

config.visual_bell              = {
	fade_in_duration_ms = 150,
	fade_in_function = "EaseInOut",
	fade_out_duration_ms = 150,
	fade_out_function = "EaseInOut",
}

-- not available in stable yet
config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}

config.use_fancy_tab_bar        = false
config.tab_bar_at_bottom        = true

config.leader                   = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

config.keys                     = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain"
		}),
	},
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain"
		}),
	},
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({
			key = "a",
			mods = "CTRL",
		}),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "h",
		mods = "META",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "META",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "META",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "META",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "META|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Left",
			1,
		}),
	},
	{
		key = "j",
		mods = "META|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Down",
			1,
		}),
	},
	{
		key = "k",
		mods = "META|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Up",
			1,
		}),
	},
	{
		key = "l",
		mods = "META|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Right",
			1,
		}),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({
			confirm = true,
		}),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "Escape",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "Tab",
		mods = "META",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActiveKeepFocus",
		}),
	},
	{
		key = "h",
		mods = "CTRL|META",
		action = wezterm.action_callback(switch_in_direction("Left")),
	},
	{
		key = "j",
		mods = "CTRL|META",
		action = wezterm.action_callback(switch_in_direction("Down")),
	},
	{
		key = "k",
		mods = "CTRL|META",
		action = wezterm.action_callback(switch_in_direction("Up")),
	},
	{
		key = "l",
		mods = "CTRL|META",
		action = wezterm.action_callback(switch_in_direction("Right")),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

config.key_tables               = {
	copy_mode = {
		{
			key = "/",
			mods = "",
			action = wezterm.action.CopyMode("EditPattern"),
		},
		{
			key = "j",
			mods = "SHIFT",
			action = wezterm.action.Multiple({
				wezterm.action.CopyMode("MoveToViewportBottom"),
				wezterm.action.CopyMode("MoveDown"),
			}),
		},
		{
			key = "k",
			mods = "SHIFT",
			action = wezterm.action.Multiple({
				wezterm.action.CopyMode("MoveToViewportTop"),
				wezterm.action.CopyMode("MoveUp"),
			}),
		},
		{
			key = "j",
			mods = "",
			action = wezterm.action.CopyMode("MoveDown"),
		},
		{
			key = "k",
			mods = "",
			action = wezterm.action.CopyMode("MoveUp"),
		},
		{
			key = "h",
			mods = "",
			action = wezterm.action.CopyMode("MoveLeft"),
		},
		{
			key = "l",
			mods = "",
			action = wezterm.action.CopyMode("MoveRight"),
		},
		{
			key = "q",
			mods = "",
			action = wezterm.action.Multiple({
				wezterm.action.CopyMode("MoveToScrollbackBottom"),
				wezterm.action.CopyMode("Close"),
			}),
		},
		{
			key = "Escape",
			mods = "",
			action = wezterm.action.Multiple({
				wezterm.action.CopyMode("MoveToScrollbackBottom"),
				wezterm.action.CopyMode("Close"),
			}),
		},
		{
			key = "v",
			mods = "",
			action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }),
		},
		{
			key = "V",
			mods = "",
			action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "V",
			mods = "SHIFT",
			action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "G",
			mods = "",
			action = wezterm.action.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "G",
			mods = "SHIFT",
			action = wezterm.action.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "g",
			mods = "",
			action = wezterm.action.CopyMode("MoveToScrollbackTop"),
		},
		{
			key = "z",
			mods = "",
			action = wezterm.action.CopyMode("MoveToViewportMiddle"),
		},
		{
			key = "Enter",
			mods = "",
			action = wezterm.action.CopyMode("MoveToStartOfNextLine"),
		},
		{
			key = "y",
			mods = "",
			action = wezterm.action.Multiple({
				wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
				wezterm.action.CopyMode("ClearSelectionMode"),
				wezterm.action.CopyMode("MoveToViewportBottom"),
				wezterm.action.CopyMode("MoveDown"),
				wezterm.action.CopyMode("Close"),
			}),
		},
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

config.colors = {
	visual_bell = colourscheme.dark.yellow,

	tab_bar = {
		background = bg_grey,

		active_tab = {
			bg_color = colourscheme.dark.green,
			fg_color = colourscheme.dark.black,
		},

		inactive_tab = {
			bg_color = bg_grey,
			fg_color = colourscheme.dark.green,
		},

		inactive_tab_hover = {
			bg_color = bg_grey,
			fg_color = colourscheme.dark.green,
			italic = false,
		},

		new_tab = {
			bg_color = bg_grey,
			fg_color = bg_grey,
		},

		new_tab_hover = {
			bg_color = bg_grey,
			fg_color = colourscheme.dark.green,
		},
	},

	foreground = colourscheme.dark.white,
	background = bg_grey,

	cursor_bg = colourscheme.bright.white,
	cursor_fg = colourscheme.dark.black,
	cursor_border = colourscheme.bright.white,

	selection_fg = colourscheme.dark.black,
	selection_bg = colourscheme.dark.green,

	split = colourscheme.bright.white,

	ansi = {
		colourscheme.dark.black,
		colourscheme.dark.red,
		colourscheme.dark.green,
		colourscheme.dark.yellow,
		colourscheme.dark.blue,
		colourscheme.dark.magenta,
		colourscheme.dark.cyan,
		colourscheme.dark.white,
	},
	brights = {
		colourscheme.bright.black,
		colourscheme.bright.red,
		colourscheme.bright.green,
		colourscheme.bright.yellow,
		colourscheme.bright.blue,
		colourscheme.bright.magenta,
		colourscheme.bright.cyan,
		colourscheme.bright.white,
	},

	compose_cursor = colourscheme.dark.yellow,

	copy_mode_active_highlight_bg = { Color = colourscheme.dark.green },
	copy_mode_active_highlight_fg = { Color = colourscheme.dark.black },
	copy_mode_inactive_highlight_bg = { Color = colourscheme.bright.green },
	copy_mode_inactive_highlight_fg = { Color = colourscheme.dark.black },

	quick_select_label_bg = { Color = colourscheme.dark.green },
	quick_select_label_fg = { Color = colourscheme.dark.black },
	quick_select_match_bg = { Color = colourscheme.dark.blue },
	quick_select_match_fg = { Color = colourscheme.dark.black },

	input_selector_label_bg = { AnsiColor = "Black" },
	input_selector_label_fg = { Color = "#ffffff" },

	launcher_label_bg = { AnsiColor = "Black" },
	launcher_label_fg = { Color = "#ffffff" },
}

config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 0.5,
}

return config
