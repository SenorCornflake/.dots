#!/bin/bash

# Reload bspwm
bspc wm -r

# Reload xsettingsd
killall xsettingsd
xsettingsd &

# Reload neovim
python ~/MAIN/scripts/neovim_command.py ":luafile ~/.config/nvim/init.lua" &
