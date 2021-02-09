-- Launch default programs
local awful = require("awful")

local util = require("util")

local M = {}

function M.terminal()
	awful.spawn("alacritty")
end

function M.browser()
	awful.spawn("firefox")
end

function M.compositor()
	awful.spawn.easy_async_with_shell("pgrep picom", function(pid)
		-- Only start compositor if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("picom &")
		end
	end)
end

function M.disk_automounter()
	awful.spawn.with_shell("udiskie &")
end

function M.polkit()
	awful.spawn.with_shell("exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
end

return M
