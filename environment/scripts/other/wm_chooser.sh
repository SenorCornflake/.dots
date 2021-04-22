#!/bin/bash

# Display a prompt to use awesomewm or bspwm
if [[ "$(tty)" = "/dev/tty1" ]]; then
	PS3='Choose a window manager: '
	options=("awesome" "bspwm")
	select opt in "${options[@]}"
	do
		case $opt in
			"awesome")
				startx ~/.config/X11/awesome_xinitrc
				;;
			"bspwm")
				startx ~/.config/X11/bspwm_xinitrc
				;;
			"None")
				break
				;;
			*) echo "\"$REPLY\" is invalid.";;
		esac
	done
fi

