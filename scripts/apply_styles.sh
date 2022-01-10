#!/usr/bin/env bash

notify-send 'Applying styles, please wait...' -a ''
sh $DOT_ROOT/install.sh home
timeout 2s python $DOT_ROOT/scripts/neovim_command.py 'lua LOAD_THEME()'
notify-send 'Done!' -a ''
herbstclient reload
