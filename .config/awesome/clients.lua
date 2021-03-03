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

function M.getwfact(c, t)
	local c = c or client.focus
    if not c then return end

    local t = t
    local w = client.idx(c)
    if not w then return end

    local data = t.windowfact or {}
    local colfact = data[w.col] or {}
    local curr = colfact[w.idx] or 1
    colfact[w.idx] = curr + add

    -- keep our ratios normalized
    normalize(colfact, w.num)

    t:emit_signal("property::windowfact")
end

return M
