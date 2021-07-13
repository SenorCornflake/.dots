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

bar_names = os.listdir(home + "/.config/polybar/bars")
bars = {}

for i, bar in enumerate(bar_names):
    bar_names[i] = bar.replace(".ini", "")

for i, bar in enumerate(bar_names):
    # Specify the names of the bars that have more than one bar
    if bar == "4":
        bars[bar] = []
        bars[bar].append("top")
        bars[bar].append("bottom")
    if bar == "do-you-even-luft":
        bars[bar] = []
        bars[bar].append("left")
        bars[bar].append("right")
    else:
        bars[bar] = []
        bars[bar].append("main")

enabled_bar = e("exconman get polybar.bar")

for m in connected_monitors:
    for bar in bars[enabled_bar]:
        cmd = ""
        if m == primary_monitor:
            cmd = 'MONITOR={} polybar -c ~/.config/polybar/config.ini {}_primary &'.format(m, bar)
        else:
            cmd = 'MONITOR={} polybar -c ~/.config/polybar/config.ini {} &'.format(m, bar)

        os.system(cmd)
