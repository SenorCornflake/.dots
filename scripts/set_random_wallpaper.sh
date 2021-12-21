#!/usr/bin/env bash

wallpaper=$(find $WALL_ROOT -type f | shuf -n1)

echo $result

feh --no-fehbg --bg-fill $wallpaper
notify-send "$wallpaper" -a ""
echo $wallpaper > $DOT_ROOT/scripts/storage/wallpaper.txt
