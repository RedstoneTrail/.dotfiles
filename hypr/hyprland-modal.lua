-- new lua format test

hl.monitor({
	output = "",
	mode = "highrr",
	position = "auto",
	scale = "1",
})

local term = "alacritty"
local browser = "firefox"
local editor = "nvim"
local launcher = "fuzzel"

hl.on("hyprland.start", function()
	print("hyprland.start")

	local onstart_programs = {
		"waybar",
		-- "systemctl start hyprpolkitagent --user",
		-- "dunst",
		-- "poweralertd",
		-- "mpris-proxy",
	}

	for _, prog in ipairs(onstart_programs) do
		print("starting " .. prog)

		hl.exec_cmd(prog)
	end

	hl.dispatch(hl.dsp.submap("normal"))
end)

-- local env = hl.env

local function env(environ_table)
	for _, entry in ipairs(environ_table) do
		print(entry[1] .. "=" .. entry[2])

		hl.env(entry[1], entry[2])
	end
end

env {
	{ "BROWSER",             browser },
	{ "TERM",                term },
	{ "TERMINAL",            term },
	{ "EDITOR",              editor },
	{ "VISUAL",              editor },

	{ "XCURSOR_SIZE",        "24" },

	{ "XDG_CURRENT_DESKTOP", "Hyprland" },
	{ "XDG_SESSION_TYPE",    "wayland" },
	{ "XDG_SESSION_DESKTOP", "Hyprland" },
	{ "LIBVA_DRIVER_NAME",   "nvidia" },
	{ "GTK_USE_PORTAL",      "1" },

	{ "PATH",                os.getenv("PATH") .. ":/home/redstonetrail/.dotfiles/scripts" },

	{ "NIXOS_OZONE_WL",      "1" },
	{ "XCURSOR_SIZE",        "24" },

	{ "HYPRCURSOR_SIZE",     "24" },
	{ "HYPRCURSOR_THEME",    "catppuccin-frappe-green-cursors" },
}

hl.config {
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
			inactive_border = "0xff077000",
			active_border = "0xff00AA00",
		},

		no_focus_fallback = true
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
	-- master = {
	-- 	allow_small_split = true,
	-- 	mfact = 0.5,
	-- 	orientation = "right",
	-- },
	debug = {
		disable_logs = false,
	},
}

hl.device {
	name = "ftcs0038:00-2808:0106-touchpad",
	sensitivity = 1,
}

-- modes = {
-- 	-- the mode to go to to disable all binds, useful for when popups open
-- 	nobinds = 0,
-- 	-- binds in this mode are always active except in nobinds
-- 	all = 1,
-- 	-- has bindings for launching stuff and entering different modes
-- 	normal = 2,
-- 	-- has no bindings other than to return to normal
-- 	passthru = 3,
-- }

-- mode = modes.normal

-- local function bind(target_mode, input, dispatcher, opts)
-- 	if type(target_mode) == "number" then
-- 		return {
-- 			mode = target_mode,
-- 			bind = hl.bind(input, dispatcher, opts)
-- 		}
-- 	end

-- 	if type(target_mode) == "table" then
-- 		local result_table = {}

-- 		for i, m in ipairs(target_mode) do
-- 			result_table[i] = bind(m, input, dispatcher, opts)
-- 		end

-- 		return table.unpack(result_table)
-- 	end
-- end

-- mode_file = "/tmp/current-mode"

-- function set_mode(target_mode)
-- 	os.execute("notify-send -a mode-change \"changing mode to " .. target_mode .. "\"")

-- 	mode = target_mode

-- 	if mode == modes.normal then
-- 		os.execute("echo normal > " .. mode_file)
-- 	elseif mode == modes.passthru then
-- 		os.execute("echo passthru > " .. mode_file)
-- 	end

-- 	for _, binding in ipairs(BINDS) do
-- 		if binding.mode == mode or (binding.mode == modes.all and mode ~= modes.nobinds) then
-- 			binding.bind:set_enabled(true)
-- 		else
-- 			binding.bind:set_enabled(false)
-- 		end
-- 	end
-- end

BINDS = {
	-- mode change binds

	-- normal mode binds
}


-- bind(modes.normal, "e", function()
-- 	set_mode(modes.nobinds)
-- 	hl.exec_cmd("hl-exec-then " .. launcher .. " set_mode\\(modes.normal\\)")
-- end)


-- media keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl-wrapper play-pause"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl-wrapper stop"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl-wrapper next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl-wrapper previous"))

hl.bind("ALT + XF86AudioPlay", hl.dsp.exec_cmd("playerctl-wrapper play"))
hl.bind("ALT + XF86AudioStop", hl.dsp.exec_cmd("playerctl-wrapper pause"))
hl.bind("ALT + XF86AudioNext", hl.dsp.exec_cmd("playerctl-wrapper position 5+"))
hl.bind("ALT + XF86AudioPrev", hl.dsp.exec_cmd("playerctl-wrapper position 5-"))
hl.bind("SUPER + ALT + XF86AudioPlay", hl.dsp.exec_cmd("select-player"))

hl.define_submap("normal", function()
	hl.bind("catchall", function() end)

	hl.bind("i", hl.dsp.submap("passthru"))
	hl.bind("m", hl.dsp.submap("move/resize"))
	hl.bind("Print", hl.dsp.submap("screenshot"))

	hl.bind("SHIFT + ALT + q", hl.dsp.exit())

	hl.bind("b", hl.dsp.exec_cmd(browser))
	hl.bind("Return", hl.dsp.exec_cmd(term))
	hl.bind("w", function()
		hl.exec_cmd(launcher)
		hl.dispatch(hl.dsp.submap("passthru"))
	end)

	hl.bind("d", hl.dsp.window.close())
	hl.bind("CONTROL + d", hl.dsp.window.kill())

	hl.bind("h", hl.dsp.focus({ direction = "left" }))
	hl.bind("j", hl.dsp.focus({ direction = "down" }))
	hl.bind("k", hl.dsp.focus({ direction = "up" }))
	hl.bind("l", hl.dsp.focus({ direction = "right" }))

	for i = 1, 10 do
		local key = i % 10
		hl.bind("" .. key, hl.dsp.focus({ workspace = i }))
		hl.bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end
end)

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
local screenshot_lockfile = "/tmp/screenshot-lock"
local screenshot_area_outfile = "/tmp/screenshot-area"

hl.define_submap("screenshot", function()
	hl.bind("catchall", function() end)

	hl.bind("SUPER_L", hl.dsp.submap("normal"))

	hl.bind("Return", function()
		local preexec = "touch " .. screenshot_lockfile .. "; "
		local postexec = "; rm " .. screenshot_lockfile

		if (screenshot_mode.area == SCREENSHOT_AREA_MODES.screen) then
			hl.exec_cmd(preexec .. "slurp > " .. screenshot_area_outfile .. postexec)
		elseif (screenshot_mode.area == SCREENSHOT_AREA_MODES.window) then
			hl.exec_cmd(preexec ..
				"hyprctl -j activewindow | jq -r \\(.at[0]\\),\\(.at[1]\\) \\(.size[0]\\)x\\(.size[1]\\) > " ..
				screenshot_area_outfile .. postexec)
			-- hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
		end
	end)
end)

hl.define_submap("move/resize", function()
	hl.bind("catchall", function() end)

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
end)

hl.define_submap("passthru", function()
	hl.bind("SUPER_L", hl.dsp.submap("normal"))
end)
