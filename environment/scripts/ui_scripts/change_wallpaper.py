import os

wallpapers_dir = os.path.expanduser("~/Pictures/wallpapers")

wallpapers = os.listdir(wallpapers_dir)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Base16 Wallpaper"'.format("\n".join(wallpapers))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    os.system('awesome-client "require(\\"CONFIG.util\\").set_wallpaper(\\"{}\\")"'.format(wallpapers_dir + "/" + wallpapers[index]))
    wallpaper = os.path.splitext(os.path.basename(wallpapers[index]))[0]

    # Disable shadows for some wallpapers (because it's ugly)
    if wallpaper == "generated":
        os.system("exconman set picom.shadow false")
    else:
        os.system("exconman set picom.shadow true")

    os.system('exconman set awesome.general.wallpaper "{}"'.format(wallpapers_dir + "/" + wallpapers[index]))
