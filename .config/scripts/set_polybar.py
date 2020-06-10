import sys
import os
import json

def e(command):
    return os.popen(command).read()[:-1]

current_theme = json.loads(open(os.path.expanduser('~/.config/scripts/storage/theme.json'), 'r').read())['theme']
tmp = json.loads(open(os.path.expanduser(current_theme), 'r').read())
polybar_types = "\n".join(os.listdir(os.path.expanduser('~/.config/polybar/types')))

type = e('echo "{}" | rofi -dmenu -i -p "Type: "'.format(polybar_types))

if type != '':
    tmp['config']['polybar']['<>|type|<>']['value'] = '~/.config/polybar/types/' + type + '/config_template.ini'

open(os.path.expanduser(current_theme), 'w').write(json.dumps(tmp, indent=4))
e('python ~/.config/scripts/dynamic_themer.py restart')
