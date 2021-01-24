local awful = require("awful")
local beautiful = require("beautiful")

local util = require("util")

local M = {}

function M.setup_border_colors()
	-- Change to appropriate border color when focusing and unfocusing clients
	client.connect_signal("focus", function(c)
		c.border_color = beautiful.general.border_focused
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.general.border_normal
	end)
end

function M.set_at_slave()
	client.connect_signal("manage", function(c)
		awful.client.setslave(c)
	end)
end

return M
