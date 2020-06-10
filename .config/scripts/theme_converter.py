import json
import os
import sys
import random

tmp = {
    "name": '',
    "config": {}
}

theme = json.loads(open(os.path.expanduser('~/.config/scripts/storage/themes/{}.json'.format(sys.argv[1])), 'r').read())

for a in theme:
    b = theme[a]

    if a == 'name':
        tmp[a] = b
    elif a == 'config':

        for c in b:
            d = b[c]
            tmp['config'][c] = {}

            for e in d:
                f = d[e]
                mod = e.replace('<>|', '')
                mod = mod.replace('|<>', '')
                tmp['config'][c][mod] = f['value'] 

print(tmp)
            
open(os.path.expanduser('~/.config/scripts/storage/themes/{}.json'.format(sys.argv[1] + '_conv')), 'w').write(json.dumps(tmp, indent=4))