#!/bin/bash

while true; do
	notify-send "Updating package lists"
	sudo pacman -Sy >> /dev/null
	sudo pacman -Qu | wc -l > ~/MAIN/tmp/updates.txt
	sleep 3600s
done
