import sys
import os
import re

def e(command):
    return os.popen(command).read()[:-1]

desktops = {
    "VGA-1": ["1", "2", "3", "4", "5", "6", "7", "8"],
    "eDP-1": ["9", "10"]
}

# Get connected monitors
connected_monitors = e('xrandr --query')
connected_monitors = re.findall("\\w+-\\w+ connected", connected_monitors)
connected_monitors = [monitor.replace(" connected", "") for monitor in connected_monitors]

existing_desktops = e("bspc query -D --names").split("\n")
orphaned_desktops = {}

for monitor in desktops:
    if not monitor in connected_monitors:
        orphaned_desktops[monitor] = desktops[monitor]
        desktops[monitor] = []

for disconnected_monitor in orphaned_desktops:
    disconnected_monitor_index = list(desktops.keys()).index(disconnected_monitor)
    nearest_left_monitor = None
    nearest_right_monitor = None
    
    # Find nearest connected monitor on the left side
    for monitor in desktops:
        if monitor in connected_monitors:
            monitor_index = list(desktops.keys()).index(monitor)

            if monitor_index < disconnected_monitor_index:
                nearest_left_monitor = monitor

    # Find nearest connected monitor on the right side
    for monitor in reversed(desktops.keys()):
        if monitor in connected_monitors:
            monitor_index = list(desktops.keys()).index(monitor)

            if monitor_index > disconnected_monitor_index:
                nearest_right_monitor = monitor

    if nearest_left_monitor != None and nearest_right_monitor == None:
        # Give desktops to nearest left monitor
        desktops[nearest_left_monitor] += orphaned_desktops[disconnected_monitor]

    elif nearest_left_monitor == None and nearest_right_monitor != None:
        # Give desktops to nearest right monitor
        desktops[nearest_right_monitor] = orphaned_desktops[disconnected_monitor] + desktops[nearest_right_monitor]

    elif nearest_left_monitor != None and nearest_right_monitor != None:
        nearest_left_monitor_index = list(desktops.keys()).index(nearest_left_monitor)
        nearest_right_monitor_index = list(desktops.keys()).index(nearest_right_monitor)

        # Get the distance
        nearest_left_monitor_distance = disconnected_monitor_index - nearest_left_monitor_index
        nearest_right_monitor_distance = nearest_right_monitor_index - disconnected_monitor_index

        # Nearest distance gets the desktops
        if nearest_left_monitor_distance < nearest_right_monitor_distance:
            desktops[nearest_left_monitor] += orphaned_desktops[disconnected_monitor]

        elif nearest_right_monitor_distance < nearest_left_monitor_distance:
            desktops[nearest_right_monitor] = orphaned_desktops[disconnected_monitor] + desktops[nearest_right_monitor]

        else: # Choose the left one if there is a tie
            desktops[nearest_left_monitor] += orphaned_desktops[disconnected_monitor]



for monitor in desktops:
    # Add temp desktop
    e("bspc monitor {} -a Temp".format(monitor))

for monitor in desktops:
    if len(desktops[monitor]) > 0:
        for desktop in desktops[monitor]:
            if not desktop in existing_desktops:
                e("bspc monitor {} -a {}".format(monitor, desktop))
            e("bspc desktop {} --to-monitor {}".format(desktop, monitor))
        e("bspc monitor {} -o {}".format(monitor, " ".join(desktops[monitor])))

# Remove all temp desktops
for _ in desktops:
    e("bspc desktop Temp --remove")
    e("bspc desktop Desktop --remove")

# remove disconnected monitors
for monitor in desktops:
    if not monitor in connected_monitors:
        e("bspc monitor {} --remove".format(monitor))

# Remove all temp desktops
for _ in desktops:
    e("bspc desktop Temp --remove")
    e("bspc desktop Desktop --remove")

print("orhpaned_desktops", orphaned_desktops)
print("desktops", desktops)
