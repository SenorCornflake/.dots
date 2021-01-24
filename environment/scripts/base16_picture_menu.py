import os
import sys

wallpapers_dir = os.path.expanduser("~/Pictures/wallpapers")

wallpapers = os.listdir(wallpapers_dir)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Base16 Wallpaper"'.format("\n".join(wallpapers))

index = os.popen(cmd).read()[:-1]

backend = sys.argv[1]
type = sys.argv[2]

if index != "":
    index = int(index)
    os.system('python ~/environment/scripts/create_base16_from_picture.py {} {} "{}"'.format(backend, type, wallpapers_dir + "/" + wallpapers[index]))
