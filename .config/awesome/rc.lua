local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

require("awful.autofocus")

_G.bindings = require("bindings")

local util = require("util")
local clients = require("clients")
local tags = require("tags")
local rules = require("rules")
local programs = require("programs")
local bar = require("ui_elements.bar")
local titlebar = require("ui_elements.titlebar")


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


awful.screen.connect_for_each_screen(function(s)
	for key, _ in pairs(s.outputs) do
		util.debug.dump_to_file("dump.txt", key)
	end
end)

--util.reload_if_using_disabled_screen()

os.execute("xset r rate 250 30")
os.execute("python ~/environment/scripts/nightmode.py")

beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme.lua")

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.floating
}

root.keys(_G.bindings.global_keys)

rules.setup()

tags.setup()
tags.set_gaps()

clients.setup_border_colors()
clients.set_at_slave()

bar.use(beautiful.bar)
titlebar.use(beautiful.titlebar)

util.set_wallpaper()

programs.compositor()

util.session.load()
