#!/bin/bash

while true; do notify-send "Updating Packages"; sudo pacman -Sy > /dev/null; sleep 3600s; done
