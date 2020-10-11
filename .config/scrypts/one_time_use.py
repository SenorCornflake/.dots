#  This is the file I use to run scripts that don't provide long time use

import os

def e(command):
    return os.popen(command).read()[:-1]

modifiers = os.listdir(os.path.expanduser('~/.config/audot/modifiers'))

for modifier in modifiers:
    old_val = e('audot query modifier {} programs/rofi/settings/background_alt/value'.format('~/.config/audot/modifiers/' + modifier))
    old_val = list(old_val)
    old_val[len(old_val) - 2] = '9'
    old_val = "".join(old_val)
    e('audot edit modifier {} programs/rofi/settings/background_alt/value "{}"'.format('~/.config/audot/modifiers/' + modifier, old_val))
