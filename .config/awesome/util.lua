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

local M = {}

M.debug = {}
M.session = {}

function M.session.restart()
	local focused_screen = awful.screen.focused({ mouse = false, client = true })
	local focused_tag = focused_screen.selected_tag.index
	focused_screen = focused_screen.index

	local screens = {}

	-- Save tag state
	awful.screen.connect_for_each_screen(function(s)
		local tags = {}

		for _, t in pairs(awful.tag.gettags(s)) do
			local settings = {}

			settings.mwfact = awful.tag.getmwfact(t)
			settings.ncol = awful.tag.getncol(t)
			settings.nmaster = awful.tag.getnmaster(t)
			settings.layout = awful.layout.get(s).name

			tags[t.index] = settings
		end


		screens[s.index] = tags
	end)

	-- Save client state
	local clients = {}

	for i, c in pairs(client.get()) do
		clients[c.window] = {}
		clients[c.window].geometry = c:geometry()
	end

	local settings = {
		focused_screen = focused_screen,
		focused_tag = focused_tag,
		screens = screens,
		clients = clients
	}

	table.save(settings, awful.util.get_cache_dir() .. "/session_state")
	awesome.restart()
end

function M.session.load()
	local settings = table.load(awful.util.get_cache_dir() .. "/session_state")

	if not settings then
		return
	end

	local layout_function_of = {
		tile = awful.layout.suit.tile,
		tilebottom = awful.layout.suit.tile.bottom,
		max = awful.layout.suit.max,
		floating = awful.layout.suit.floating
	}

	local function get_screen_by_idx(index)
		local screen = nil

		awful.screen.connect_for_each_screen(function(s)
			if s.index == index then
				screen = s
			end
		end)

		return screen
	end

	local function get_tag_by_idx(index, tags)
		local tag = nil

		for _, t in pairs(tags) do
			if t.index == index then
				tag = t
			end
		end

		return tag
	end

	-- Restore tag state for all screens
	for s_index, tags in pairs(settings.screens) do
		local s = get_screen_by_idx(s_index)

		if s then
			local screen_tags = awful.tag.gettags(s)

			for t_index, t_settings in pairs(tags) do
				local t = get_tag_by_idx(t_index, screen_tags)

				if t then
					awful.layout.set(layout_function_of[t_settings.layout], t)
					t.master_width_factor = t_settings.mwfact
					t.column_count = t_settings.ncol
					t.master_count = t_settings.nmaster
					if t_index == settings.focused_tag then
						t:view_only()
					end
				end
			end

			if s_index == settings.focused_screen then
				awful.screen.focus(s)
			end
		end
	end

	-- Restore clients' geometry
	for _, c in pairs(client.get()) do
		if settings.clients[c.window] ~= nil then
			c:geometry(settings.clients[c.window].geometry)
		end
	end

	os.remove(awful.util.get_cache_dir() .. "/session_state")
end

function M.split(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

function M.scandir(directory)
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

function M.debug.notify(item)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "DEBUG NOTIFICATION",
		text = gears.debug.dump_return(item)
	})
end

function M.debug.dump_to_file(path, item)
	local file = io.open(path, "w")
	io.output(file)
	io.write(gears.debug.dump_return(item))
	io.close(file)
end

function M.set_wallpaper(wallpaper)
	wallpaper = wallpaper or beautiful.general.wallpaper
	if wallpaper then
		awful.screen.connect_for_each_screen(function(s)
			gears.wallpaper.maximized(wallpaper, s)
		end)
	end
end

function M.size_of_table(table)
	local count = 0

	for _, _ in pairs(table) do
		count = count + 1
	end

	return count
end

function M.read_command(cmd)
	local process = io.popen(cmd)
	local result = process:read("*a")
	process:close()
	result = result:sub(1, #result - 1)

	return result
end

-- Return the average amount between numbers
function M.average_of(numbers)
	local total_amount = 0
	local total_numbers = 0

	for _, v in pairs(numbers) do
		total_amount = total_amount + v
		total_numbers = total_numbers + 1
	end

	return total_amount / total_numbers
end

return M
