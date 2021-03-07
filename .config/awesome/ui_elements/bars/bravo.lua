local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local vicious = require("vicious");

local util = require("util")

local bravo = {}

function bravo.setup()
	local bar_height = 30
	local bg = beautiful.bravo.bar.bg
	local fg = beautiful.bravo.bar.fg
	local label_fg = beautiful.bravo.bar.label_fg
	local sep_fg = beautiful.bravo.bar.sep_fg
	local font = beautiful.bravo.bar.font

	awful.screen.connect_for_each_screen(function(s)

		local sep = {
			widget = wibox.widget.textbox,
			markup = '<span font="' .. font .. '" foreground="' .. sep_fg .. '"> | </span>'
		}

		local battery = wibox.widget.textbox()
		vicious.register(
			battery,
			vicious.widgets.bat,
			function(widget, args)
				local b = args[2]
				local icon = ""
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">BAT</span> ' .. b .. "%</span>"
			end,
			10,
			"BAT0"
		)

		local disk = wibox.widget.textbox()
		vicious.register(
			disk,
			vicious.widgets.fs,
			function(widget, args)
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">DISK</span> ' .. args["{/ avail_gb}"] .. " GB</span>"
			end,
			2,
			false
		)

		local mem = wibox.widget.textbox()
		vicious.register(
			mem,
			vicious.widgets.mem,
			function(widget, args)
				local mem_usage_mb = args[2]
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">MEM</span> ' .. mem_usage_mb .. " MB</span>"
			end,
			2
		)

		local cpu = wibox.widget.textbox()
		vicious.register(
			cpu,
			vicious.widgets.cpu,
			function(widget, args)
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">CPU</span> ' .. args[1] .. "%</span>"
			end,
			2
		)

		local net_speed = wibox.widget.textbox()
		vicious.register(
			net_speed,
			vicious.widgets.net,
			function(widget, args)
				local up_kb = tonumber(args["{wlan0 up_kb}"])
				local down_kb = tonumber(args["{wlan0 down_kb}"])

				-- Do not show decimal point if it is a zero; ie: Display "2.0" as "2"
				-- if (up_kb % 1) == 0 then
				-- 	up_kb = string.format("%.0f", up_kb)
				-- end
				-- if (down_kb % 1) == 0 then
				-- 	down_kb = string.format("%.0f", down_kb)
				-- end

				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">UP/DOWN</span> ' .. up_kb .. " KB/s " ..  down_kb .. " KB/s</span>"
			end,
			2
		)

		local ssid = wibox.widget.textbox()
		vicious.register(
			ssid,
			vicious.widgets.wifi,
			function(widget, args)
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">SSID</span> ' .. args["{ssid}"] .. "</span>"
			end,
			30,
			"wlan0"
		)

		local volume = wibox.widget.textbox()

		vicious.register(
			volume,
			vicious.widgets.volume,
			function(widget, args)
				local v = args[1]
				local m = args[2]

				if m == "🔈" then
					return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">VOLUME</span> <span foreground="' .. beautiful.bravo.bar.muted_fg .. '">' .. "X" .. '</span>' .. "</span>"
				else
					return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">VOLUME</span> ' .. v .. "</span>"
				end
			end,
			1,
			{"Master", "-D", "pulse"}
		)

		local date = wibox.widget.textclock('<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">DATE</span> ' .. "%a, %d %B, %Y" .. "</span>")
		local time = wibox.widget.textclock('<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">TIME</span> ' .. "%H:%M" .. "</span>")

		local cpu_freq = wibox.widget.textbox()
		vicious.register(
			cpu_freq,
			vicious.widgets.cpuinf,
			function(widget, args)
				local freqs = {}

				local index = 0
				while true do
					if args["{cpu" .. index .. " ghz}"] ~= nil then
						table.insert(freqs, args["{cpu" .. index .. " ghz}"])
					else
						break
					end

					index = index + 1
				end


				local average_ghz = util.average_of(freqs)

				-- if (average_ghz % 1) == 0 then
				-- 	average_ghz = string.format("%.0f", average_ghz)
				-- else
				-- 	average_ghz = string.format("%.2f", average_ghz)
				-- end

				average_ghz = string.format("%.2f", average_ghz)
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">FREQ</span> ' .. average_ghz .. " GHz</span>"
			end,
			2
		)

		local client_title = wibox.widget.textbox()
		local client_title_prefix = '<span foreground="' .. beautiful.bravo.bar.label_fg .. '">' .. "> " .. '</span>'

		if client.focus ~= nil then
			client_title.markup =  '<span font="' .. font .. '">' .. client_title_prefix ..  util.truncate_string(client.focus.name, 40) .. '</span>'
		else
			client_title.markup = '<span font="' .. font .. '">' .. client_title_prefix .. '</span>'
		end

		client.connect_signal("focus", function(c)
			client_title.markup = '<span font="' .. font .. '">' .. client_title_prefix .. util.truncate_string(c.name, 40) .. '</span>'
		end)

		client.connect_signal("unfocus", function()
			client_title.markup = '<span font="' .. font .. '">' .. client_title_prefix .. '</span>'
		end)

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
			local tag_fg = ""

			if focused then
				name = "&gt; " .. tag_names[t.name] .. " &lt;"
				tag_fg = beautiful.bravo.bar.focused_tag_fg
			elseif occupied then
				name = tag_names[t.name]
				tag_fg = beautiful.bravo.bar.occupied_tag_fg
			elseif empty then
				name = "-"
				tag_fg = beautiful.bravo.bar.empty_tag_fg
			end

			self:get_children_by_id("tag_name")[1].markup = '<span foreground="' .. tag_fg .. '">' .. name .. '</span>'
		end

		local taglist = awful.widget.taglist {
			screen = s,
    		filter = awful.widget.taglist.filter.all,
			widget_template = {
				layout = wibox.layout.fixed.horizontal,
				{
					widget = wibox.container.margin,
					left = 5,
					right = 5,
					{
						id = "tag_name",
						widget = wibox.widget.textbox,
						font = font,
					}
				},
				create_callback = function(self, t, index, tags) taglist_callback(self, t, index, tags) end,
				update_callback = function(self, t, index, tags) taglist_callback(self, t, index, tags) end
			}
		}
		local bar_top_width = s.geometry.width
		local bar_top_x = (s.geometry.width - bar_top_width) / 2
		local bar_top_padding = 0 -- beautiful.general.gap_size * 2
		local bar_top_y = bar_top_padding


		s.bar_top = wibox {
			bg = bg,
			fg = fg,
			font = font,
			visible = true,
			ontop = false,
			type = "dock",
			x = bar_top_x,
			y = bar_top_y,
			height = bar_height,
			width = bar_top_width
		}

		s.bar_top:struts {
			top = bar_height + bar_top_padding
		}

		s.bar_top:setup {
			widget = wibox.container.margin,
			left = 10,
			right = 10,
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{
					widget = client_title
				},
				{
					widget = taglist
				},
				{
					layout = wibox.layout.fixed.horizontal,
					spacing = 10,
					{
						widget = date
					},
					{
						widget = time
					}
				}
			}
		}

		local bar_bottom_width = s.geometry.width
		local bar_bottom_x = (s.geometry.width - bar_bottom_width) / 2
		local bar_bottom_padding = 0 -- beautiful.general.gap_size * 2
		local bar_bottom_y = s.geometry.height - bar_height - bar_bottom_padding

		s.bar_bottom = wibox {
			bg = bg,
			fg = fg,
			font = font,
			visible = true,
			ontop = false,
			type = "dock",
			x = bar_bottom_x,
			y = bar_bottom_y,
			height = bar_height,
			width = bar_bottom_width
		}

		s.bar_bottom:struts {
			bottom = bar_height + bar_bottom_padding
		}

		s.bar_bottom:setup {
			layout = wibox.layout.align.horizontal,
			expand = "none",
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				{
					widget = battery,
				},
				sep,
				{
					widget = disk
				},
				sep,
				{
					widget = mem,
				},
				sep,
				{
					widget = cpu,
				},
				sep,
				{
					widget = cpu_freq,
				},
				sep,
				{
					widget = net_speed,
				},
				sep,
				{
					widget = ssid,
				},
				sep,
				{
					widget = volume,
				},
			},
			nil
		}
	end)
end

return bravo
