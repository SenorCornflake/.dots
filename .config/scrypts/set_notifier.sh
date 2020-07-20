#!/bin/bash

if pgrep bspwm >/dev/null; then
    /usr/bin/dunst &
elif pgrep plasmashell >/dev/null; then
    /usr/bin/plasma_waitforname org.freedesktop.Notifications &
fi