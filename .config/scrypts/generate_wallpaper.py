import sys
import os
import random

def e(command):
    return os.popen(command).read()[:-1]

modifier = e('audot query config modifier')
color = e('audot query modifier {} programs/dunst/settings/normal_background_color/value'.format(modifier))

os.system('convert -size 1920x1080 xc:{} ~/Pictures/wallpapers/generated.png'.format(color))
os.system('feh --no-fehbg --bg-fill ~/Pictures/wallpapers/generated.png')
