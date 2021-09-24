import os
import sys

# Listen to me veeeeeeeeeeeeeeeery carefully my dear friend. This here script aint easy on the eyes, or the ears, or anything at all really, but it does work... for now.

wallpaper_root = os.path.expanduser(sys.argv[1])

# Wallpapers are split into whichever popular theme they match best, here we specify which folders are for which themes
collections = {
    "c1": [
        "gruvbox"
    ],
    "c2": [
        "nightfly"
    ]
}

collection_dirs = os.listdir(wallpaper_root)

menu = []

for c in collections:
    for t in collections[c]:
        menu.append(t)

menu.append("other")

non_categorized_wallpapers = []
non_categorized_wallpapers_absolute = []

for c in collection_dirs:
    if not c in collections:
        for w in os.listdir("{}/{}/".format(wallpaper_root, c)):
            non_categorized_wallpapers_absolute.append("{}/{}/{}".format(wallpaper_root, c, w))
            non_categorized_wallpapers.append("{}".format(w))


cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper"'.format("\n".join(menu))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    chosen_theme = menu[index]

    if chosen_theme == "other":
        cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper"'.format("\n".join(non_categorized_wallpapers))
        index = os.popen(cmd).read()[:-1]
        if index != "":
            index = int(index)
            chosen_wallpaper = non_categorized_wallpapers_absolute[index]
            os.system('feh --no-fehbg --bg-fill "{}"'.format(chosen_wallpaper))
            os.system('exconman set misc.wallpaper "{}"'.format(chosen_wallpaper))
    else:
        for c in collections:
            for t in collections[c]:
                if t == chosen_theme:
                    wallpapers = os.listdir("{}/{}".format(wallpaper_root, c))
                    cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper"'.format("\n".join(wallpapers))
                    index = os.popen(cmd).read()[:-1]
                    if index != "":
                        index = int(index)
                        chosen_wallpaper = wallpapers[index]
                        os.system('feh --no-fehbg --bg-fill "{}/{}/{}"'.format(wallpaper_root, c, chosen_wallpaper))
                        os.system('exconman set misc.wallpaper "{}/{}/{}"'.format(wallpaper_root, c, chosen_wallpaper))
                    break
