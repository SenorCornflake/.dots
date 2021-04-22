#!/bin/bash

while true; do notify-send "Updating Package List"; sudo pacman -Sy > /dev/null; sleep 3600s; done
