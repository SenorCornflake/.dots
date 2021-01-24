local awful = require("awful")
local gears = require("gears")

local util = require("util")

local M = {}

function M.textbox(textbox, args)
	args = args or {}
	args.low = args.low or 15
	args.middle = args.middle or 50
	args.full = args.full or 100
	args.low_markup = args.low_markup or "{capacity}"
	args.middle_markup = args.middle_markup or "{capacity}"
	args.full_markup = args.full_markup or "{capacity}"
	args.interval = args.interval or 3
	args.interface = args.interface or "BAT0"

	local function set_textbox_markup()
		awful.spawn.easy_async("cat /sys/class/power_supply/" .. args.interface .. "/capacity", function(capacity)
			capacity = tonumber(capacity)

			if capacity >= args.full then
				textbox.markup = args.full_markup:gsub("{capacity}", capacity)
			elseif (capacity >= args.middle) or (capacity <= args.middle and capacity > args.low) then
				textbox.markup = args.middle_markup:gsub("{capacity}", capacity)
			elseif capacity <= args.low then
				textbox.markup = args.low_markup:gsub("{capacity}", capacity)
			end

		end)
	end
	set_textbox_markup()

	awful.spawn.with_line_callback("sh " .. gears.filesystem.get_configuration_dir() .. "widgets/scripts/poll_timer.sh " .. args.interval, {
		stdout = function()
			set_textbox_markup()
		end
	})
end

return M
