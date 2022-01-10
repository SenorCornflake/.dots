#!/usr/bin/env bash

# Generate neovim theme
flavours build $DOT_ROOT/scripts/storage/base16.yaml ~/.local/share/flavours/base16/templates/vim/templates/default.mustache > $DOT_ROOT/scripts/storage/vim/colors/generated.vim

# Generate kitty theme
flavours build $DOT_ROOT/scripts/storage/base16.yaml ~/.local/share/flavours/base16/templates/kitty/templates/default.mustache > $DOT_ROOT/scripts/storage/kitty/colors/generated.conf

# Generate wezterm theme
flavours build $DOT_ROOT/scripts/storage/base16.yaml $DOT_ROOT/scripts/storage/base16-templates/wezterm.mustache > $DOT_ROOT/scripts/storage/wezterm/colors/generated.toml

echo -n "base16" > $DOT_ROOT/scripts/storage/theme.txt

notify-send 'Applying styles, please wait...' -a ''
sh $DOT_ROOT/install.sh home
notify-send 'Done!' -a ''
timeout 2s python $DOT_ROOT/scripts/neovim_command.py 'lua LOAD_THEME()'
herbstclient reload
