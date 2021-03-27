local awful = require("awful")

local util = require("util")
local client_functions = require("client_functions")

require("table_serialization")

local session = {}

function session.restart()
	local focused_screen = awful.screen.focused({ mouse = false, client = true })
	local focused_tag = focused_screen.selected_tag.index
	local focused_client = nil
	if client.focus ~= nil then
		focused_client = client.focus.window
	end

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

	for _, c in pairs(client.get()) do
		clients[c.window] = {}
		clients[c.window].geometry = c:geometry()
		local wfact = client_functions.getwfact(c, c.first_tag)
		clients[c.window].wfact = wfact
	end

	local settings = {
		focused_screen = focused_screen,
		focused_tag = focused_tag,
		focused_client = focused_client,
		screens = screens,
		clients = clients
	}

	table.save(settings, awful.util.get_cache_dir() .. "/session_state")
	awesome.restart()
end

function session.load()
	client.connect_signal("scanned", function()
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

		-- Restore clients
		for _, c in pairs(client.get()) do
			if settings.focused_client ~= nil and c.window == settings.focused_client then
				client.focus = c
			end

			if settings.clients[c.window] ~= nil then
				local c_settings = settings.clients[c.window]
				-- Restore geometry for floating windows
				c:geometry(c_settings.geometry)
				-- Restore client window factor (THIS DOES NOT WORK, GAVE UP ON TRYING BUT LEFT IT HERE FOR FUTURE)
				if c_settings.wfact ~= nil then
					client_functions.setwfact(c_settings.wfact, c, c.first_tag)
				end
			end
		end

		os.remove(awful.util.get_cache_dir() .. "/session_state")
	end)
end

return session
