import json
import os

def e(command):
    return os.popen(command).read()[:-1]

theme_files = os.listdir(os.path.expanduser('~/.config/scripts/storage/themes'))
theme_names = []

for theme in theme_files:
    theme = json.loads(open(os.path.expanduser('~/.config/scripts/storage/themes/' + theme), 'r').read())['name']
    theme_names.append(theme)

chosen_theme = e('echo "{}" | rofi -dmenu -i -format i -p "Choose theme: "'.format("\n".join(theme_names)))

if chosen_theme != '':
    chosen_theme = int(chosen_theme)
    e('python ~/.config/scripts/dynamic_themer.v2.py ' + theme_files[chosen_theme].replace('.json', '') + ' restart')