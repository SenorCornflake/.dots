import os

def e(command):
    return os.popen(command).read()

placeholders = {
    '</frame/>': e('xrdb -query | grep dunst -i | grep frame -i -w | grep -E -o \'#[0-9a-zA-Z]+\'').replace("\n", ""),
    '</urgent_frame/>': e('xrdb -query | grep dunst -i | grep urgent_frame -i -w | grep -E -o \'#[0-9a-zA-Z]+\'').replace("\n", ""),
    '</background/>': e('xrdb -query | grep dunst -i | grep background -i -w | grep -E -o \'#[0-9a-zA-Z]+\'').replace("\n", ""),
    '</foreground/>': e('xrdb -query | grep dunst -i | grep foreground -i -w | grep -E -o \'#[0-9a-zA-Z]+\'').replace("\n", ""),
}

dunstrc = os.path.expanduser('~/dotfiles/.config/dunst/dunstrc_template')

tempfile = open(dunstrc, 'r').read()

for p in placeholders:
    tempfile = tempfile.replace(p, placeholders[p])

open(os.path.expanduser('~/dotfiles/.config/dunst/dunstrc'), 'w+').write(tempfile)