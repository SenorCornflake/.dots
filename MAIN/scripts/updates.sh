#!/usr/bin/env bash

while true; do
	# sudo pacman -Sy >> /dev/null
	# sudo pacman -Qu | wc -l > $DOTFILES_BRAIN_ROOT/tmp/updates.txt
	notify-send "Found $(sudo pacman -Qu | wc -l) updates"
	sleep 3
done
