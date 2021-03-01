local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")

local util = require("util")

local M = {}

M.setup = function()
	naughty.disconnect_signal("request::display", naughty.default_notification_handler)
	naughty.connect_signal("request::display", function(n)
		naughty.layout.box {
			notification = n,
			border_width = beautiful.general.border_width,
			border_color = beautiful.general.border_focused,
			position = "top_right",
			type = "notification",
			x = 10,
			y = 100,
			bg = beautiful.alpha.notification.bg,
			fg = beautiful.alpha.notification.fg,
			widget_template = {
				widget = wibox.container.margin,
				margins = 10,
				layout = wibox.layout.align.horizontal,
				{
					widget = wibox.container.margin,
					margins = xresources.apply_dpi(10),
					{
						layout = wibox.layout.align.vertical,
						{
							widget = wibox.container.margin,
							margins = {
								bottom = xresources.apply_dpi(3),
							},
							{
								widget = wibox.widget.textbox,
								markup = "<b>"..n.title.."</b>",
								font = beautiful.alpha.notification.font,
								fg = beautiful.alpha.notification.fg
							}
						},
						{
							widget = wibox.widget.textbox,
							fg = beautiful.alpha.notification.fg,
							font = beautiful.alpha.notification.font,
							markup = n.message
						},
					}
				}
			}
		}
	end)
end

return M
