local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local util = require("util")

local M = {}

function M.setup()
	client.connect_signal("request::titlebars", function (c)
		local titlebar_buttons = gears.table.join(
			awful.button(
				{ },
				1,
				function ()
					c:emit_signal("request::activate", "titlebar", { raise = true })
					awful.mouse.client.move(c)
				end
			)
		)

		awful.titlebar(c, {
			size = 20,
			position = "top",
			bg_normal = beautiful.alpha.titlebar.bg_normal,
			fg_normal = beautiful.alpha.titlebar.fg_normal,
			bg_focus = beautiful.alpha.titlebar.bg_focused,
			fg_focus = beautiful.alpha.titlebar.fg_focused,

		}):setup({
			layout = wibox.layout.align.horizontal,
			buttons = titlebar_buttons,
			{
				layout = wibox.layout.fixed.horizontal
			},
			{
				widget = wibox.container.margin,
				bottom = 0,
				{
					widget = awful.titlebar.widget.titlewidget(c),
					align = "center",
					font = beautiful.alpha.titlebar.font
				}
			},
			{
				layout = wibox.layout.fixed.horizontal
			}
		})
	end)
end

return M
