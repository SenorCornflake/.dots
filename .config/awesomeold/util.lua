--[[
==============================================================================================================================================================
= This file contains functions that I didn't feel like leaving scattered all over the place, so I put them here, they aren't limited to just being utilities =
==============================================================================================================================================================
--]]

local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

require("table_serialization")

local util = {}

util.debug = {}

-- Notify a debugging message
function util.debug.notify(item)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "DEBUG NOTIFICATION",
		text = gears.debug.dump_return(item)
	})
end

-- Dump debug message into a file
function util.debug.dump_to_file(path, item)
	local file = io.open(path, "w")
	io.output(file)
	io.write(gears.debug.dump_return(item))
	io.close(file)
end

-- Split string into table
function util.split(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

-- List Directory
function util.scandir(directory)
	local ls_output = io.popen('ls -a "' .. directory .. '"')
	local listing = {}
	local i = 1

	for file in ls_output:lines() do
		listing[i] = file
		i = i + 1
	end
	table.remove(listing, 1)
	table.remove(listing, 1)
	ls_output:close()

	return listing
end

-- Set Wallpaper
function util.set_wallpaper(wallpaper)
	wallpaper = wallpaper or beautiful.general.wallpaper
	wallpaper = wallpaper:gsub("~", os.getenv("HOME"))
	if wallpaper then
		awful.screen.connect_for_each_screen(function(s)
			gears.wallpaper.maximized(wallpaper, s)
		end)
	end
end

-- Get size of table
function util.size_of_table(table)
	local count = 0

	for _, _ in pairs(table) do
		count = count + 1
	end

	return count
end

-- Read output of a shell command synchronously, only used when necessary
function util.read_command(cmd)
	local process = io.popen(cmd)
	local result = process:read("*a")
	process:close()
	result = result:sub(1, #result - 1)

	return result
end

-- Return the average amount between numbers
function util.average_of(numbers)
	local total_amount = 0
	local total_numbers = 0

	for _, v in pairs(numbers) do
		total_amount = total_amount + v
		total_numbers = total_numbers + 1
	end

	return total_amount / total_numbers
end

-- Truncate a string if too long
function util.truncate_string(s, len, marker)
	marker = marker or "..."

	if string.len(s) <= len then
		return s
	end

	s = string.sub(s, 0, len) .. marker
	return s
end

return util
