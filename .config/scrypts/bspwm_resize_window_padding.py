import os

def e(command):
    return os.popen(command).read()[:-1]

desktops = e("bspc query -D")
desktops = desktops.split("\n")

for desktop in desktops:
    e("bspc desktop {} -l next".format(desktop))
    e("bspc desktop {} -l next".format(desktop))
