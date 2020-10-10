import sys
import os

def e(command): 
    return os.popen(command).read()[:-1]

if len(sys.argv) < 2:
    print('Need a key path and value')
else:
    modifiers_root = "~/.config/audot/modifiers"
    modifier_paths = os.listdir(os.path.expanduser(modifiers_root))

    for modifier in modifier_paths:
        e('audot edit modifier {} {} "{}"'.format(modifiers_root + '/' + modifier, sys.argv[1], sys.argv[2]))


