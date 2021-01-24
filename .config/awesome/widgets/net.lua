local awful = require("awful")
local gears = require("gears")

local util = require("util")

local M = {}

function M.textbox(textbox, args)
	args = args or {}
	args.interval = args.interval or 1
	args.markup = args.markup or "{rx} {tx}"
	args.unit = args.unit or "kilobyte"
	args.device = args.device or "wlan0"
	args.decimal_points = args.decimal_points or 1

	local old_info = {}

	local function set_textbox_markup()
		awful.spawn.easy_async_with_shell("iw dev " .. args.device .. " link", function(output)
			output = util.split(output, "\n")
			table.remove(output, 1)

			local new_info = {}

			for _, line in pairs(output) do
				local key_value_pair = util.split(line, ":")
				key_value_pair[1] = key_value_pair[1]:gsub("^%s", "") -- remove space in the beginning
				key_value_pair[1] = key_value_pair[1]:gsub("%s", "_") -- convert remaining spaces to underscores
				key_value_pair[1] = key_value_pair[1]:lower()
				key_value_pair[2] = key_value_pair[2]:gsub("^%s", "") -- remove space in the beginning
				new_info[key_value_pair[1]] = key_value_pair[2]
			end

			new_info["tx"] = new_info["tx"]:gsub(" bytes ", "")
			new_info["tx"] = new_info["tx"]:gsub(" packets", "")
			new_info["tx_packets"] = new_info["tx"]:match("%((.+)%)")
			new_info["tx"] = new_info["tx"]:gsub("%((.+)%)", "")
			new_info["tx"] = tonumber(new_info["tx"])
			new_info["tx_packets"] = tonumber(new_info["tx_packets"])

			new_info["rx"] = new_info["rx"]:gsub(" bytes ", "")
			new_info["rx"] = new_info["rx"]:gsub(" packets", "")
			new_info["rx_packets"] = new_info["rx"]:match("%((.+)%)")
			new_info["rx"] = new_info["rx"]:gsub("%((.+)%)", "")
			new_info["rx"] = tonumber(new_info["rx"])
			new_info["rx_packets"] = tonumber(new_info["rx_packets"])

			if not old_info["tx"] then
				old_info = new_info
			end

			local divider = 1

			if args.unit == "kilobyte" then
				divider = 1000
			elseif args.unit == "megabyte" then
				divider = 1000000
			elseif args.unit == "gigabyte" then
				divider = 1000000000
			end

			local tx_during_interval = (new_info["tx"] - old_info["tx"]) / divider
			local rx_during_interval = (new_info["rx"] - old_info["rx"]) / divider
			local tx_decimal_points = 0
			local rx_decimal_points = 0

			if (tx_during_interval % 1) == 0 then
				tx_decimal_points = 0
			else
				tx_decimal_points = args.decimal_points
			end

			if (rx_during_interval % 1) == 0 then
				rx_decimal_points = 0
			else
				rx_decimal_points = args.decimal_points
			end

			local formatted_tx = string.format("%." .. tx_decimal_points .. "f", tx_during_interval)
			local formatted_rx = string.format("%." .. rx_decimal_points .. "f", rx_during_interval)
			textbox.markup = args.markup:gsub("{rx}", formatted_rx):gsub("{tx}", formatted_tx):gsub("{ssid}", new_info["ssid"])

			old_info = new_info
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
