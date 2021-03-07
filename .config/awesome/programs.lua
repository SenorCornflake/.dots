-- Launch default programs
local awful = require("awful")

local util = require("util")

local programs = {}

function programs.terminal()
	awful.spawn("alacritty")
end

function programs.browser()
	awful.spawn("firefox")
end

function programs.compositor()
	awful.spawn.easy_async_with_shell("pgrep picom", function(pid)
		-- Only start compositor if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("picom &")
		end
	end)
end

function programs.disk_automounter()
	awful.spawn.easy_async_with_shell("pgrep udiskie", function(pid)
		-- Only start udiskie if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("udiskie &")
		end
	end)
end

function programs.polkit()
	awful.spawn.easy_async_with_shell("pgrep polkit-gnome-authentication-agent-1", function(pid)
		-- Only start polkit if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
		end
	end)
end

return programs
