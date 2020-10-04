import sys
import os

def e(command): 
    return os.popen(command).read()[:-1]

pictures_root = "~/Pictures/wallpapers"
picture_paths = os.listdir(os.path.expanduser(pictures_root))

picture = e('echo "{}" | rofi -dmenu -i -p "Picture: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(picture_paths)))

if picture != '':
    e('python ~/.config/scrypts/pywal_setup.py {}'.format(pictures_root + '/' + picture))
