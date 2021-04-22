local awful = require "awful"
local theme = require "CONFIG.theme"
local wibox = require "wibox"

local vicious = require "vicious"

local util = require "CONFIG.util"

local bravo = {}

local bar_height = 30
local bg = theme.bravo_bar_bg
local fg = theme.bravo_bar_fg
local label_fg = theme.bravo_bar_labelFg
local sep_fg = theme.bravo_bar_sepFg
local font = theme.bravo_bar_font

local very_short_delay = 1
local short_delay = 3
local moderate_delay = 10
local long_delay = 30
local very_long_delay = 60

awful.screen.connect_for_each_screen(function(s)

	local sep = {
		widget = wibox.widget.textbox,
		markup = '<span font="' .. font .. '" foreground="' .. sep_fg .. '">|</span>'
	}

	local battery = wibox.widget.textbox()
	vicious.register(
		battery,
		vicious.widgets.bat,
		function(_, args)
			local state = args[1]

			if state == "↯" then
				state = " Charging"
			else
				state = ""
			end

			local level = args[2]
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">BAT</span> ' .. level .. "%" .. state .. "</span>"
		end,
		moderate_delay,
		"BAT0"
	)

	local disk = wibox.widget.textbox()
	vicious.register(
		disk,
		vicious.widgets.fs,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">DISK</span> ' .. args["{/ avail_gb}"] .. " GB</span>"
		end,
		moderate_delay,
		false
	)

	local mem = wibox.widget.textbox()
	vicious.register(
		mem,
		vicious.widgets.mem,
		function(_, args)
			local mem_usage_mb = args[2]
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">MEM</span> ' .. mem_usage_mb .. " MB</span>"
		end,
		short_delay
	)

	local cpu = wibox.widget.textbox()
	vicious.register(
		cpu,
		vicious.widgets.cpu,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">CPU</span> ' .. args[1] .. "%</span>"
		end,
		short_delay
	)

	local net_speed = wibox.widget.textbox()
	vicious.register(
		net_speed,
		vicious.widgets.net,
		function(_, args)
			local up_kb = tonumber(args["{" .. _G.WIFI_INTERFACE .. " up_kb}"])
			local down_kb = tonumber(args["{" .. _G.WIFI_INTERFACE .. " down_kb}"])

			-- Do not show decimal point if it is a zero; ie: Display "2.0" as "2"
			-- if (up_kb % 1) == 0 then
			-- 	up_kb = string.format("%.0f", up_kb)
			-- end
			-- if (down_kb % 1) == 0 then
			-- 	down_kb = string.format("%.0f", down_kb)
			-- end

			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">UP/DOWN</span> ' .. up_kb .. " KB/s " ..  down_kb .. " KB/s</span>"
		end,
		short_delay
	)

	local ssid = wibox.widget.textbox()
	vicious.register(
		ssid,
		vicious.widgets.wifi,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">SSID</span> ' .. args["{ssid}"] .. "</span>"
		end,
		short_delay,
		_G.WIFI_INTERFACE
	)

	local volume = wibox.widget.textbox()

	vicious.register(
		volume,
		vicious.widgets.volume,
		function(_, args)
			local v = args[1]
			local m = args[2]

			if m == "🔈" then
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">VOLUME</span> <span foreground="' .. theme.bravo_bar_muted_fg .. '">' .. "X" .. '</span>' .. "</span>"
			else
				return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">VOLUME</span> ' .. v .. "</span>"
			end
		end,
		very_short_delay,
		{"Master", "-D", "pulse"}
	)

	local date = wibox.widget.textclock('<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">DATE</span> ' .. "%a, %d %B, %Y" .. "</span>")
	local time = wibox.widget.textclock('<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">TIME</span> ' .. "%H:%M" .. "</span>")

	local cpu_freq = wibox.widget.textbox()
	vicious.register(
		cpu_freq,
		vicious.widgets.cpuinf,
		function(_, args)
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
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">CPU_FREQ</span> ' .. average_ghz .. " GHz</span>"
		end,
		short_delay
	)

	local package_updates = wibox.widget.textbox()
	vicious.register(
		package_updates,
		vicious.widgets.pkg,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">UPDATES</span> ' .. args[1] .. "</span>"
		end,
		long_delay,
		"Arch"
	)

	local cpu_temp = wibox.widget.textbox()
	vicious.register(
		cpu_temp,
		vicious.widgets.thermal,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">CPU_TEMP</span> ' .. args[1] .. "°C</span>"
		end,
		short_delay,
		"thermal_zone1"
	)

	local weather = wibox.widget.textbox()
	vicious.register(
		weather,
		vicious.widgets.weather,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">WEATHER</span> Temp: ' .. args["{tempc}"] .. "°C; Sky: " .. args["{sky}"] .. "; Humidity: " .. args["{humid}"] .. "%; Wind: " .. args["{windkmh}"] .. " km/h</span>"
		end,
		very_long_delay,
		_G.ICAO_CODE
	)

	local link_quality = wibox.widget.textbox()
	vicious.register(
		link_quality,
		vicious.widgets.wifi,
		function(_, args)
			return '<span font="' .. font .. '">' .. '<span foreground="' .. label_fg .. '">LINK_QUALITY</span> ' .. args["{linp}"] .. "%</span>"
		end,
		short_delay,
		_G.WIFI_INTERFACE
	)

	local client_title = wibox.widget.textbox()
	local client_title_prefix = '<span foreground="' .. theme.bravo_bar_labelFg .. '">' .. "> " .. '</span>'

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

	local function taglist_callback(self, t, _, _)
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
			name = "[" .. tag_names[t.name] .. "]"
			tag_fg = theme.bravo_bar_focusedTagFg
		elseif occupied then
			name = tag_names[t.name]
			tag_fg = theme.bravo_bar_occupiedTagFg
		elseif empty then
			name = tag_names[t.name]
			tag_fg = theme.bravo_bar_emptyTagFg
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
				layout = wibox.layout.fixed.horizontal,
				spacing = 10,
				{
					widget = date
				},
				{
					widget = time
				},
				{
					widget = client_title
				}
			},
			{
				widget = taglist
			},
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = 10,
				{
					widget = weather
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
			spacing = 3,
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
				widget = cpu_temp,
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
				widget = link_quality,
			},
			sep,
			{
				widget = ssid,
			},
			sep,
			{
				widget = package_updates,
			},
			sep,
			{
				widget = volume,
			},
		},
		nil
	}
end)

return bravo
