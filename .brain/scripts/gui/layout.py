import os
import sys

def menu(prompt, items, trim = True):
    cmd = 'echo "{}" | rofi -dmenu -format i -i -p "{}"'.format("\n".join(items), prompt)

    index = os.popen(cmd).read()

    if trim:
        index = index[:-1]

    if index == "":
        return None
    else:
        return int(index)

layouts_root = os.path.expandvars("$DOTFILES_BRAIN_ROOT/layouts")
layouts = os.listdir(layouts_root)

index = menu("Layout: ", layouts)

if index == None:
    sys.exit()

layout = layouts[index]
os.system('sh "{}/{}"'.format(layouts_root, layout))
os.system("sh $DOTFILES_BRAIN_ROOT/scripts/restart.sh")

