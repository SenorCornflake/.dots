#!/usr/bin/bash

active_monitor=0

add_monitor() {
	if [[ $active_monitor = "eDP-1" ]] || [[ $active_monitor = 0 ]]
	then
		xrandr --output VGA-1 --primary --auto
		
		bspc monitor eDP-1 -a Desktop

		for desktop in $(bspc query -D -m eDP-1 --names)
		do
			bspc desktop $desktop --to-monitor VGA-1
		done

		bspc monitor eDP-1 -r
		bspc desktop Desktop -r
		xrandr --output eDP-1 --off
		active_monitor="VGA-1"
	#else
	#	echo "VGA-1 already active"
	fi
}

remove_monitor() {
	if [[ $active_monitor = "VGA-1" ]] || [[ $active_monitor = 0 ]]
	then
		xrandr --output eDP-1 --primary --auto
		
		bspc monitor VGA-1 -a Desktop

		for desktop in $(bspc query -D --names -m VGA-1)
		do
			bspc desktop $desktop --to-monitor eDP-1
		done

		bspc monitor VGA-1 -r
		bspc desktop Desktop -r
		xrandr --output VGA-1 --off
		active_monitor="eDP-1"
	#else
	#	echo "eDP-1 already active"
	fi
}


if xrandr | grep -o "VGA-1 connected" >> /dev/null
then
	add_monitor
else
	remove_monitor
fi
