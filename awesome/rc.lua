pcall(require, "luarocks.loader")

local scratchpad = require("scratchpad")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
--local menubar       = require("menubar")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local mytable = awful.util.table or gears.table -- 4.{0,1} compatibility

if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false

	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end

		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})

		in_error = false
	end)
end

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
	for _, cmd in ipairs(cmd_arr) do
		awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
	end
end

run_once({ "unclutter -root" }) -- comma-separated entries

-- {{{ Variable definitions

local themes = {
	"blackburn", -- 1
	"copland", -- 2
	"dremora", -- 3
	"holo", -- 4
	"multicolor", -- 5
	"powerarrow", -- 6
	"powerarrow-dark", -- 7
	"rainbow", -- 8
	"steamburn", -- 9
	"vertex", -- 10
}

local chosen_theme = themes[7]
local modkey = "Mod4"
local altkey = "Mod1"
local terminal = "alacritty"
local vi_focus = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local editor = os.getenv("EDITOR") or "lvim"
local browser = "firefox"
local browser2 = "brave"

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "scratch" }
awful.layout.layouts = {
	lain.layout.centerwork,
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- {{{ Screen

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
	-- s.mywibox.visible = false
end)

-- }}}

-- {{{ Key bindings

globalkeys = mytable.join(
	-- Destroy all notifications
	awful.key({ "Control" }, "space", function()
		naughty.destroy_all_notifications()
	end, { description = "destroy all notifications", group = "hotkeys" }),

	-- Take a screenshot
	awful.key({ modkey }, "s", function()
		awful.spawn("flameshot gui")
	end, { description = "take a screenshot", group = "hotkeys" }),

	-- Show help
	awful.key({ modkey, "Shift" }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Tag browsing
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	-- Default client focus
	awful.key({ altkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ altkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- By-direction client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		if cycle_prev then
			awful.client.focus.history.previous()
		else
			awful.client.focus.byidx(-1)
		end
		if client.focus then
			client.focus:raise()
		end
	end, { description = "cycle with previous/go back", group = "client" }),

	-- Show/hide wibox
	awful.key({ modkey }, "x", function()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end, { description = "toggle wibox", group = "awesome" }),

	-- On-the-fly useless gaps change
	awful.key({ modkey, "Control" }, "+", function()
		lain.util.useless_gaps_resize(1)
	end, { description = "increment useless gaps", group = "tag" }),
	awful.key({ modkey, "Control" }, "-", function()
		lain.util.useless_gaps_resize(-1)
	end, { description = "decrement useless gaps", group = "tag" }),

	-- Dynamic tagging
	-- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
	--           {description = "move tag to the left", group = "tag"}),
	-- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
	--           {description = "move tag to the right", group = "tag"}),
	-- awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
	--           {description = "delete tag", group = "tag"}),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey, altkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey, altkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	-- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
	--           {description = "select previous", group = "layout"}),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Dropdown application
	-- awful.key({ modkey }, "z", function()
	-- 	awful.screen.focused().quake:toggle()
	-- end, { description = "dropdown application", group = "launcher" }),

	-- Widgets popups
	-- TODO find out which file system this is
	-- awful.key({ altkey }, "h", function()
	-- 	if beautiful.fs then
	-- 		beautiful.fs.show(7)
	-- 	end
	-- end, { description = "show filesystem", group = "widgets" }),

	-- Screen brightness
	-- awful.key({}, "XF86MonBrightnessUp", function()
	-- 	os.execute("xbacklight -inc 10")
	-- end, { description = "+10%", group = "hotkeys" }),
	-- awful.key({}, "XF86MonBrightnessDown", function()
	-- 	os.execute("xbacklight -dec 10")
	-- end, { description = "-10%", group = "hotkeys" }),

	-- ALSA volume control
	awful.key({ altkey }, "Up", function()
		os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({ altkey }, "Down", function()
		os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({ altkey }, "m", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "toggle mute", group = "hotkeys" }),

	-- TODO fix media controll
	-- MPD control
	-- awful.key({ altkey, "Control" }, "Up", function()
	-- 	os.execute("mpc toggle")
	-- 	beautiful.mpd.update()
	-- end, { description = "mpc toggle", group = "widgets" }),
	-- awful.key({ altkey, "Control" }, "Down", function()
	-- 	os.execute("mpc stop")
	-- 	beautiful.mpd.update()
	-- end, { description = "mpc stop", group = "widgets" }),
	-- awful.key({ altkey, "Control" }, "Left", function()
	-- 	os.execute("mpc prev")
	-- 	beautiful.mpd.update()
	-- end, { description = "mpc prev", group = "widgets" }),
	-- awful.key({ altkey, "Control" }, "Right", function()
	-- 	os.execute("mpc next")
	-- 	beautiful.mpd.update()
	-- end, { description = "mpc next", group = "widgets" }),
	-- awful.key({ altkey }, "0", function()
	-- 	local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
	-- 	if beautiful.mpd.timer.started then
	-- 		beautiful.mpd.timer:stop()
	-- 		common.text = common.text .. lain.util.markup.bold("OFF")
	-- 	else
	-- 		beautiful.mpd.timer:start()
	-- 		common.text = common.text .. lain.util.markup.bold("ON")
	-- 	end
	-- 	naughty.notify(common)
	-- end, { description = "mpc on/off", group = "widgets" }),

	-- NO IDEA WHAT THIS DOES
	-- Copy primary to clipboard (terminals to gtk)
	-- awful.key({ modkey }, "c", function()
	-- 	awful.spawn.with_shell("xsel | xsel -i -b")
	-- end, { description = "copy terminal to gtk", group = "hotkeys" }),
	-- Copy clipboard to primary (gtk to terminals)
	-- awful.key({ modkey }, "v", function()
	-- 	awful.spawn.with_shell("xsel -b | xsel")
	-- end, { description = "copy gtk to terminal", group = "hotkeys" }),

	-- User programs
	awful.key({ modkey }, "b", function()
		awful.spawn(browser)
	end, { description = "run browser", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "b", function()
		awful.spawn(browser2)
	end, { description = "run browser2", group = "launcher" }),

	--[[ dmenu
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"}),
    --]]
	-- alternatively use rofi, a dmenu-like application with more features
	-- check https://github.com/DaveDavenport/rofi for more details
	--[[ rofi
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("rofi -show %s -theme %s",
            'run', 'dmenu'))
        end,
        {description = "show rofi", group = "launcher"}),
    --]]
	-- Prompt
	awful.key({ modkey }, "r", function()
		os.execute(
			string.format(
				"dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
				beautiful.bg_normal,
				beautiful.fg_normal,
				beautiful.bg_focus,
				beautiful.fg_focus
			)
		)
	end, { description = "run prompt", group = "launcher" })
)

clientkeys = mytable.join(
	awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, { description = "magnify client", group = "client" }),
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		scratchpad.toggleScratchpad()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = mytable.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = mytable.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			titlebars_enabled = false,
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	-- { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	{
		rule_any = { class = { "spotify", "Spotify", "Signal", "discord" } },
		properties = { screen = 1, tag = "scratch" },
	},
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- Custom
	if beautiful.titlebar_fun then
		beautiful.titlebar_fun(c)
		return
	end

	-- Default
	-- buttons for the titlebar
	local buttons = mytable.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c, { size = 16 }):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- Spotify workaround
client.connect_signal("property::class", function(c)
	if c.class == "Spotify" then
		local scratchpad = awful.tag.find_by_name(awful.screen.focused(), "scratch")
		c:move_to_tag(scratchpad)
	end
end)

-- }}}
-- Hide wiboxes by default
for s in screen do
	s.mywibox.visible = not s.mywibox.visible
	if s.mybottomwibox then
		s.mybottomwibox.visible = not s.mybottomwibox.visible
	end
end

awful.spawn.with_shell("feh --bg-scale ~/Pictures/wallpapers/2.jpg")
awful.spawn.with_shell("xset r rate 285 25")
-- awful.tag.incmwfact(-0.05)

scratchpad.start()
