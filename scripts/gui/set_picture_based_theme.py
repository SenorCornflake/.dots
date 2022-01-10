import os
import yaml
import json

wallpapers = os.listdir(os.path.expandvars("$WALL_ROOT"))

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper:"'.format("\n".join(wallpapers))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    wallpaper = wallpapers[index]

    styles = ["dark", "light"]
    cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Style:"'.format("\n".join(styles))

    index = os.popen(cmd).read()[:-1]

    if index != "":
        index = int(index)
        style = styles[index]

        os.system("echo \"$WALL_ROOT/{}\" > $DOT_ROOT/scripts/storage/wallpaper.txt".format(wallpaper))

        theme = os.popen("flavours generate {} $WALL_ROOT/{} --stdout > $DOT_ROOT/scripts/storage/base16.yaml".format(style, wallpaper)).read()[:-1]

        # Generate json file for nix config
        theme = open(os.path.expandvars("$DOT_ROOT/scripts/storage/base16.yaml"), "r").read()
        theme = yaml.load(theme, Loader=yaml.FullLoader)
        theme = json.dumps(theme)
        open(os.path.expandvars("$DOT_ROOT/scripts/storage/base16.json"), "w").write(theme)

        os.system("sh $DOT_ROOT/scripts/setup_base16.sh")

