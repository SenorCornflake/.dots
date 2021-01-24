#!/bin/bash
if [[ "$(tty)" = "/dev/tty1" ]]; then
	PS3='Choose a window manager: '
	options=("bspwm" "awesome")
	select opt in "${options[@]}"
	do
		case $opt in
			"bspwm")
				startx ~/.config/X11/bspwm_xinitrc
				;;
			"awesome")
				startx ~/.config/X11/awesome_xinitrc
				;;
			"None")
				break
				;;
			*) echo "\"$REPLY\" is invalid.";;
		esac
	done
fi

