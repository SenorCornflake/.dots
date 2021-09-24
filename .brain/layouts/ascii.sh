#!/usr/bin/env bash

exconman set herbstluftwm.frame_border_width 0
exconman set herbstluftwm.frame_bg_transparent on
exconman set herbstluftwm.frame_gap 0
exconman set herbstluftwm.theme.padding_left 0
exconman set herbstluftwm.theme.inner_width 0
exconman set herbstluftwm.theme.outer_width 0
exconman set herbstluftwm.theme.border_width 2
exconman set herbstluftwm.window_gap 10
exconman set herbstluftwm.theme.normal.color "#4A4A4A"
exconman set herbstluftwm.theme.active.color "#B6B6B6"
exconman set herbstluftwm.theme.urgent.color "#7A0000"

exconman set misc.wallpaper "$HOME/wallpapers/other/blue.png"

exconman set alacritty.padding_x 0
exconman set alacritty.padding_y 0

exconman set kitty.window_padding_width 0
exconman set kitty.colorscheme "~/.config/kitty/colors/console.conf"
exconman set kitty.font_family "Iosevka Nerd Font"
exconman set kitty.font_size "10"

exconman set dunst.geometry "800x40-30+30"
exconman set dunst.padding 10
exconman set dunst.horizontal_padding 10
exconman set dunst.frame_width 2
exconman set dunst.corner_radius 0
exconman set dunst.font '"AcPlus IBM VGA 9x16 12"'
exconman set dunst.background "#000000"
exconman set dunst.foreground "#F2F2F2"
exconman set dunst.frame_color "#007A7A"

exconman set polybar.bar "ascii"
exconman set rofi.layout "ascii"

exconman set picom.shadow true
# Enable polybar shadows
exconman set picom.polybar_shadow "#"
# Enable rofi shadows
exconman set picom.rofi_shadow "#"
exconman set picom.shadow-radius 5
exconman set picom.shadow-offset-y -- "-5" # "--" Allows you to pass in negative numbers
exconman set picom.shadow-offset-x -- "-5"
exconman set picom.shadow-opacity "1"

exconman set neovim.colorscheme "material"

exconman set xsettingsd.ThemeName "Chicago95"
exconman set xsettingsd.IconThemeName "Chicago95"
exconman set xsettingsd.FontName "Noto Sans, 10"
exconman set xsettingsd.CursorThemeName "adwaita"
