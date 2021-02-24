local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local vicious = require("vicious");

local util = require("util")

local M = {}

function M.setup()
	awful.screen.connect_for_each_screen(function(s)
		-- Create Widgets
		local function taglist_callback(self, t, index, tags)
			local tag_names = {
				['1'] = "WEB",
				['2'] = "DEV",
				['3'] = "TERM",
				['4'] = "FILES",
				['5'] = "5",
				['6'] = "6",
				['7'] = "7",
				['8'] = "8",
				['9'] = "TORRENTS"
			}

			local focused = t.screen.selected_tag.index == t.index
			local occupied = #t:clients() > 0
			local empty = #t:clients() == 0

			local name = ""
			local fg = ""

			if focused then
				name = "-" .. tag_names[t.name] .. "-"
				fg = beautiful.alpha.bar.focused_tag_fg
			elseif occupied then
				name = tag_names[t.name]
				fg = beautiful.alpha.bar.occupied_tag_fg
			elseif empty then
				name = "="
				fg = beautiful.alpha.bar.empty_tag_fg
			end

			self:get_children_by_id("tag_name")[1].markup = '<span foreground="' .. fg .. '">' .. name .. '</span>'
		end

		local taglist = awful.widget.taglist({
			screen = s,
    		filter  = awful.widget.taglist.filter.all,
			widget_template = {
				layout = wibox.layout.fixed.horizontal,
				{
					widget = wibox.container.margin,
					left = 5,
					right = 5,
					{
						id = "tag_name",
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
					}
				},
				create_callback = function(self, t, index, tags) taglist_callback(self, t, index, tags) end,
				update_callback = function(self, t, index, tags) taglist_callback(self, t, index, tags) end
			}
		})

		local volume = wibox.widget.textbox()

		vicious.register(
			volume,
			vicious.widgets.volume,
			function(widget, args)
				local v = args[1]
				local m = args[2]

				if m == "🔈" then
					return '<span foreground="' .. beautiful.alpha.bar.muted_fg .. '">muted</span>'
				else
					return v
				end
			end,
			1,
			{"Master", "-D", "pulse"}
		)
		local battery = wibox.widget.textbox()

		vicious.register(
			battery,
			vicious.widgets.bat,
			function(widget, args)
				local b = args[2]
				if b <= 20 then
					return '<span foreground="' .. beautiful.alpha.bar.low_battery_fg .. '">' .. b .. "</span>"
				elseif b <= 50 then
					return '<span foreground="' .. beautiful.alpha.bar.middle_battery_fg .. '">' .. b .. "</span>"
				elseif b <= 100 then
					return '<span foreground="' .. beautiful.alpha.bar.full_battery_fg .. '">' .. b .. "</span>"
				else
					return b
				end
			end,
			60,
			"BAT0"
		)

		local ssid = wibox.widget.textbox()
		vicious.register(ssid, vicious.widgets.wifi, "${ssid} ", 10, "wlan0")

		local net = wibox.widget.textbox()
		vicious.register(net, vicious.widgets.net, "${wlan0 down_kb} ${wlan0 up_kb}", 2);

		-- Create bar
		local bar_height = 25

		local bar = wibox({
			type = "dock",
			bg = beautiful.alpha.bar.bg,
			fg = beautiful.alpha.bar.fg,
			width = s.geometry.width,
			height = bar_height,
			x = 0,
			y = s.geometry.height - bar_height,
			visible = true,
			ontop = false
		})

		bar:struts({
			bottom = bar_height
		})


		bar:setup({
			widget = wibox.container.margin,
			top = 2,
			left = 5,
			right = 5,
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{
					widget = wibox.layout.fixed.horizontal,
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">&lt;(</span>'
					},
					{
						widget = wibox.container.margin,
						left = 10,
						right = 10,
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								font = beautiful.alpha.bar.font,
								markup = '<span foreground="' .. beautiful.alpha.bar.label_fg .. '">TIME: </span>'
							},
							{
								widget = wibox.widget.textclock('<span foreground="' .. beautiful.alpha.bar.fg .. '" font="' .. beautiful.alpha.bar.font .. '">%a, %d %B, %Y | %H:%M</span>')
							}
						}
					},
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">)&gt;</span>'
					}
				},
				{
					widget = wibox.layout.fixed.horizontal,
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">&lt;(</span>'
					},
					{
						widget = wibox.container.margin,
						left = 10,
						right = 10,
						{
							widget = taglist
						}
					},
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">)&gt;</span>'
					}
				},
				{
					layout = wibox.layout.fixed.horizontal,
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">&lt;(</span>'
					},
					{
						widget = wibox.container.margin,
						left = 10,
						right = 10,
						{
							layout = wibox.layout.fixed.horizontal,
							spacing = 10,
							{
								layout = wibox.layout.fixed.horizontal,
								{
									widget = wibox.widget.textbox,
									markup = '<span foreground="' .. beautiful.alpha.bar.label_fg .. '">VOL: </span>',
									font = beautiful.alpha.bar.font
								},
								{
									widget = volume,
									font = beautiful.alpha.bar.font
								},
							},
							{
								layout = wibox.layout.fixed.horizontal,
								{
									widget = wibox.widget.textbox,
									markup = '<span foreground="' .. beautiful.alpha.bar.label_fg .. '">NET: </span>',
									font = beautiful.alpha.bar.font
								},
								{
									widget = ssid,
									font = beautiful.alpha.bar.font
								},
								{
									widget = net,
									font = beautiful.alpha.bar.font
								},
							},
							{
								layout = wibox.layout.fixed.horizontal,
								{
									widget = wibox.widget.textbox,
									markup = '<span foreground="' .. beautiful.alpha.bar.label_fg .. '">BAT: </span>',
									font = beautiful.alpha.bar.font
								},
								{
									widget = battery,
									font = beautiful.alpha.bar.font
								},
							},
						}
					},
					{
						widget = wibox.widget.textbox,
						font = beautiful.alpha.bar.font,
						markup = '<span foreground="' .. beautiful.alpha.bar.decoration_fg .. '">)&gt;</span>'
					}
				},
			}
		})
	end)
end

return M
