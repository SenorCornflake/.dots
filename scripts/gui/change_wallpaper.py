import os

wallpapers = os.listdir(os.path.expandvars("$WALL_ROOT"))

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join(wallpapers))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    wallpaper = wallpapers[index]

    os.system("feh --no-fehbg --bg-fill \"$WALL_ROOT/{}\"".format(wallpaper))
    os.system("echo \"$WALL_ROOT/{}\" > $DOT_ROOT/scripts/storage/wallpaper.txt".format(wallpaper))
