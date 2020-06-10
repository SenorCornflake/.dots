import os
import math
import sys

monitors = [
    'VGA-1',
    'eDP-1'
]

import inspect

def lineno():
    """Returns the current line number in our program."""
    return inspect.currentframe().f_back.f_lineno

# Runs shell commands and returns the output ([:-1] also removes extra newline )
def e(command):
    return os.popen(command).read()[:-1]

# Checks if monitor is connected
def connected(monitor):
    return e('xrandr | grep {} | grep -w connected'.format(monitor))

connected_monitors = []

for monitor in monitors:
    if connected(monitor):
        connected_monitors.append(monitor)

def c(monitor):
    return monitor in connected_monitors

def desktop_exists(desktop, monitor = ''):
    if monitor != '':
        monitor = ' -m {}'.format(monitor)
    
    return desktop in e('bspc query -D{} --names'.format(monitor)).split("\n")

desktops = '1 2 3 4 5 6 7 8 9 10'.split(' ')

if c('VGA-1') and c('eDP-1'):

    e('bspc monitor VGA-1 -a Desktop')
    e('bspc monitor eDP-1 -a Desktop')

    e('xrandr --output VGA-1 --auto --primary --left-of eDP-1')

    for desktop in desktops[:6]:
        if desktop_exists(desktop):
            e('bspc desktop {} --to-monitor VGA-1'.format(desktop))
        else:
            e('bspc monitor VGA-1 -a {}'.format(desktop))
    
    for desktop in desktops[6:]:
        if desktop_exists(desktop):
            e('bspc desktop {} --to-monitor eDP-1'.format(desktop))
        else:
            e('bspc monitor eDP-1 -a {}'.format(desktop))

    e('bspc monitor VGA-1 -o {}'.format(" ".join(desktops[:6])))
    e('bspc monitor eDP-1 -o {}'.format(" ".join(desktops[6:])))
    

elif not c('VGA-1') and c('eDP-1'):
    e('bspc monitor eDP-1 -a Desktop')

    e('xrandr --output VGA-1 --off --output eDP-1 --auto --primary')

    for desktop in desktops:
        if desktop_exists(desktop):
            e('bspc desktop {} --to-monitor eDP-1'.format(desktop))
        else:
            e('bspc monitor eDP-1 -a {}'.format(desktop))
    
    e('bspc monitor eDP-1 -o {}'.format(" ".join(desktops)))

    e('bspc monitor VGA-1 --remove')

count = 0
while desktop_exists('Desktop') and count <= 10:
    e('bspc desktop Desktop --remove')
    print('hello')
    count += 1