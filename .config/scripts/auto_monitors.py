import os
import math
import sys

total_desktops = int(sys.argv[1])

def e(command):
    return os.popen(command).read()

def connected(monitor):
    return e('xrandr | grep %s | grep -w connected' % monitor)

enabled_monitors = [
    {
        "name": "VGA-1",
        "primary": True,
        'on_connect': ['xrandr --output VGA-1 --auto --primary --left-of eDP-1'],
        'on_disconnect': ['xrandr --output eDP-1 --auto --primary --output VGA-1 --off']
    },
    {
        "name": "eDP-1",
        "primary": False,
        'on_connect': [],
        'on_disconnect': []
    },
    {
        "name": "LVDS-1",
        "primary": False,
        'on_connect': [],
        'on_disconnect': []
    }
]

connected_monitors = []
for monitor in enabled_monitors:
    if connected(monitor['name']):
        connected_monitors.append(monitor)

def assign_workspaces(total_desktops = 10, give_remaining_desktops_to_primary = True):
    desktops_per_monitor = math.floor(total_desktops / len(connected_monitors))
    print('Desktops Per Monitor', desktops_per_monitor)
    remaining_desktops = total_desktops % (desktops_per_monitor * len(connected_monitors))
    print('Remaining Desktops', remaining_desktops)
    print("\n")

    start = 1
    for monitor in connected_monitors:
        desktops = desktops_per_monitor
        if monitor['primary']:
            desktops += remaining_desktops
        
        monitor['desktops_arr'] = []

        for desktop in range(start, total_desktops + 1):
            monitor['desktops_arr'].append(desktop)
            if desktop == start - 1 + desktops:
                start = desktop + 1
                break

def apply_workspaces():
    already_configged = not e('bspc query -D --names | grep Desktop')
    assign_workspaces(total_desktops)

    # Do the on connect command for monitor
    for monitor in connected_monitors:
        for c in monitor['on_connect']:
            e(c)
            print('connect', c)

    # Is this the first time we're setting workspaces
    if already_configged:
        for monitor in connected_monitors:
            e('bspc monitor %s -a Desktop' % monitor['name'])

            for desktop in monitor['desktops_arr']:
                command = 'bspc desktop %s --to-monitor %s' % (desktop, monitor['name'])
                e(command)
                print(command)
            print("\n")
    else: # If we have workspaces, don't reset them, rather move the desktops to their respective monitor
        for monitor in connected_monitors:
            e('bspc monitor %s -a Desktop' % monitor['name'])
            desktop_str = ' '.join([str(i) for i in monitor['desktops_arr']])
            command = 'bspc monitor %s -d %s' % (monitor['name'], desktop_str)
            e(command)
            print(command)
            print("\n")

    # If monitor disconnected, do it's on disconnect commands
    for monitor in enabled_monitors:
        if not connected(monitor['name']):
            for c in monitor['on_disconnect']:
                e(c)
                print('disconnect', c)
    
    # Remove extra desktops we or bspwm might've added
    while e('bspc query -D --names | grep Desktop'):
        e('bspc desktop Desktop --remove')
    
    # Arrange desktops (desktops get mixed up for some reason, too lazy to figure why)
    for monitor in connected_monitors:
        e('bspc monitor %s -o %s' % (monitor['name'], ' '.join([str(x) for x in monitor['desktops_arr']])))
        print()
        print('moved')
        print()
    

apply_workspaces()

print(connected_monitors)