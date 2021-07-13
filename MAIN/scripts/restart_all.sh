#!/bin/bash

wmname=$(wmctrl -m | head -n 1 | sed "s/\w\+: //g")

# Reload all kitty instances
killall -USR1 kitty

if [[ $wmname == "bspwm" ]]; then
	# Reload bspwm
	bspc wm -r
elif [[ $wmname == "herbstluftwm" ]]; then
	# Reload herbstluftwm
	herbstclient reload
elif [[ $wmname == "qtile" ]]; then
	# Reload qtile
	qtile cmd-obj -o cmd -f restart
fi

if [[ $wmname != "kwin" && $wmname != "mutter" ]]; then
	# Reload xsettingsd
	killall xsettingsd
	xsettingsd &
fi

# Reload neovim
python ~/MAIN/scripts/neovim_command.py ":luafile ~/.config/nvim/init.lua" &
