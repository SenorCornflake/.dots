import os

wallpapers_dir = os.path.expanduser("~/Pictures/wallpapers")

wallpapers = os.listdir(wallpapers_dir)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Base16 Wallpaper"'.format("\n".join(wallpapers))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    os.system('awesome-client "require(\\"util\\").set_wallpaper(\\"{}\\")"'.format(wallpapers_dir + "/" + wallpapers[index]))
    os.system('exconman -r ~/environment/registry.json set awesome.general.wallpaper "{}"'.format(wallpapers_dir + "/" + wallpapers[index]))
