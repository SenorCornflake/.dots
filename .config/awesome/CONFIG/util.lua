--[[
==============================================================================================================================================================
= This file contains functions that I didn't feel like leaving scattered all over the place, so I put them here, they aren't limited to just being utilities =
==============================================================================================================================================================
--]]

local theme = require("CONFIG.theme")
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
	wallpaper = wallpaper or theme.general_wallpaper
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


function util.getwfact(c, t) -- Code stolen from awful.client.setwfact()
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

function util.setwfact(wfact, c, t) -- This is the same as the function shipped with awesome but it allows you to set a tag instead of using the screens selected tag
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

return util
