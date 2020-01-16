#/bin/bash

mkdir -p ~/.config
cp -r ./.config ~/
cp -r ./.scripts ~/

chmod +x ~/.config/bspwm/bspwmrc
