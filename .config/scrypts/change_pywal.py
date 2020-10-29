import sys
import os
import random

def e(command):
    return os.popen(command).read()[:-1]


if len(sys.argv) < 2:
    print("need a theme type (light/dark)")
    sys.exit()

pictures_root = "~/Pictures/wallpapers"
picture_paths = os.listdir(os.path.expanduser(pictures_root))

picture = ''

if not "random" in sys.argv:
    picture = e('echo "{}" | rofi -dmenu -i -p "Picture: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(picture_paths)))

if picture != '' and not "random" in sys.argv:
    e('python ~/.config/scrypts/pywal_setup.py {} {}'.format(pictures_root + '/' + picture, sys.argv[1]))
elif "random" in sys.argv:
    e('python ~/.config/scrypts/pywal_setup.py {} {}'.format(pictures_root + '/' + random.choice(picture_paths), sys.argv[1]))
