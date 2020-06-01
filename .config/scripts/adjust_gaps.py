import os
import sys

def e(command):
    return os.popen(command).read()

if sys.argv[1] == 'inc':
    sizenow = int(e('bspc config window_gap')[:-1])
    add = int(sys.argv[2])
    total = sizenow + add

    print(e('bspc config window_gap ' + str(total)))
elif sys.argv[1] == 'dec':
    sizenow = int(e('bspc config window_gap')[:-1])
    remove = int(sys.argv[2])
    total = sizenow - remove

    print(e('bspc config window_gap ' + str(total)))

