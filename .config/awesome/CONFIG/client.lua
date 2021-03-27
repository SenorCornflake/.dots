local awful = require "awful"
local theme = require "CONFIG.theme"

local util = require "CONFIG.util"

-----------------------
-- SET BORDER COLORS --
-----------------------
client.connect_signal("focus", function(c)
	c.border_color = theme.general_borderFocused
end)
client.connect_signal("unfocus", function(c)
	c.border_color = theme.general_borderNormal
end)

----------------------------------------
-- NEW CLIENTS OPEN AT SLAVE POSITION --
----------------------------------------
client.connect_signal("manage", function(c)
	awful.client.setslave(c)
end)
