local awful = require "awful"
local theme = require "CONFIG.theme"

--------------------------------
-- SETUP TAGS FOR EACH SCREEN --
--------------------------------
awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)

------------------
-- SET TAG GAPS --
------------------
awful.screen.connect_for_each_screen(function(s)
	for	_, tag in pairs(s.tags) do
		tag.gap = theme.general_gapSize
	end
end)
