import sys
import os
import json

def e(command): 
    return os.popen(command).read()[:-1]


if sys.argv[1] == 'mode':
    modes_dir = os.path.expanduser(e('python ~/.config/scrypts/LemonPotato/main.py query setting --name modes_dir'))

    mode_filenames = os.listdir(modes_dir)
    mode_paths = []
    mode_names = []

    for i, mode in enumerate(mode_filenames):
        mode_names.append(mode.replace('.json', ''))
        mode_paths.append(modes_dir + '/' + mode)
        mode_filenames[i] = mode.replace('.json', '')
    
    for i, mode_name in enumerate(mode_names):
        mode_names[i] = e('python ~/.config/scrypts/LemonPotato/main.py query mode --name {} --key-path name'.format(mode_name))

    command = 'echo "{}" | rofi -dmenu -format i -i -p "Mode: " -theme-str \'prompt {{ enabled: false; }} element-icon {{ enabled: false; }} \''.format("\n".join(mode_names))
    index = e(command)
    
    if index != '':
        index = int(index)
        e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name current_mode --value {}'.format(mode_filenames[index]))
        e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
        e('python ~/.config/scrypts/LemonPotato/main.py go')
        e('bspc wm -r')

    
elif sys.argv[1] == 'override':
    overrides_dir = os.path.expanduser(e('python ~/.config/scrypts/LemonPotato/main.py query setting --name overrides_dir'))

    override_filenames = os.listdir(overrides_dir)
    override_paths = []
    override_names = []

    for i, override in enumerate(override_filenames):
        override_names.append(override.replace('.json', ''))
        override_paths.append(overrides_dir + '/' + override)
        override_filenames[i] = override.replace('.json', '')
    
    for i, override_name in enumerate(override_names):
        override_names[i] = e('python ~/.config/scrypts/LemonPotato/main.py query override --name {} --key-path name'.format(override_name))

    command = 'echo "{}" | rofi -dmenu -format i -i -p "Override: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(override_names))
    index = e(command)
    
    if index != '':
        index = int(index)
        e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name current_override --value {}'.format(override_filenames[index]))
        e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
        e('python ~/.config/scrypts/LemonPotato/main.py go')
        e('bspc wm -r')

elif sys.argv[1] == 'wallpaper':
    wallpapers_dir = os.path.expanduser('~/.config/scrypts/wallpapers')
    wallpapers = os.listdir(wallpapers_dir)

    connected_monitors_amount = len(e('xrandr | grep " connected "').split('\n'))

    chosen_wallpapers = []

    i = 0

    while i < connected_monitors_amount: 
        command = 'echo "{}" | rofi -dmenu -i -p "Wallpaper ({}): " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(wallpapers), i)
        result = e(command)

        if result != '':
            chosen_wallpapers.append(wallpapers_dir + '/' + result)
        
            e('feh --no-fehbg --bg-fill {}'.format(" ".join(chosen_wallpapers)))

        i += 1
    
    current_mode = e('python ~/.config/scrypts/LemonPotato/main.py query setting --name current_mode')
    current_override = e('python ~/.config/scrypts/LemonPotato/main.py query setting --name current_override')

    if sys.argv[2] == 'mode':
        print(e('python ~/.config/scrypts/LemonPotato/main.py modify mode --name {} --key-path applications/bspwm/wallpaper --value "{}"'.format(current_mode, " ".join(chosen_wallpapers))))
    elif sys.argv[2] == 'override':
        print(e('python ~/.config/scrypts/LemonPotato/main.py modify override --name {} --key-path applications/bspwm/wallpaper --value "{}"'.format(current_override, " ".join(chosen_wallpapers))))

    e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
    e('python ~/.config/scrypts/LemonPotato/main.py go')

elif sys.argv[1] == 'polybar':
    layouts_dir = os.path.expanduser('~/.config/polybar/layouts')
    layout_names = os.listdir(layouts_dir)
    
    for i, name in enumerate(layout_names):
        layout_names[i] = name.replace('.ini', '')

    chosen_layout = ''

    command = 'echo "{}" | rofi -dmenu -i -p "Layout: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(layout_names))

    result = e(command)

    if result != '':
        chosen_layout = result
        current_mode = e('python ~/.config/scrypts/LemonPotato/main.py query setting --name current_mode')
        current_override = e('python ~/.config/scrypts/LemonPotato/main.py query setting --name current_override')

        if sys.argv[2] == 'mode':
            print(e('python ~/.config/scrypts/LemonPotato/main.py modify mode --name {} --key-path applications/polybar/layout --value "{}"'.format(current_mode, chosen_layout)))
            e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
            e('python ~/.config/scrypts/LemonPotato/main.py go')
            e('bspc wm -r')
        elif sys.argv[2] == 'override':
            print(e('python ~/.config/scrypts/LemonPotato/main.py modify override --name {} --key-path applications/polybar/layout --value "{}"'.format(current_override, chosen_layout)))
            e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
            e('python ~/.config/scrypts/LemonPotato/main.py go')
            e('bspc wm -r')

elif sys.argv[1] == 'pywal':
    wallpapers_dir = os.path.expanduser('~/.config/scrypts/wallpapers')
    wallpapers = os.listdir(wallpapers_dir)


    command = 'echo "{}" | rofi -dmenu -i -p "Pywal picture: " -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(wallpapers))
    result = e(command)

    if result != '':

        wal_result = e('wal -s -e -n -i {}'.format(wallpapers_dir + '/' + result))

        if wal_result.find("Imagemagick couldn't generate a suitable palette.") == -1:
            wal = 'wal -s -n -i {}'.format(wallpapers_dir + '/' + result)

            e('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/bspwm/pywal --value "{}"'.format(wal))
            e('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/bspwm/wallpaper --value "{}"'.format(wallpapers_dir + '/' + result))
            e('python ~/.config/scrypts/pywal_setup.py')

            e('python ~/.config/scrypts/LemonPotato/main.py modify setting --name already_set --value false')
            e('python ~/.config/scrypts/LemonPotato/main.py go')
            e('bspc wm -r')
