
import os

def e(command):
    return os.popen(command).read()

placeholders = {
    '</color/>': e("xrdb -query | grep termite -i | grep color -i -w | grep -oE '\\|[a-z0-9-]+\\|' | sed 's/|//g'").replace("\n", "")
}

custom_template = os.path.expanduser('~/dotfiles/.config/termite/config-template')

tempfile = open(custom_template, 'r').read()

for p in placeholders:
    if p == '</color/>':
        placeholders[p] = open(os.path.expanduser('~/.config/termite/colors/' + placeholders[p] + '.config'), 'r').read()

    tempfile = tempfile.replace(p, placeholders[p])

open(os.path.expanduser('~/dotfiles/.config/termite/config'), 'w+').write(tempfile)
print(placeholders)