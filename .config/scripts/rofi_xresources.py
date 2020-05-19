import os

def e(command):
    return os.popen(command).read()

placeholders = {
    '</background/>': e("xrdb -query | grep rofi -i | grep background -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</foreground/>': e("xrdb -query | grep rofi -i | grep foreground -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</border_input/>': e("xrdb -query | grep rofi -i | grep border_input -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</border_window/>': e("xrdb -query | grep rofi -i | grep border_window -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</urgent/>': e("xrdb -query | grep rofi -i | grep urgent -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</active_window/>': e("xrdb -query | grep rofi -i | grep active_window -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
    '</selected/>': e("xrdb -query | grep rofi -i | grep selected -i -w | grep -E -o '#[0-9a-zA-Z]+'").replace("\n", ""),
}

custom_template = os.path.expanduser('~/dotfiles/.config/rofi/custom_template.rasi')

tempfile = open(custom_template, 'r').read()

for p in placeholders:
    tempfile = tempfile.replace(p, placeholders[p])

open(os.path.expanduser('~/dotfiles/.config/rofi/custom.rasi'), 'w+').write(tempfile)
print(placeholders)