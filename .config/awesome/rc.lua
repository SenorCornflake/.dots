pcall(require, "luarocks.loader")

local gears = require "gears"
local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local naughty = require "naughty"
local sharedtags = require "awesome-sharedtags"

local bindings = require "bindings"
local rules = require "rules"



require("awful.autofocus")


os.execute("xrandr --output VGA-1 --auto --primary --output eDP-1 --auto --right-of VGA-1")
os.execute("sh ~/MAIN/scripts/autostart.sh")

------------
-- ERRORS --
------------
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Error occurred during startup",
		text = awesome.startup_errors
	})
end

do
	local in_error = false

	awesome.connect_signal("debug::error", function (error)
		if in_error then return  end

		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Error occurred",
			text = tostring(error)
		})
	end)
end


-----------
-- THEME --
-----------
beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme.lua")

-------------
-- LAYOUTS --
-------------
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

----------
-- TAGS --
----------
local tags = sharedtags {
	{ name = "3", layout = awful.layout.layouts[1] },
	{ name = "4", layout = awful.layout.layouts[1] },
	{ name = "5", layout = awful.layout.layouts[1] },
	{ name = "6", layout = awful.layout.layouts[1] },
	{ name = "7", layout = awful.layout.layouts[1] },
	{ name = "8", layout = awful.layout.layouts[1] },
	{ name = "9", layout = awful.layout.layouts[1] },
	{ name = "0", layout = awful.layout.layouts[1] }
}

awful.screen.connect_for_each_screen(function (s) 
    --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])
	sharedtags.viewonly(tags[s.index], s)
end)

for i = 1, 10 do
	bindings.global_keys = gears.table.join(
		bindings.global_keys,
		awful.key(
			{"Mod4"},
			"#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = tags[i]
			  	if tag then
					sharedtags.viewonly(tag, screen)
			  	end
			end
		),
		awful.key(
			{"Mod4", "Shift"},
			"#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		)
	)
end

-------------
-- Widgets --
-------------
awful.screen.connect_for_each_screen(function(s)
	s.bar = awful.wibar({
		position = "top",
		screen = s
	})

	s.bar:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.taglist {
				screen = s,
				filter = awful.widget.taglist.filter.all,
				buttons = gears.table.join(
					awful.button(
						{},
						1,
						function (t) 
							t:view_only()
						end
					),
					awful.button(
						{"mod4"},
						1,
						function (t) 
							if client.focus then
								client.focus.move_to_tag(t)
							end
						end
					),
					awful.button(
						{},
						3,
						awful.tag.viewtoggle
					),
					awful.button(
						{"mod4"},
						3,
						function (t) 
							if client.focus then
								client.focus:toggle_tag(t)
							end
						end
					),
					awful.button(
						{},
						4,
						function (t)
							awful.tag.viewnext(t.screen)
						end
					),
					awful.button(
						{},
						5,
						function (t)
							awful.tag.viewprev(t.screen)
						end
					)
				)
			 },
		},
		{
			layout = wibox.layout.fixed.horizontal
		},
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.textclock(),
			awful.widget.layoutbox(s),
		}
	}
end)

------------------
-- KEY BINDINGS --
------------------
root.keys(bindings.global_keys)

-------------
-- SIGNALS --
-------------
-- Set border colors
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Set at slave
client.connect_signal("manage", function (c)
	awful.client.setslave(c)

    -- Prevent clients from being unreachable after screen count changes.
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-----------
-- RULES --
-----------
awful.rules.rules = rules
