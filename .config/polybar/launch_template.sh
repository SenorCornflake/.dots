#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch

for mon in $(xrandr --query | grep " connected " | cut -d" " -f1); do
    polybar -c ~/.config/polybar/types/<>|type|<>/config.ini $mon &
done