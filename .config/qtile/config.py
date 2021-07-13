import os, subprocess

from libqtile import layout, hook, bar, widget
from libqtile.config import EzKey as Key, Group, Screen
from libqtile.lazy import lazy

import bindings
import screens
import layouts

groups = [Group(i) for i in "1234567890"]
#screens = screens.screens
screens = [
    Screen(),
    Screen()
]
layouts = layouts.layouts
keys = bindings.keys(groups)
mouse = bindings.mouse

@hook.subscribe.startup
def autostart():
    subprocess.Popen(["sh", os.path.expanduser("~/MAIN/scripts/autostart.sh")])
    #subprocess.Popen(["killall", "polybar"])
    #subprocess.Popen(["exconman", "set", "polybar.pin_workspaces", "false"])
    #subprocess.Popen(["python", os.path.expanduser("~/MAIN/scripts/launch_polybars.py")])
