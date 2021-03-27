-- Just a seperate file to contain all my rules
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local util = require("util")

beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme.lua")

local rules = {}

function rules.setup()
	awful.rules.rules = {
		{
			rule = { },
			properties = {
				border_width = beautiful.general.border_width,
				border_color = beautiful.general.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = _G.bindings.client_keys,
				buttons = _G.bindings.client_buttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			}
		},
		{
			rule_any = {
				type = {"dialog"}
			},
			properties = {
				ontop = true,
				floating = true
			}
		},
		{
			rule_any = {
				type = {"normal", "dialog"}
			},
			properties = {
				titlebars_enabled = true,
			}
		},
		{ -- Fix firefox always floating, I never used to have this issue, but it happened suddenly and I don't know why
			rule = {
				class = "firefox",
			},
			properties = {
				floating = false,
				maximized = false
			}
		}
	}
end

return rules
