local awful = require("awful")
local beautiful = require("beautiful")

local tag_functions = {}

function tag_functions.set_gaps()
	awful.screen.connect_for_each_screen(function(s)
		for	_, tag in pairs(s.tags) do
			tag.gap = beautiful.general.gap_size
		end
	end)
end

function tag_functions.setup()
	awful.screen.connect_for_each_screen(function(s)
		awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	end)
end

return tag_functions
