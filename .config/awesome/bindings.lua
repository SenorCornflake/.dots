local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local util = require("util")
local programs = require("programs")

local super = "Mod4"
local ctrl = "Control"
local alt = "Mod1"
local shift = "Shift"

local M = {}

-- Client Buttons
M.client_buttons = gears.table.join(
	awful.button(
		{ },
		1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
		end
	),
	awful.button(
		{ super },
		1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
        	awful.mouse.client.move(c)
		end
	),
	awful.button(
		{ super },
		3,
		function (c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
        	awful.mouse.client.resize(c)
		end
	)
)

-- Global Keys
M.global_keys = gears.table.join(
	-- Restart and Quit Awesome
	awful.key(
		{ super, shift },
		"r",
		util.session.restart,
		{
			description = "Restart Awesome",
			group = "Awesome"
		}
	),
	awful.key(
		{ super, shift },
		"q",
		awesome.quit,
		{
			description = "Quit Awesome",
			group = "Awesome"
		}
	),

	-- Focus client by direction
	awful.key(
		{ super },
		"h",
		function()
			awful.client.focus.bydirection("left")
		end,
		{
			description = "Focus left client",
			group = "Client"
		}
	),
	awful.key(
		{ super },
		"j",
		function()
			awful.client.focus.bydirection("down")
		end,
		{
			description = "Focus bottom client",
			group = "Client"
		}
	),
	awful.key(
		{ super },
		"k",
		function()
			awful.client.focus.bydirection("up")
		end,
		{
			description = "Focus top client",
			group = "Client"
		}
	),
	awful.key(
		{ super },
		"l",
		function()
			awful.client.focus.bydirection("right")
		end,
		{
			description = "Focus right client",
			group = "Client"
		}
	),

	-- Swap client by direction
	awful.key(
		{ super, shift },
		"h",
		function()
			awful.client.swap.bydirection("left")
		end,
		{
			description = "Swap with left client",
			group = "Client"
		}
	),
	awful.key(
		{ super, shift },
		"j",
		function()
			awful.client.swap.bydirection("down")
		end,
		{
			description = "Swap with bottom client",
			group = "Client"
		}
	),
	awful.key(
		{ super, shift },
		"k",
		function()
			awful.client.swap.bydirection("up")
		end,
		{
			description = "Swap with top client",
			group = "Client"
		}
	),
	awful.key(
		{ super, shift },
		"l",
		function()
			awful.client.swap.bydirection("right")
		end,
		{
			description = "Swap with right client",
			group = "Client"
		}
	),
	
	-- Resize Floating clients
	awful.key(
		{ ctrl, super },
		"h",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y, width = prev_geometry.width - 40, height = prev_geometry.height})
		end,
		{
			description = "Resize floating client minus right",
			group = "Client"
		}
	),
	-- Resize Floating clients
	awful.key(
		{ ctrl, super },
		"j",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y, width = prev_geometry.width, height = prev_geometry.height + 40})
		end,
		{
			description = "Resize floating client plus bottom",
			group = "Client"
		}
	),
	awful.key(
		{ ctrl, super },
		"k",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y, width = prev_geometry.width, height = prev_geometry.height - 40})
		end,
		{
			description = "Resize floating client minus bottom",
			group = "Client"
		}
	),
	awful.key(
		{ ctrl, super },
		"l",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y, width = prev_geometry.width + 40, height = prev_geometry.height})
		end,
		{
			description = "Resize floating client plus right",
			group = "Client"
		}
	),

	-- Move floating clients
	awful.key(
		{ super, alt },
		"h",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x - 40, y = prev_geometry.y, width = prev_geometry.width, height = prev_geometry.height})
		end,
		{
			description = "Move floating client left",
			group = "Client"
		}
	),
	-- Move Floating clients
	awful.key(
		{ super, alt },
		"j",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y + 40, width = prev_geometry.width, height = prev_geometry.height})
		end,
		{
			description = "Move floating client down",
			group = "Client"
		}
	),
	awful.key(
		{ super, alt },
		"k",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x, y = prev_geometry.y - 40, width = prev_geometry.width, height = prev_geometry.height})
		end,
		{
			description = "Move floating client up",
			group = "Client"
		}
	),
	awful.key(
		{ super, alt },
		"l",
		function()
			local prev_geometry = client.focus:geometry()
			client.focus:geometry({x = prev_geometry.x + 40, y = prev_geometry.y, width = prev_geometry.width, height = prev_geometry.height})
		end,
		{
			description = "Move floating client",
			group = "Client"
		}
	),


	-- Cycle through clients (Alt + Tab)
	awful.key(
		{ alt },
		"Tab",
		function()
			awful.client.focus.byidx(1)
		end,
		{
			description = "Focus next client",
			group = "Client"
		}
	),
	awful.key(
		{ alt, shift },
		"Tab",
		function()
			awful.client.focus.byidx(-1)
		end,
		{
			description = "Focus next client",
			group = "Client"
		}
	),
	
	-- Toggle Full screen
	awful.key(
	 	{ super },
		"f",
		function ()
			local c = awful.client.focus.history.get(awful.screen.focused({client = true, mouse = false}), 0)
			c.fullscreen = not c.fullscreen;
			c:raise()
		end,
		{
			description = "Toggle Fullscreen",
			group = "Client"
		}
	),

	-- Toggle Floating
	awful.key(
	 	{ super, shift },
		"f",
		function ()
			local c = awful.client.focus.history.get(awful.screen.focused({client = true, mouse = false}), 0)
			c.floating = not c.floating;
			c:raise()
		end,
		{
			description = "Toggle Floating",
			group = "Client"
		}
	),
	-- Spawn Terminal
	awful.key(
		{ super },
		"Return",
		programs.terminal,
		{
			description = "Spawn Terminal",
			group = "Launch"
		}
	),

	-- Run Prompt
	awful.key(
		{ super },
		"a",
		function()
			awful.spawn.with_shell("rofi -modi drun -show drun -i")
		end,
		{
			description = "Display Prompt",
			group = "Launch"
		}
	),

	-- Run Command Prompt
	awful.key(
		{ super },
		"c",
		function()
			awful.spawn.with_shell("python ~/environment/scripts/commander/main.py ~/environment/scripts/commander/commands.json")
		end,
		{
			description = "Display Prompt",
			group = "Launch"
		}
	),

	-- Show Hotkey popup
	awful.key(
		{ },
		"F1",
		function()
			hotkeys_popup.widget.new({
				width = awful.screen.focused().geometry.width / 3,
				height = awful.screen.focused().geometry.height / 2,
				bg = beautiful.alpha.bar.bg,
				fg = beautiful.alpha.bar.fg,
				font = beautiful.alpha.bar.font,
				description_font = beautiful.alpha.bar.font,
				modifiers_fg = beautiful.alpha.bar.label_fg,
				label_bg = beautiful.alpha.bar.occupied_tag_fg,
				label_fg = beautiful.alpha.bar.bg,
				border_width = beautiful.general.border_width,
				border_color = beautiful.general.border_focused,
			}):show_help()
		end,
		{
			description = "Display Hotkeys popup",
			group = "Help"
		}
	),

	-- Switch layouts
	awful.key(
	 	{ super },
		"space",
		function ()
			awful.layout.inc(1)
		end,
		{
			description = "Cycle through layouts forward",
			group = "Layout"
		}
	),

	awful.key(
	 	{ super, shift },
		"space",
		function ()
			awful.layout.inc(-1)
		end,
		{
			description = "Cycle through layouts backward",
			group = "Layout"
		}
	),
	
	-- Resize master width factor
	awful.key(
		{ shift, alt },
		"h",
		function()
			pcall(awful.tag.incmwfact, -0.05)
		end,
		{
			description = "Decrease master width factor",
			group = "Layout"
		}
	),
	awful.key(
		{ shift, alt },
		"l",
		function()
			pcall(awful.tag.incmwfact, 0.05)
		end,
		{
			description = "Increase master width factor",
			group = "Layout"
		}
	),
	-- Resize client width factor
	awful.key(
		{ shift, alt },
		"j",
		function()
			awful.client.incwfact(-0.05)
		end,
		{
			description = "Decrease client width factor",
			group = "Client"
		}
	),
	awful.key(
		{ shift, alt },
		"k",
		function()
			awful.client.incwfact(0.05)
		end,
		{
			description = "Increase client width factor",
			group = "Client"
		}
	),
	awful.key(
		{ super },
		"m",
		function()
			awful.client.setmaster(client.focus)
		end,
		{
			description = "Make Master",
			group = "Client"
		}
	),
	awful.key(
		{ super },
		"s",
		function()
			awful.client.setslave(client.focus)
		end,
		{
			description = "Make Slave",
			group = "Client"
		}
	),

	
	--Change number of columns
	awful.key(
	{ super },
	"[",
	function()
		awful.tag.incncol(-1, nil, true)
	end,
	{
		description = "Decrease number of columns",
		group = "Layout"
	}
	),

	awful.key(
	{ super },
	"]",
	function()
		awful.tag.incncol(1, nil, true)
	end,
	{
		description = "Increase number of columns",
		group = "Layout"
	}
	),
	
	--Change number of masters
	awful.key(
	{ shift, super },
	"[",
	function()
		awful.tag.incnmaster(-1, nil, true)
	end,
	{
		description = "Decrease number of masters",
		group = "Layout"
	}
	),
	awful.key(
	{ shift, super },
	"]",
	function()
		awful.tag.incnmaster(1, nil, true)
	end,
	{
		description = "Increase number of masters",
		group = "Layout"
	}
	),

	-- Volume control
	awful.key(
	 	{ },
		"XF86AudioRaiseVolume",
		function ()
			awful.spawn.with_line_callback(
				"pulseaudio-ctl up", {
				exit = function()
					--widget_helpers.volume.emit_volume_state()
				end
			})
		end,
		{
			description = "Raise Volume",
			group = "Volume"
		}
	),
	awful.key(
	 	{ },
		"XF86AudioLowerVolume",
		function ()
			awful.spawn.with_line_callback(
				"pulseaudio-ctl down", {
				exit = function()
					--widget_helpers.volume.emit_volume_state()
				end
			})
		end,
		{
			description = "Lower Volume",
			group = "Volume"
		}
	),
	awful.key(
	 	{ },
		"XF86AudioMute",
		function ()
			awful.spawn.with_line_callback(
				"pulseaudio-ctl mute", {
				exit = function()
					--widget_helpers.volume.emit_volume_state()
				end
			})
		end,
		{
			description = "Mute Volume",
			group = "Volume"
		}
	)

	-- Something similar to BSPWM's monocle layout
	-- awful.key(
	-- awf 	{ super },
	-- awf	"d",
	-- awf	function ()
	-- awf		util.toggle_max_layout()
	-- awf	end,
	-- awf	{
	-- awf		description = "Toggle max layout",
	-- awf		group = "Layout"
	-- awf	}
	-- awf)
)

-- Add Tag M
for i = 1, 9 do
	M.global_keys = gears.table.join(
		M.global_keys,
		-- View tag
		awful.key(
			{ super },
			"#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
				   tag:view_only()
				end
			end,
			{
				description = "View tag #" .. i,
				group = "Tag"
			}
		),
		-- Move client to tag
		awful.key(
			{ super, shift },
			"#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{
				description = "Move focused client to tag #" .. i,
				group = "Tag"
			}
		)
	)
end

M.client_keys = gears.table.join(
	awful.key(
		{ super },
		"w",
		function(c)
			c:kill()
		end,
		{
			description = "Kill focused client",
			group = "Client"
		}
	)
)

return M
