#!/bin/sh

# AUTOSTART
# Notification daemon
pidof dunst || dunst &

# Polkit
sh ~/.config/herbstluftwm/polkit

# X settings
xset r rate 250 30 
xsetroot -cursor_name left_ptr
setxkbmap -option keypad:pointerkeys
xkbset ma 1 5 70 6 0

# Enable nightmode if it was enabled prior to restarting
# python $DOT_ROOT/scripts/night_mode.py

if [[ -f "$DOT_ROOT/scripts/storage/first_start.txt" ]]; then
	rm "$DOT_ROOT/scripts/storage/first_start.txt"
	autorandr --change
fi

# WALLPAPERS #
sh ~/.config/herbstluftwm/wallpaper

# MONITORS #
hc detect_monitors

sh ~/.config/herbstluftwm/keybindings
sh ~/.config/herbstluftwm/settings
sh ~/.config/herbstluftwm/rules

systemctl --user stop polybar
#systemctl --user start polybar
systemctl --user start picom
