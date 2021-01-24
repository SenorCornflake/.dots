local awful = require("awful")

local util = require("util")

local M = {}

function M.textbox(textbox, args)
	args = args or {}
	args.volume_markup = args.volume_markup or "{volume}"
	args.muted_markup = args.muted_markup or "muted"

	local function set_textbox_markup()
		awful.spawn.easy_async("pulseaudio-ctl full-status", function(stdout)
			stdout = util.split(stdout, " ")
			-- On random occasions, for some reason, stdout does not include the volume, so here we check to see if the volume can be converted into an integer first, if it can't, we just recursively run the the function until it can
			if tonumber(stdout[1]) then
				-- If it is muted
				if stdout[2] == "yes" then
					textbox.markup = args.muted_markup:gsub("{volume}", stdout[1])
				else
					textbox.markup = args.volume_markup:gsub("{volume}", stdout[1])
				end
			else
				set_textbox_markup()
			end
		end)
	end
	set_textbox_markup()

	-- Quick hack to prevent buildup of pactl processes
	os.execute("killall pactl")

	awful.spawn.with_line_callback(
		'pactl subscribe',
		{
			stdout = function(stdout)
				if stdout:find("sink", 1) ~= nil then
					set_textbox_markup()
				end
			end
		}
	)
end

return M
