import sys
import os
import json
import subprocess

def e(command):
    return os.popen(command).read()[:-1]

current_modifier = e('audot query config modifier')
current_bar = e('audot query modifier {} programs/polybar/settings/bar/value'.format(current_modifier))
current_bar = "alpha"

print("Current Modifer:", current_modifier)
print("Current Bar:", current_bar)

connected_monitors = e('xrandr | grep " connected " | grep -Eo \'\\w+-[0-9]\'').split('\n')

print("Connected Monitors:", ", ".join(connected_monitors))

e('killall polybar')
e('while pgrep -x polybar >/dev/null; do sleep 1; done')

for monitor in connected_monitors:
    if current_bar == 'alpha':
        os.system('polybar -c ~/.config/polybar/config.ini {} &'.format(monitor))
    elif current_bar == 'bravo':
        os.system('polybar -c ~/.config/polybar/config.ini {}_top_center &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini {}_top_right &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini {}_top_left &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini {}_bottom_center &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini {}_bottom_right &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini {}_bottom_left &'.format(monitor))

os.system("sleep 4s && python ~/.config/scrypts/bspwm_resize_window_padding.py")
