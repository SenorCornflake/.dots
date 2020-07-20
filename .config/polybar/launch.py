import sys
import os
import json
import subprocess

def e(command):
    return os.popen(command).read()[:-1]

current_mode = e('python ~/.config/scrypts/LemonPotato/main.py query setting --name current_mode')
polybar_layout = e('python ~/.config/scrypts/LemonPotato/main.py query mode --name {} --key-path applications/polybar/layout'.format(current_mode))

connected_monitors = e('xrandr | grep " connected " | grep -Eo \'\\w+-[0-9]\'').split('\n')

e('killall polybar')
e('while pgrep -x polybar >/dev/null; do sleep 1; done')

for monitor in connected_monitors:
    if polybar_layout == 'alpha':
        os.system('polybar -c ~/.config/polybar/config.ini {} &'.format(monitor))
    elif polybar_layout == 'bravo':
        os.system('polybar -c ~/.config/polybar/config.ini top-{} &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini bottom-{} &'.format(monitor))
    elif polybar_layout == 'charlie':
        os.system('polybar -c ~/.config/polybar/config.ini top-{} &'.format(monitor))
        os.system('polybar -c ~/.config/polybar/config.ini bottom-{} &'.format(monitor))
