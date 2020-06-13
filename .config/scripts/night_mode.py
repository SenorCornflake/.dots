import os
import json
import sys

def e(command):
    return os.popen(command).read()[:-1]

enabled = json.loads(open(os.path.expanduser('~/.config/scripts/storage/night_mode.json'), 'r').read())['enabled']

if enabled:
    if not 'no_toggle' in sys.argv:
        e('redshift -x')
        open(os.path.expanduser('~/.config/scripts/storage/night_mode.json'), 'w').write(json.dumps({'enabled': False}))
    else:
        e('redshift -P -O 4500')
else:
    if not 'no_toggle' in sys.argv:
        e('redshift -P -O 4500')
        open(os.path.expanduser('~/.config/scripts/storage/night_mode.json'), 'w').write(json.dumps({'enabled': True}))
    else:
        e('redshift -x')

