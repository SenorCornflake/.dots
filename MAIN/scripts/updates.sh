#!/bin/bash

while true; do
	sudo pacman -Sy >> /dev/null
	sudo pacman -Qu | wc -l > ~/MAIN/tmp/updates.txt
	notify-send "Found $(sudo pacman -Qu | wc -l) updates"
	sleep 1500
done
