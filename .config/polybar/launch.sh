#!/usr/bin/env zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/config.ini top  --reload &
    MONITOR=$m polybar -c ~/.config/polybar/config.ini bottom --reload &
  done
else
  polybar --reload example &
fi

# Launch
# polybar -c ~/.config/polybar/config.ini top &
# polybar -c ~/.config/polybar/config.ini bottom &
