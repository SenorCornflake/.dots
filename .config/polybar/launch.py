import sys
import os
import json
import subprocess

def e(command):
    return os.popen(command).read()[:-1]

current_modifier = e('audot query config modifier')
current_bar = e('audot query modifier {} programs/polybar/settings/bar/value'.format(current_modifier))

print("Current Modifer:", current_modifier)
print("Current Bar:", current_bar)

connected_monitors = e('xrandr | grep " connected " | grep -Eo \'\\w+-[0-9]\'').split('\n')

e('killall polybar')
e('while pgrep -x polybar >/dev/null; do sleep 1; done')

for monitor in connected_monitors:
    if current_bar == 'alpha':
        os.system('polybar -c ~/.config/polybar/config.ini {} &'.format(monitor))
