#!/usr/bin/env bash

killall -USR1 kitty

# Kill dunst, will be started later by wm config
killall dunst

# Reload xsettings
killall xsettingsd

herbstclient reload

# Sometimes this hangs, I don't know why, just kill it after 5 seconds
timeout 5s python $DOTFILES_BRAIN_ROOT/scripts/neovim_command.py ":lua require('neovim_configuration.util').reload()"
