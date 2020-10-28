import sys
import os

def e(command): 
    return os.popen(command).read()[:-1]

pictures_root = "~/Pictures/wallpapers"
picture_paths = os.listdir(os.path.expanduser(pictures_root))

modifier_path = e('audot query config modifier')

picture = e('echo "{}" | rofi -dmenu -i -p "Picture: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(picture_paths)))

if picture != '':
    print(picture)
    e('audot edit modifier {} programs/bspwm/settings/wallpaper/value "{}"'.format(modifier_path, pictures_root + '/' + picture))
    os.system('audot start')
    os.system('feh --no-fehbg --bg-fill {}'.format(pictures_root + '/' + picture))

    # dfdfsdfl
