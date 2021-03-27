-- Launch default programs
local awful = require("awful")

local programs = {}

programs.terminal = function()
	awful.spawn("alacritty")
end

programs.browser = function()
	awful.spawn("firefox")
end

programs.compositor = function()
	awful.spawn.easy_async_with_shell("pgrep picom", function(pid)
		-- Only start compositor if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("picom &")
		end
	end)
end

programs.disk_automounter = function()
	awful.spawn.easy_async_with_shell("pgrep udiskie", function(pid)
		-- Only start udiskie if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("udiskie &")
		end
	end)
end

programs.polkit = function()
	awful.spawn.easy_async_with_shell("pgrep polkit-gnome-authentication-agent-1", function(pid)
		-- Only start polkit if it's not already running
		if #pid == 0 then
			awful.spawn.with_shell("exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
		end
	end)
end

programs.package_list_updater = function()
	os.execute("killall sh ~/environment/scripts/auto_update_package_list.sh")
	awful.spawn.easy_async_with_shell("sh ~/environment/scripts/auto_update_package_list.sh")
end

programs.notification_daemon = function()
	os.execute("killall dunst")
	awful.spawn.easy_async_with_shell("dunst &")
end

---------------
-- AUTOSTART --
---------------
programs.notification_daemon()
programs.polkit()
programs.disk_automounter()
programs.compositor()
programs.package_list_updater()

return programs
