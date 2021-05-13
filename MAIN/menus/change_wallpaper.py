import os
import sys

wallpaper_dir = os.path.expanduser(sys.argv[1])

wallpapers = os.listdir(wallpaper_dir)
cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper"'.format("\n".join(wallpapers))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    os.system('feh --no-fehbg --bg-fill "{}"'.format(wallpaper_dir + "/" + wallpapers[index]))

    os.system('exconman set bspwm.wallpaper "{}"'.format(wallpaper_dir + "/" + wallpapers[index]))

