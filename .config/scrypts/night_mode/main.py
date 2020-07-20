import os
import json
import sys

def e(command):
    return os.popen(command).read()[:-1]

enabled_path = os.path.expanduser('~/.config/scrypts/night_mode/enabled.json')

enabled = json.loads(open(enabled_path, 'r').read())['enabled']

if enabled:
    if not 'no_toggle' in sys.argv:
        e('redshift -x')
        open(enabled_path, 'w').write(json.dumps({'enabled': False}))
    else:
        e('redshift -P -O 4500')
else:
    if not 'no_toggle' in sys.argv:
        e('redshift -P -O 4500')
        open(enabled_path, 'w').write(json.dumps({'enabled': True}))
    else:
        e('redshift -x')

