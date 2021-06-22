#/bin/bash
# Start Programs that are always started regardless of wm


# Notification daemon
pidof dunst && killall dunst
dunst &

# Compositor
pidof picom || picom --experimental-backends --shadow-ignore-shaped &

# Polkit
pidof /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# X settings
xset r rate 250 30 
xsetroot -cursor_name left_ptr

# Update interval
pidof /bin/bash ~/MAIN/scripts/updates.sh || ~/MAIN/scripts/updates.sh &

# Enable nightmode if it was enabled prior to restarting
python ~/MAIN/scripts/nightmode.py
