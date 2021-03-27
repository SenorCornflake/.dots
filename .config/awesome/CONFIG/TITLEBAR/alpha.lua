local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

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
			bg_normal = beautiful.alpha_titlebar_bgNormal,
			fg_normal = beautiful.alpha_titlebar_fgNormal,
			bg_focus = beautiful.alpha_titlebar_bgFocused,
			fg_focus = beautiful.alpha_titlebar_fgFocused,

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
					font = beautiful.alpha_titlebar_font
				}
			},
			{
				layout = wibox.layout.fixed.horizontal
			}
		})
	end)
end

return M
