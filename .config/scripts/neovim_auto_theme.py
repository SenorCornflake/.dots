
import os

def e(command):
    return os.popen(command).read()

placeholders = {
    '</color/>': e("xrdb -query | grep neovim -i | grep color -i -w | grep -oE '\\|[a-z0-9-]+\\|' | sed 's/|//g'").replace("\n", "")
}

custom_template = os.path.expanduser('~/dotfiles/.config/nvim/init-template.vim')

tempfile = open(custom_template, 'r').read()

for p in placeholders:
    tempfile = tempfile.replace(p, placeholders[p])

open(os.path.expanduser('~/dotfiles/.config/nvim/init.vim'), 'w+').write(tempfile)
print(placeholders)