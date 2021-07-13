local awful = require "awful"
local naughty = require "naughty"

local util = {}

util.notify = function (text)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Message",
		text = text
	})
end

util.move_through_screens = function(c)
	c = c or client.focus

	local screen_count = 0

	awful.screen.connect_for_each_screen(function()
		screen_count = screen_count + 1
	end)

	if c.screen.index == screen_count then
		c:move_to_screen(1)
	else
		c:move_to_screen(c.screen.index + 1)
	end

	util.notify(tostring(screen_count))
end

return util
