#!/bin/bash

function VGAConnected {
    xrandr | grep VGA-1 | grep " connected "
}

function VGAAlivetoB {
    bspc query -M --names | grep VGA-1
}

function EDPAlivetoB {
    bspc query -M --names | grep eDP-1
}


if VGAConnected
then
    if EDPAlivetoB
    then
        bspc monitor eDP-1 -r
    fi
    xrandr --output VGA-1 --primary --auto --output eDP-1 --off
    bspc monitor VGA-1 -d 1 2 3 4 5 6 7 8 9 0

else
    if VGAAlivetoB
    then
        bspc monitor VGA-1 -r
    fi
    xrandr --output eDP-1 --primary --auto
    bspc monitor eDP-1 -d Firefox Nvim Terminal 1 2 3 4 5 6 7 8 9 0

fi
