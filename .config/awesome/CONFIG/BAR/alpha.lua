local awful = require("awful")
local theme = require("CONFIG.theme")
local wibox = require("wibox")

local vicious = require("vicious");


local M = {}

awful.screen.connect_for_each_screen(function(s)
	-- Create Widgets
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

		local focused = t.screen.selectedTag.index == t.index
		local occupied = #t:clients() > 0
		local empty = #t:clients() == 0

		local name = ""
		local fg = ""

		if focused then
			name = "-" .. tag_names[t.name] .. "-"
			fg = theme.alpha_bar_focusedTagFg
		elseif occupied then
			name = tag_names[t.name]
			fg = theme.alpha_bar_occupiedTagFg
		elseif empty then
			name = "="
			fg = theme.alpha_bar_emptyTagFg
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
					font = theme.alpha_bar_font,
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
		function(_, args)
			local v = args[1]
			local m = args[2]

			if m == "🔈" then
				return '<span foreground="' .. theme.alpha_bar_mutedFg .. '">muted</span>'
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
		function(_, args)
			local b = args[2]
			if b <= 20 then
				return '<span foreground="' .. theme.alpha_bar_lowBatteryFg .. '">' .. b .. "</span>"
			elseif b <= 50 then
				return '<span foreground="' .. theme.alpha_bar_middleBatteryFg .. '">' .. b .. "</span>"
			elseif b <= 100 then
				return '<span foreground="' .. theme.alpha_bar_fullBatteryFg .. '">' .. b .. "</span>"
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
	vicious.register(net, vicious.widgets.net, "${wlan0 up_kb} KB/s ${wlan0 down_kb} KB/s", 2);

	-- local cpu_freq = wibox.widget.textbox()
	-- vicious.register(
	-- 	cpu_freq,
	-- 	vicious.widgets.cpuinf,
	-- 	function(widget, args)
	-- 		local cpu_id = 0
	-- 		local cpu_freqs = {}

	-- 		while true do
	-- 			if args["{cpu" .. cpu_id .. " ghz}"] == nil then
	-- 				break
	-- 			else
	-- 				table.insert(cpu_freqs, args["{cpu" .. cpu_id .. " ghz}"])
	-- 				cpu_id = cpu_id + 1
	-- 			end
	-- 		end

	-- 		return string.format("%.1f GHz", util.average_of(cpu_freqs))
	-- 	end,
	-- 	2
	-- )

	local cpu_usage = wibox.widget.textbox()
	vicious.register(
		cpu_usage,
		vicious.widgets.cpu,
		"$1%",
		2
	)

	local memory = wibox.widget.textbox()
	vicious.register(
		memory,
		vicious.widgets.mem,
		"$2 MB",
		2
	)

	-- Create bar
	local bar_height = 25

	local bar = wibox({
		type = "dock",
		bg = theme.alpha_bar_bg,
		fg = theme.alpha_bar_fg,
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
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">&lt;(</span>'
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
								font = theme.alpha_bar_font,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">TIME: </span>'
							},
							{
								widget = wibox.widget.textclock('<span foreground="' .. theme.alpha_bar_fg .. '" font="' .. theme.alpha_bar_font .. '">%H:%M</span>')
							}
						},
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								font = theme.alpha_bar_font,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">DATE: </span>'
							},
							{
								widget = wibox.widget.textclock('<span foreground="' .. theme.alpha_bar_fg .. '" font="' .. theme.alpha_bar_font .. '">%a, %d %B, %Y</span>')
							}
						},
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">CPU: </span>',
								font = theme.alpha_bar_font
							},
							{
								widget = cpu_usage,
								font = theme.alpha_bar_font
							}
						},
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">MEM: </span>',
								font = theme.alpha_bar_font
							},
							{
								widget = memory,
								font = theme.alpha_bar_font
							}
						},
					}
				},
				{
					widget = wibox.widget.textbox,
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">)&gt;</span>'
				}
			},
			{
				widget = wibox.layout.fixed.horizontal,
				{
					widget = wibox.widget.textbox,
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">&lt;(</span>'
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
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">)&gt;</span>'
				}
			},
			{
				layout = wibox.layout.fixed.horizontal,
				{
					widget = wibox.widget.textbox,
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">&lt;(</span>'
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
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">VOL: </span>',
								font = theme.alpha_bar_font
							},
							{
								widget = volume,
								font = theme.alpha_bar_font
							},
						},
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">NET: </span>',
								font = theme.alpha_bar_font
							},
							{
								widget = ssid,
								font = theme.alpha_bar_font
							},
							{
								widget = net,
								font = theme.alpha_bar_font
							},
						},
						{
							layout = wibox.layout.fixed.horizontal,
							{
								widget = wibox.widget.textbox,
								markup = '<span foreground="' .. theme.alpha_bar_labelFg .. '">BAT: </span>',
								font = theme.alpha_bar_font
							},
							{
								widget = battery,
								font = theme.alpha_bar_font
							},
						},
					}
				},
				{
					widget = wibox.widget.textbox,
					font = theme.alpha_bar_font,
					markup = '<span foreground="' .. theme.alpha_bar_decorationFg .. '">)&gt;</span>'
				}
			},
		}
	})
end)

return M
