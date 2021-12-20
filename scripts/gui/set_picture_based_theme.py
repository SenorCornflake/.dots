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

        os.system("feh --no-fehbg --bg-fill \"$WALL_ROOT/{}\"".format(wallpaper))
        os.system("echo \"$WALL_ROOT/{}\" > $DOT_ROOT/scripts/storage/wallpaper.txt".format(wallpaper))

        theme = os.popen("flavours generate {} $WALL_ROOT/{} --stdout > $DOT_ROOT/scripts/storage/base16.yaml".format(style, wallpaper)).read()[:-1]

        # Generate json file for nix config
        theme = open(os.path.expandvars("$DOT_ROOT/scripts/storage/base16.yaml"), "r").read()
        theme = yaml.load(theme, Loader=yaml.FullLoader)
        theme = json.dumps(theme)
        open(os.path.expandvars("$DOT_ROOT/scripts/storage/base16.json"), "w").write(theme)

        # Generate neovim theme
        os.system("flavours build $DOT_ROOT/scripts/storage/base16.yaml ~/.local/share/flavours/base16/templates/vim/templates/default.mustache > $DOT_ROOT/scripts/storage/vim/colors/generated.vim")

        # Generate kitty theme
        os.system("flavours build $DOT_ROOT/scripts/storage/base16.yaml ~/.local/share/flavours/base16/templates/kitty/templates/default.mustache > $DOT_ROOT/scripts/storage/kitty/colors/generated.conf")

        # Set theme to base16
        open(os.path.expandvars("$DOT_ROOT/scripts/storage/theme.txt"), "w").write("base16")

        os.system("notify-send 'Applying styles, please wait...' -a ''")
        os.system("sh $DOT_ROOT/install.sh home")
        os.system("notify-send 'Done!' -a ''")
        os.system("python $DOT_ROOT/scripts/neovim_command.py 'lua LOAD_THEME()'")
        os.system("herbstclient reload")
