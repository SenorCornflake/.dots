local gears = require "gears"
local awful = require "awful"

local util = require "util"

local global_keys = gears.table.join(
	-----------------
	-- DIRECTIONAL --
	-----------------
	-- Focus
	awful.key(
		{"Mod4"},
		"h",
		function()
			awful.client.focus.global_bydirection("left")
		end
	),
	awful.key(
		{"Mod4"},
		"j",
		function()
			awful.client.focus.global_bydirection("down")
		end
	),
	awful.key(
		{"Mod4"},
		"k",
		function()
			awful.client.focus.global_bydirection("up")
		end
	),
	awful.key(
		{"Mod4"},
		"l",
		function()
			awful.client.focus.global_bydirection("right")
		end
	),
	-- Swap
	awful.key(
		{"Mod4", "Shift"},
		"h",
		function()
			awful.client.swap.global_bydirection("left")
		end
	),
	awful.key(
		{"Mod4", "Shift"},
		"j",
		function()
			awful.client.swap.global_bydirection("down")
		end
	),
	awful.key(
		{"Mod4", "Shift"},
		"k",
		function()
			awful.client.swap.global_bydirection("up")
		end
	),
	awful.key(
		{"Mod4", "Shift"},
		"l",
		function()
			awful.client.swap.global_bydirection("right")
		end
	),

	-------------
	-- SCREENS --
	-------------
	awful.key(
		{"Mod4"},
		"d",
		function()
			awful.screen.focus_relative(1)
		end
	),
	awful.key(
		{"Mod4", "Shift"},
		"d",
		function()
			util.move_through_screens()
		end
	),
	-------------
	-- AWESOME --
	-------------
	awful.key(
		{"Mod4", "Shift"},
		"r",
		awesome.restart
	),
	awful.key(
		{"Mod4", "Shift"},
		"q",
		awesome.quit
	),

	-----------
	-- OTHER --
	-----------
	awful.key(
		{"Mod4"},
		"space",
		function ()
			awful.layout.inc(1)
		end
	),

	-- Master factor
	awful.key(
		{"Mod4", "Control"},
		"l",
		function ()
			local c = client.focus
			if c.floating then
				c:relative_move(0, 0, 40, 0)
			else
				awful.tag.incmwfact(0.02)
			end
		end
	),
	awful.key(
		{"Mod4", "Control"},
		"h",
		function ()
			local c = client.focus
			if c.floating then
				c:relative_move(0, 0, -40, 0)
			else
				awful.tag.incmwfact(-0.02)
			end
		end
	),

	-- Client Factor
	awful.key(
		{"Mod4", "Control"},
		"k",
		function ()
			local c = client.focus
			if c.floating then
				c:relative_move(0, 0, 0, -40)
			else
				awful.client.incwfact(0.05)
			end
		end
	),
	awful.key(
		{"Mod4", "Control"},
		"j",
		function ()
			local c = client.focus
			if c.floating then
				c:relative_move(0, 0, 0, 40)
			else
				awful.client.incwfact(-0.05)
			end
		end
	),
	
	-- Moving
	awful.key(
		{"Mod4", "Mod1"},
		"h",
		function ()
			local c = client.focus
			c:relative_move(-40, 0, 0, 0)
		end
	),
	awful.key(
		{"Mod4", "Mod1"},
		"j",
		function ()
			local c = client.focus
			c:relative_move(0, 40, 0, 0)
		end
	),
	awful.key(
		{"Mod4", "Mod1"},
		"k",
		function ()
			local c = client.focus
			c:relative_move(0, -40, 0, 0)
		end
	),
	awful.key(
		{"Mod4", "Mod1"},
		"l",
		function ()
			local c = client.focus
			c:relative_move(40, 0, 0, 0)
		end
	),

	-- Non Awesome Related
	awful.key(
		{"Mod4"},
		"Return",
		function()
			awful.spawn("alacritty")
		end
	),
	awful.key(
		{"Mod4"},
		"a",
		function ()
			awful.spawn("rofi -modi drun -show drun")
		end
	),
	awful.key(
		{"Mod4"},
		"c",
		function ()
			--awful.spawn("python ~/MAIN/commander/main.py ~/MAIN/commander/commands.json")
			os.execute("python ~/MAIN/commander/main.py ~/MAIN/commander/commands.json")
		end
	),
	awful.key(
		{},
		"XF86MonBrightnessUp",
		function()
			os.execute("brightnessctl s 10%+")
		end
	),
	awful.key(
		{},
		"XF86MonBrightnessDown",
		function()
			os.execute("brightnessctl s 10%-")
		end
	)
)

-- for i = 1, 10 do
-- 	global_keys = gears.table.join(
-- 		global_keys,
-- 		awful.key(
-- 			{"Mod4"},
-- 			"#" .. i + 9,
-- 			function ()
-- 				local screen = awful.screen.focused()
-- 				local tag = screen.tags[i]
-- 			  	if tag then
-- 					tag:view_only()
-- 			  	end
-- 			end
-- 		),
-- 		awful.key(
-- 			{"Mod4", "Shift"},
-- 			"#" .. i + 9,
-- 			function ()
-- 				local screen = awful.screen.focused()
-- 				local tag = screen.tags[i]
-- 				if tag then
-- 					client.focus:move_to_tag(tag)
-- 				end
-- 			end
-- 		)
-- 	)
-- end

local client_keys = gears.table.join(
	awful.key(
		{"Mod4"},
		"f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end
	),
	awful.key(
		{"Mod4", "Shift"},
		"f",
		awful.client.floating.toggle
	),
	awful.key(
		{"Mod4"},
		"w",
		function(c)
			c:kill()
		end
	)
)

local client_buttons = gears.table.join(
	awful.button(
		{},
		1,
		function (c) 
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end
	),
	awful.button(
		{"Mod4"},
		1,
		function (c) 
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end
	),
	awful.button(
		{"Mod4"},
		3,
		function (c) 
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end
	)
)

return {
	global_keys = global_keys,
	client_keys = client_keys,
	client_buttons = client_buttons
}
