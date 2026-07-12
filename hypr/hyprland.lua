-- new lua format test

function get_host()
	local f = io.popen("/bin/hostname")
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")
	return hostname
end

local host = get_host()

if host == "bosco" then
	hl.monitor({
		output = "",
		mode = "1366x768@60",
		position = "auto",
		scale = "1",
	})
elseif host == "karl" then
	hl.monitor({
		output = "",
		mode = "2560x1600@165",
		position = "auto",
		scale = "1",
	})
end

local term = "alacritty"

if host == "karl" then
	term = "alacritty --config-file " .. os.getenv("HOME") .. "/.dotfiles/alacritty/karl.toml"
elseif host == "bosco" then
	term = "alacritty --config-file " .. os.getenv("HOME") .. "/.dotfiles/alacritty/bosco.toml"
end

local browser = "firefox"
local editor = "nvim"
local launcher = "fuzzel"

hl.on("hyprland.start", function()
	print("hyprland.start")

	local onstart_programs = {
		"waybar",
		"systemctl start hyprpolkitagent --user",
		"dunst",
		"poweralertd",
		"mpris-proxy",
	}

	for _, prog in ipairs(onstart_programs) do
		print("starting " .. prog)

		hl.exec_cmd(prog)
	end

	hl.dispatch(hl.dsp.submap("normal"))
end)

local function env(environ_table)
	for _, entry in ipairs(environ_table) do
		print(entry[1] .. "=" .. entry[2])

		hl.env(entry[1], entry[2])
	end
end

env({
	{ "BROWSER", browser },
	{ "TERM", term },
	{ "TERMINAL", term },
	{ "EDITOR", editor },
	{ "VISUAL", editor },

	{ "XCURSOR_SIZE", "24" },

	{ "XDG_CURRENT_DESKTOP", "Hyprland" },
	{ "XDG_SESSION_TYPE", "wayland" },
	{ "XDG_SESSION_DESKTOP", "Hyprland" },
	{ "GTK_USE_PORTAL", "1" },

	{ "PATH", os.getenv("PATH") .. ":/home/redstonetrail/.dotfiles/scripts" },

	{ "NIXOS_OZONE_WL", "1" },
	{ "XCURSOR_SIZE", "24" },

	{ "HYPRCURSOR_SIZE", "24" },
	{ "HYPRCURSOR_THEME", "catppuccin-frappe-green-cursors" },
})

local borders = {
	active = "0xff00AA00",
	inactive = "0xff077000",
}

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
	misc = {
		enable_anr_dialog = false,
		force_default_wallpaper = true,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 1,
	},
	input = {
		kb_layout = "gb",
		kb_options = "compose:menu",

		repeat_rate = 50,
		repeat_delay = 300,

		sensitivity = 1,
		accel_profile = "flat",

		touchpad = {
			scroll_factor = 0.75,
			clickfinger_behavior = true,
			tap_and_drag = true,
			drag_lock = 1,
			disable_while_typing = false,
		},
	},
	cursor = {
		hide_on_key_press = true,
	},
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 3,

		col = {
			inactive_border = borders.inactive,
			active_border = borders.active,
		},

		no_focus_fallback = true,
	},
	decoration = {
		blur = {
			size = 2,
			ignore_opacity = false,
			vibrancy = 0,
		},
		shadow = {
			enabled = false,
		},
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	debug = {
		disable_logs = false,
	},
})

if host == "karl" then
	hl.device({
		name = "ftcs0038:00-2808:0106-touchpad",
		sensitivity = 1,
	})
end

local function base_bindings()
	-- media keys
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl-wrapper play-pause"))
	hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl-wrapper stop"))
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl-wrapper next"))
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl-wrapper previous"))

	hl.bind("ALT + XF86AudioPlay", hl.dsp.exec_cmd("playerctl-wrapper play"))
	hl.bind("ALT + XF86AudioStop", hl.dsp.exec_cmd("playerctl-wrapper pause"))
	hl.bind("ALT + XF86AudioNext", hl.dsp.exec_cmd("playerctl-wrapper position 5+"))
	hl.bind("ALT + XF86AudioPrev", hl.dsp.exec_cmd("playerctl-wrapper position 5-"))
	hl.bind("SHIFT + XF86AudioPlay", function()
		local submap = hl.get_current_submap()

		hl.dispatch(hl.dsp.submap("passthru"))
		hl.exec_cmd("select-player && hyprctl eval 'hl.dispatch(hl.dsp.submap(\"" .. submap .. "\"))'")
	end)

	-- volume keys
	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
	hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +1%"))
	hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -1%"))
	hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ +5%"))
	hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ -5%"))
	hl.bind("SHIFT + ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ +5%"))
	hl.bind("SHIFT + ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ -5%"))

	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
	hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SORUCE@ toggle"))

	-- brightness keys
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"))
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))
	hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1%+"))
	hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"))
	hl.bind("CONTROL + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1+"))
	hl.bind("CONTROL + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1-"))

	-- special
	hl.bind("XF86RefreshRateToggle", hl.dsp.exec_cmd("cycle-resolution"))
	hl.bind("code:78", hl.dsp.exec_cmd("toggle-inhibit"))

	-- touchpad toggle
	if host == "bosco" then
		local touchpad_enabled = true

		hl.device({
			name = "elan-touchpad",
			enabled = touchpad_enabled,
		})

		hl.bind("XF86TouchpadToggle", function()
			touchpad_enabled = not touchpad_enabled

			hl.device({
				name = "elan-touchpad",
				enabled = touchpad_enabled,
			})
		end)
	end
end

-- window rules
hl.window_rule({
	match = { title = "Picture-in-picture$" },
	float = true,
	pin = true,
	size = { "(monitor_w * 0.2)", "(monitor_h * 0.2)" },
})

SCREENSHOT_AREA_MODES = {
	screen = 0,
	window = 1,
	selection = 2,
}

SCREENSHOT_DESTINATION_MODES = {
	file = 0,
	mpv = 1,
	clipboard = 2,
}

local screenshot_mode = { area = SCREENSHOT_AREA_MODES.selection, dest = SCREENSHOT_DESTINATION_MODES.clipboard }
local screenshot_mode_file = "/tmp/screenshot-mode"

local function update_screenshot_mode_file()
	local area_string = ""
	local dest_string = ""

	if screenshot_mode.area == SCREENSHOT_AREA_MODES.screen then
		area_string = "screen"
	elseif screenshot_mode.area == SCREENSHOT_AREA_MODES.window then
		area_string = "window"
	elseif screenshot_mode.area == SCREENSHOT_AREA_MODES.selection then
		area_string = "selection"
	end

	if screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.file then
		dest_string = "file"
	elseif screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.mpv then
		dest_string = "mpv"
	elseif screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.clipboard then
		dest_string = "clipboard"
	end

	os.execute("echo " .. area_string .. "," .. dest_string .. " > " .. screenshot_mode_file)
	os.execute("pkill -RTMIN+1 waybar")
end

local function remove_screenshot_mode_file()
	os.execute("rm " .. screenshot_mode_file)
	os.execute("pkill -RTMIN+1 waybar")
end

local function screenshot()
	local selection = ""
	local dest = "- | wl-copy"

	if screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.clipboard then
		dest = " - | wl-copy"
	elseif screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.file then
		dest = ""
	elseif screenshot_mode.dest == SCREENSHOT_DESTINATION_MODES.mpv then
		dest = " - | mpv --keep-open -"
	end

	if screenshot_mode.area == SCREENSHOT_AREA_MODES.screen then
		selection = ""
	elseif screenshot_mode.area == SCREENSHOT_AREA_MODES.selection then
		selection = '-g "$(slurp)"'
		hl.dispatch(hl.dsp.submap("passthru"))
	elseif screenshot_mode.area == SCREENSHOT_AREA_MODES.window then
		local window = hl.get_active_window()

		if window == nil then
			return
		end

		local area_selection = window.at.x .. "," .. window.at.y .. " " .. window.size.x .. "x" .. window.size.y

		selection = '-g "' .. area_selection .. '"'
	end

	hl.exec_cmd("grim " .. selection .. dest .. " && hyprctl eval 'hl.dispatch(hl.dsp.submap('\\''normal'\\''))'")

	if screenshot_mode.area ~= SCREENSHOT_AREA_MODES.selection then
		hl.dispatch(hl.dsp.submap("normal"))
	end

	remove_screenshot_mode_file()
end

hl.define_submap("screenshot", function()
	hl.bind("catchall", function() end)

	base_bindings()

	hl.bind("i", function()
		hl.dispatch(hl.dsp.submap("passthru"))
		remove_screenshot_mode_file()
	end)
	hl.bind("m", function()
		hl.dispatch(hl.dsp.submap("move/resize"))
		remove_screenshot_mode_file()
	end)
	hl.bind("SUPER_L", function()
		hl.dispatch(hl.dsp.submap("normal"))
		remove_screenshot_mode_file()
	end)

	hl.bind("s", function()
		screenshot_mode.area = screenshot_mode.area + 1

		if screenshot_mode.area > SCREENSHOT_AREA_MODES.selection then
			screenshot_mode.area = SCREENSHOT_AREA_MODES.screen
		end

		update_screenshot_mode_file()
	end)
	hl.bind("d", function()
		screenshot_mode.dest = screenshot_mode.dest + 1

		if screenshot_mode.dest > SCREENSHOT_DESTINATION_MODES.clipboard then
			screenshot_mode.dest = SCREENSHOT_DESTINATION_MODES.file
		end

		update_screenshot_mode_file()
	end)

	hl.bind("Return", screenshot)
end)

hl.on("keybinds.submap", function(submap)
	if submap == "screenshot" then
		hl.exec_cmd("touch " .. screenshot_mode_file)
		update_screenshot_mode_file()
	end
end)

hl.define_submap("normal", function()
	hl.bind("catchall", function() end)

	base_bindings()

	hl.bind("i", hl.dsp.submap("passthru"))
	hl.bind("m", hl.dsp.submap("move/resize"))
	hl.bind("Print", hl.dsp.submap("screenshot"))
	hl.bind("SHIFT + Print", screenshot)
	hl.bind("ALT + Print", function()
		local submap = hl.get_current_submap()

		hl.dispatch(hl.dsp.submap("passthru"))
		hl.exec_cmd("hyprpicker -a && hyprctl eval 'hl.dispatch(hl.dsp.submap(\"" .. submap .. "\"))'")
	end)

	hl.bind("SHIFT + ALT + q", hl.dsp.exit())

	hl.bind("b", hl.dsp.exec_cmd(browser))
	hl.bind("Return", hl.dsp.exec_cmd(term))
	hl.bind("SHIFT + V", hl.dsp.exec_cmd("virt-manager"))
	hl.bind("w", function()
		hl.exec_cmd(launcher .. " && hyprctl eval 'hl.dispatch(hl.dsp.submap('\\''normal'\\''))'")
		hl.dispatch(hl.dsp.submap("passthru"))
	end)

	hl.bind("n", function()
		hl.exec_cmd(
			term .. " --title impala -e impala",
			{ float = true, size = { "(monitor_w * 0.3)", "(monitor_h * 0.4)" } }
		)
		hl.dispatch(hl.dsp.submap("passthru"))
	end)
	hl.bind("SHIFT + n", function()
		hl.exec_cmd(
			term .. " --title bluetui -e bluetui",
			{ float = true, size = { "(monitor_w * 0.3)", "(monitor_h * 0.4)" } }
		)
		hl.dispatch(hl.dsp.submap("passthru"))
	end)

	hl.bind("d", hl.dsp.window.close())
	hl.bind("CONTROL + d", hl.dsp.window.kill())

	hl.bind("H", hl.dsp.focus({ direction = "left" }))
	hl.bind("J", hl.dsp.focus({ direction = "down" }))
	hl.bind("K", hl.dsp.focus({ direction = "up" }))
	hl.bind("L", hl.dsp.focus({ direction = "right" }))
	hl.bind("TAB", hl.dsp.window.cycle_next({ next = false }))
	hl.bind("SHIFT + TAB", hl.dsp.window.cycle_next({ next = true }))

	hl.bind("V", hl.dsp.window.float({}))
	hl.bind("P", hl.dsp.window.pin({}))
	hl.bind("F", hl.dsp.window.fullscreen({}))
	hl.bind("CONTROL + F", hl.dsp.window.fullscreen_state({ internal = 1, client = 0 }))
	hl.bind("SHIFT + F", function()
		local window = hl.get_active_window()

		if window == nil then
			return
		end

		if window.fullscreen ~= window.fullscreen_client and window.fullscreen_client == 2 then
			hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = 0 }))

			hl.dispatch(hl.dsp.window.set_prop({
				prop = "active_border_color",
				value = borders.active,
				window = window,
			}))
			hl.dispatch(hl.dsp.window.set_prop({
				prop = "inactive_border_color",
				value = borders.inactive,
				window = window,
			}))
		else
			hl.dispatch(hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }))

			hl.dispatch(hl.dsp.window.set_prop({
				prop = "active_border_color",
				value = "0xFFFF0000",
				window = window,
			}))
			hl.dispatch(hl.dsp.window.set_prop({
				prop = "inactive_border_color",
				value = "0xFFAA0000",
				window = window,
			}))
		end
	end)

	hl.bind("escape", hl.dsp.exec_cmd("pkill -USR1 waybar"))

	hl.bind("SPACE", hl.dsp.exec_cmd("dunstctl close"))
	hl.bind("SHIFT + SPACE", hl.dsp.exec_cmd("dunstctl close-all"))
	hl.bind("CONTROL + SPACE", hl.dsp.exec_cmd("dunstctl context"))

	hl.bind("T", function()
		hl.dispatch(hl.dsp.exec_cmd("set-timer"))
		hl.dispatch(hl.dsp.submap("passthru"))
	end)
	hl.bind("SHIFT + T", function()
		hl.dispatch(hl.dsp.exec_cmd("stop-timer"))
		hl.dispatch(hl.dsp.submap("passthru"))
	end)

	for i = 1, 10 do
		local key = i % 10
		hl.bind("" .. key, hl.dsp.focus({ workspace = i }))
		hl.bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	hl.bind("S", hl.dsp.exec_cmd("lock"))
	hl.bind("SHIFT + S", hl.dsp.exec_cmd("lock hibernate"))
	hl.bind("ALT + S", hl.dsp.exec_cmd("lock sleep"))
	hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("lock lid"))

	hl.bind("ALT + Q", hl.dsp.window.close())
	hl.bind("ALT + SHIFT + Q", hl.dsp.window.kill())
	hl.bind("CONTROL + Q", hl.dsp.exec_cmd("hyprctl kill"))
end)

hl.define_submap("move/resize", function()
	hl.bind("catchall", function() end)

	base_bindings()

	hl.bind("i", hl.dsp.submap("passthru"))
	hl.bind("SUPER_L", hl.dsp.submap("normal"))

	hl.bind("h", hl.dsp.window.move({ direction = "left" }))
	hl.bind("j", hl.dsp.window.move({ direction = "down" }))
	hl.bind("k", hl.dsp.window.move({ direction = "up" }))
	hl.bind("l", hl.dsp.window.move({ direction = "right" }))

	hl.bind("ALT + h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("ALT + j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("ALT + k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("ALT + l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

	hl.bind("ALT + SHIFT + h", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
	hl.bind("ALT + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
	hl.bind("ALT + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
	hl.bind("ALT + SHIFT + l", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })

	hl.bind("ALT + CONTROL + h", hl.dsp.window.resize({ x = -1, y = 0, relative = true }), { repeating = true })
	hl.bind("ALT + CONTROL + j", hl.dsp.window.resize({ x = 0, y = 1, relative = true }), { repeating = true })
	hl.bind("ALT + CONTROL + k", hl.dsp.window.resize({ x = 0, y = -1, relative = true }), { repeating = true })
	hl.bind("ALT + CONTROL + l", hl.dsp.window.resize({ x = 1, y = 0, relative = true }), { repeating = true })

	hl.bind("v", hl.dsp.window.float({}))
	hl.bind("p", hl.dsp.window.pin({}))
	hl.bind("m", hl.dsp.layout("togglesplit"))

	hl.bind("ISO_Level3_Shift", hl.dsp.window.drag(), { mouse = true })
	hl.bind("CONTROL_R", hl.dsp.window.resize(), { mouse = true })

	-- do not currently work
	-- hl.bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
	-- hl.bind("mouse:273", hl.dsp.window.resize(), { mouse = true })
end)

hl.define_submap("passthru", function()
	hl.bind("SUPER_L", hl.dsp.submap("normal"))

	base_bindings()
end)
