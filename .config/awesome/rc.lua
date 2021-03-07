local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

require("awful.autofocus")

-- This is a global variable because I had issues previously with recursive requiring so I just made it global to save myself in the future
_G.bindings = require("bindings")

local util = require("util")
local client_functions = require("client_functions")
local tag_functions = require("tag_functions")
local rules = require("rules")
local programs = require("programs")
local session = require("session")
local bar = require("ui_elements.bar")
local titlebar = require("ui_elements.titlebar")
local notification = require("ui_elements.notification")


do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Set faster keyboard rate for faster scrolling and cursor movement
os.execute("xset r rate 250 30")
-- Enable redshift if it was enabled before
os.execute("python ~/environment/scripts/nightmode.py")

-- Set the beautiful theme file
beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme.lua")

-- Set layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	--awful.layout.suit.floating
}

-- Setup global keys
root.keys(_G.bindings.global_keys)

-- Setup rules
rules.setup()

-- Setup tag configuration
tag_functions.setup()
tag_functions.set_gaps()

-- Setup client configuration
client_functions.setup_border_colors()
client_functions.set_at_slave()

-- Use the bar, titlebar and notifications defined in the beautiful theme
bar.use(beautiful.bar)
titlebar.use(beautiful.titlebar)
notification.use(beautiful.notification)

-- Set the wallpaper defined in the beautiful theme
util.set_wallpaper()

-- Launch  programs
programs.compositor()
programs.disk_automounter()
programs.polkit()

-- Load any session saved previously
session.load()

