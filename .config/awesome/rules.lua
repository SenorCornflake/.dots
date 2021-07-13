local beautiful = require "beautiful"
local awful = require "awful"

local bindings = require "bindings"

local rules = {
	-- All clients
	{
		rule = {  },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = bindings.client_keys,
			buttons = bindings.client_buttons,
			screen  = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	},
	-- Floating windows
    {
		rule_any = {
        	instance = {
        		"DTA",
        		"copyq",
        		"pinentry",
        	},
        	class = {
        		"Arandr",
        		"Blueman-manager",
        		"Gpick",
        		"Kruler",
        		"MessageWin",
        		"Sxiv",
        		"Tor Browser",
        		"Wpa_gui",
        		"veromix",
        		"xtightvncviewer"
			},
        	name = {
        	  "Event Tester",
        	},
        	role = {
        		"AlarmWindow",
        		"ConfigManager",
        		"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = {
			floating = true 
		}
	},
	-- Firefox does not tile without this
	{
		rule = {
			class = "firefox"
		},
		properties = {
			opacity = 1,
			maximized = false, 
			floating = false 
		}
	},
}

return rules
