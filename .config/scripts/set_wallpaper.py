import os
import sys
import json

def e(command):
    return os.popen(command).read()[:-1]

connected_monitors = []

for monitor in e('xrandr --query | grep " connected " | awk \'{print $1}\'').split("\n"):
    connected_monitors.append(monitor)
print(connected_monitors)

theme = json.loads(open(os.path.expanduser('~/.config/scripts/storage/theme.json') ,'r').read())['theme']
themefile = json.loads(open(os.path.expanduser(theme), 'r').read())

wallpapers = os.listdir(os.path.expanduser('~/.config/bspwm/wallpapers'))
chosen_wallpapers = []


for i, _ in enumerate(connected_monitors):
    wallpaper = e('echo "{}" | rofi -dmenu -i -p "Wallpaper {}" -columns 1'.format("\n".join(wallpapers), i))
    
    if wallpaper != '':
        chosen_wallpapers.append('~/.config/bspwm/wallpapers/' + wallpaper)

if len(chosen_wallpapers) > 0:
    chosen_wallpapers = " ".join(chosen_wallpapers)

    themefile['config']['bspwm']['<>|wallpaper|<>']['value'] = chosen_wallpapers
    themefile = json.dumps(themefile, indent=4, sort_keys=False)
    open(os.path.expanduser(theme), 'w').write(themefile)
    e('feh --no-fehbg --bg-fill {}'.format(chosen_wallpapers))
