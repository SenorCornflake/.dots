local awful = require("awful")
local beautiful = require("beautiful")

local util = require("util")

local client_functions = {}

function client_functions.setup_border_colors()
	-- Change to appropriate border color when focusing and unfocusing clients
	client.connect_signal("focus", function(c)
		c.border_color = beautiful.general.border_focused
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.general.border_normal
	end)
end

function client_functions.set_at_slave()
	client.connect_signal("manage", function(c)
		awful.client.setslave(c)
	end)
end

function client_functions.getwfact(c, t) -- Code stolen from awful.client.setwfact()
	c = c or client.focus
    if not c then return end

    t = t or c.screen.selected_tag
    local w = awful.client.idx(c)
    if not w then return end

    local data = t.windowfact or {}
    local colfact = data[w.col] or {}
    local curr = colfact[w.idx] or 1

    return curr
end

function client_functions.setwfact(wfact, c, t) -- This is the same as the function shipped with awesome but it allows you to set a tag instead of using the screens selected tag
    -- get the currently selected window
    c = c or client.focus
    if not c or not c:isvisible() then return end

    local w = awful.client.idx(c)

    if not w then return end

    t = t or c.screen.selected_tag

    -- n is the number of windows currently visible for which we have to be concerned with the properties
    local data = t.windowfact or {}
    local colfact = data[w.col]

    local need_normalize = colfact ~= nil

    if not need_normalize then
        colfact = {}
    end

    colfact[w.idx] = wfact

    if not need_normalize then
        t:emit_signal("property::windowfact")
        return
    end

    local rest = 1-wfact

    -- calculate the current denominator
    local total = 0
    for i = 1,w.num do
        if i ~= w.idx then
            total = total + colfact[i]
        end
    end

    -- normalize the windows
    for i = 1,w.num do
        if i ~= w.idx then
            colfact[i] = (colfact[i] * rest) / total
        end
    end

    t:emit_signal("property::windowfact")
end

return client_functions
