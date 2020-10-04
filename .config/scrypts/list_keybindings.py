import sys
import os
import re

def e(command):
    return os.popen(command).read()[:-1]

if os.path.exists(os.path.expanduser('~/.config/sxhkd/sxhkdrc')):
    sxhkdrc = open(os.path.expanduser("~/.config/sxhkd/sxhkdrc"), 'r').read()
    sxhkdrc = sxhkdrc.split("\n")
    keys = []

    for i, line in enumerate(sxhkdrc):
        if re.match("# .+", line):
            keys.append("{} -> {}".format(line, sxhkdrc[i + 1]))

    e('echo "{}" | rofi -dmenu -i -p "" -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(keys)))

