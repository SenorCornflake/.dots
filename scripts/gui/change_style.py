import os
import yaml
import json

def remove_ext(file):
    return file.replace(".nix", "")

themes = os.listdir(os.path.expandvars("$DOT_ROOT/config/home/themes"))
themes_stripped = map(remove_ext, themes)
themes_stripped = list(themes_stripped)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper:"'.format("\n".join(themes_stripped))
index = os.popen(cmd).read()[:-1]

got_something = False

if index != "":
    index = int(index)
    theme = themes_stripped[index]

    got_something = True
    open(os.path.expandvars("$DOT_ROOT/scripts/storage/theme.txt"), "w").write(theme)

layouts = os.listdir(os.path.expandvars("$DOT_ROOT/config/home/layouts"))
layouts_stripped = map(remove_ext, layouts)
layouts_stripped = list(layouts_stripped)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper:"'.format("\n".join(themes_stripped))
cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper:"'.format("\n".join(layouts_stripped))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    layout = layouts_stripped[index]

    got_something = True
    open(os.path.expandvars("$DOT_ROOT/scripts/storage/layout.txt"), "w").write(layout)


if got_something:
    os.system("notify-send 'Applying styles, please wait...' -a ''")
    os.system("sh $DOT_ROOT/install.sh home")
    os.system("notify-send 'Done!' -a ''")
    os.system("python $DOT_ROOT/scripts/neovim_command.py 'lua LOAD_THEME()'")
    os.system("herbstclient reload")
