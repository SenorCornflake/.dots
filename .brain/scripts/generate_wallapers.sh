#!/usr/bin/env bash

# Generate plain color background
bg=$(exconman get polybar.1_bg)
convert -size 1920x1080 xc:"$bg" ~/wallpapers/other/solid.png

# Generate background with dots
bg=$(exconman get polybar.3_bg)
fg=$(exconman get polybar.3_fg)
convert -size 35x35 xc:"$bg" -fill "$fg" -draw "rectangle 17,17 17,17" $DOTFILES_BRAIN_ROOT/tmp/tiler.png
convert -size 1920x1080 tile:"$DOTFILES_BRAIN_ROOT/tmp/tiler.png" ~/wallpapers/other/simple-dots.png
rm $DOTFILES_BRAIN_ROOT/tmp/tiler.png

# Generate background thicker with dots
bg=$(exconman get polybar.3_bg)
fg=$(exconman get polybar.3_fg)
convert -size 100x100 xc:"$bg" -fill "$fg" -draw "rectangle 49,49 51,51" $DOTFILES_BRAIN_ROOT/tmp/tiler.png
convert -size 1920x1080 tile:"$DOTFILES_BRAIN_ROOT/tmp/tiler.png" ~/wallpapers/other/simple-thick-dots.png
rm $DOTFILES_BRAIN_ROOT/tmp/tiler.png
