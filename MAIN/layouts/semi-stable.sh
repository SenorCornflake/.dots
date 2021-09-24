#!/usr/bin/env bash
exconman set herbstluftwm.frame_border_width 0
exconman set herbstluftwm.frame_bg_transparent on
exconman set herbstluftwm.frame_gap 0
exconman set herbstluftwm.theme.padding_left 0
exconman set herbstluftwm.theme.inner_width 0
exconman set herbstluftwm.theme.outer_width 0
exconman set herbstluftwm.theme.border_width 2
exconman set herbstluftwm.window_gap 10

exconman set alacritty.padding_x 10
exconman set alacritty.padding_y 10

exconman set kitty.window_padding_width 10

exconman set dunst.geometry "800x40-30+30"
exconman set dunst.padding 10
exconman set dunst.horizontal_padding 10
exconman set dunst.frame_width 2
exconman set dunst.corner_radius 0
exconman set dunst.font "Iosevka Nerd Font 10"

exconman set polybar.bar "5"
exconman set rofi.layout "bottom"

exconman set picom.shadow true
# Enable polybar shadows
exconman set picom.polybar_shadow "#"
# Enable rofi shadows
exconman set picom.rofi_shadow "#"
exconman set picom.shadow-radius 10
exconman set picom.shadow-offset-y -- "-10" # -- Allows you to pass in negative numbers
exconman set picom.shadow-offset-x -- "-10"
exconman set picom.shadow-opacity "0.5"
