#!/usr/bin/env bash

# Start Programs that are always started regardless of wm

# Notification daemon
pidof dunst || dunst &

# Update interval
pgrep updates.sh || $DOTFILES_BRAIN_ROOT/scripts/updates.sh &

# Compositor
pidof picom || picom --experimental-backends --shadow-ignore-shaped &

# Thingy
pidof xsettingsd || xsettingsd &

# Polkit
pidof /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# X settings
xset r rate 250 30 
xsetroot -cursor_name left_ptr

# Enable nightmode if it was enabled prior to restarting
python $DOTFILES_BRAIN_ROOT/scripts/nightmode.py

# WALLPAPERS #
sh $DOTFILES_BRAIN_ROOT/scripts/generate_wallapers.sh
sh $DOTFILES_BRAIN_ROOT/scripts/set_wallpaper.sh
