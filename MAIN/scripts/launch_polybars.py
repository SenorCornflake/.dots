"""
Every bar can have multiple bars within them that have to be enabled.
So this file automates it for us
"""
import os

def e(command):
    return os.popen(command).read()[:-1]

home = os.path.expanduser("~")

connected_monitors = e('xrandr --query | grep " connected " | cut -d" " -f1').split("\n")
primary_monitor = e('xrandr --query | grep " connected " | grep " primary " | cut -d" " -f1')

bars = os.listdir(home + "/.config/polybar/bars")
bars_dict = {}

for i, bar in enumerate(bars):
    bar = bar.replace(".ini", "")
    bars_dict[bar] = []

for k in bars_dict.keys():
    for m in connected_monitors:
        if k == "1":
            bars_dict[k].append(m)
        elif k == "2":
            bars_dict[k].append(m)
        elif k == "3":
            bars_dict[k].append(m)

enabled_bar = e("exconman get polybar.bar")

for bar in bars_dict[enabled_bar]:
    os.system("polybar -cr ~/.config/polybar/bars/" + enabled_bar + ".ini " + bar + " &")
