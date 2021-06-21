#!/bin/bash

# Reload bspwm
bspc wm -r

# Reload herbstluftwm
herbstclient reload

# Reload xsettingsd
killall xsettingsd
xsettingsd &

# Reload neovim
python ~/MAIN/scripts/neovim_command.py ":luafile ~/.config/nvim/init.lua" &

# Xsettings
killall xsettingsd
xsettingsd &
