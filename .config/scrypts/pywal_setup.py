import os
import sys
import json
import yaml

def e(command):
    return os.popen(command).read()[:-1]

if len(sys.argv) < 3:
    print("need a wallpaper and theme type")
elif os.path.exists(os.path.expanduser('~/.cache/wal/colors')):
    print("Starting...")
    wallpaper = sys.argv[1]

    theme_type = sys.argv[2]

    if theme_type == 'light':
        theme_type = 'l'
    else:
        theme_type = ''

    os.system("wal -nste{}i {}".format(theme_type, wallpaper))

    colors = open(os.path.expanduser('~/.cache/wal/colors'), 'r').read().split('\n')

    for i, color in enumerate(colors):
        colors[i] = color.replace('#', '0x')

    alacritty_colors = {
        "colors": {
            "primary": {
                "background": colors[0],
                "foreground": colors[7]
            },
            "cursor": {
                "text": colors[0],
                "cursor": colors[7],
            },
            "normal": {
                "black": colors[0],
                "red": colors[1],
                "green": colors[2],
                "yellow": colors[3],
                "blue": colors[4],
                "magenta": colors[5],
                "cyan": colors[6],
                "white": colors[7]
            },
            "bright": {
                "black": colors[8],
                "red": colors[9],
                "green": colors[10],
                "yellow": colors[11],
                "blue": colors[12],
                "magenta": colors[13],
                "cyan": colors[14],
                "white": colors[15]
            }
        }
    }

    alacritty_colors = yaml.dump(alacritty_colors)
    print(alacritty_colors)

    open(os.path.expanduser("~/.config/scrypts/themes/alacritty/pywal.yml"), "w").write(alacritty_colors)

    for i, color in enumerate(colors):
        colors[i] = color.replace('0x', '#')

    pywal_modifier = "~/.config/audot/modifiers/pywal.json"

    # Remove enabled text from the current modifier
    current_modifier = e('audot query config modifier')
    current_modifier_new_name = e('audot query modifier {} name'.format(current_modifier)).replace(' (Enabled)', '')
    e('audot edit modifier {} name "{}"'.format(current_modifier, current_modifier_new_name))
    
    # Change modifier
    os.system('audot edit config modifier "{}"'.format(pywal_modifier))

    e('audot edit modifier {} name "{}"'.format(pywal_modifier, 'Pywal (Enabled)'))

    # Change bspwm colors
    os.system('audot edit modifier {} programs/bspwm/settings/normal_border_color/value "{}"'.format(pywal_modifier, colors[0]))
    os.system('audot edit modifier {} programs/bspwm/settings/active_border_color/value "{}"'.format(pywal_modifier, colors[8]))
    os.system('audot edit modifier {} programs/bspwm/settings/focused_border_color/value "{}"'.format(pywal_modifier, colors[6]))
    os.system('audot edit modifier {} programs/bspwm/settings/urgent_border_color/value "{}"'.format(pywal_modifier, colors[5]))
    os.system('audot edit modifier {} programs/bspwm/settings/wallpaper/value "{}"'.format(pywal_modifier, wallpaper))

    # Change dunst colors
    os.system('audot edit modifier {} programs/dunst/settings/normal_background_color/value "{}"'.format(pywal_modifier, colors[0]))
    os.system('audot edit modifier {} programs/dunst/settings/normal_frame_color/value "{}"'.format(pywal_modifier, colors[6]))
    os.system('audot edit modifier {} programs/dunst/settings/normal_foreground_color/value "{}"'.format(pywal_modifier, colors[8]))

    os.system('audot edit modifier {} programs/dunst/settings/low_background_color/value "{}"'.format(pywal_modifier, colors[0]))
    os.system('audot edit modifier {} programs/dunst/settings/low_foreground_color/value "{}"'.format(pywal_modifier, colors[8]))

    os.system('audot edit modifier {} programs/dunst/settings/critical_background_color/value "{}"'.format(pywal_modifier, colors[6]))
    os.system('audot edit modifier {} programs/dunst/settings/critical_frame_color/value "{}"'.format(pywal_modifier, colors[6]))
    os.system('audot edit modifier {} programs/dunst/settings/critical_foreground_color/value "{}"'.format(pywal_modifier, colors[0]))

    # Change polybar colors
    os.system('audot edit modifier {} programs/polybar/settings/alpha_background/value "{}"'.format(pywal_modifier, colors[0]))
    os.system('audot edit modifier {} programs/polybar/settings/alpha_foreground/value "{}"'.format(pywal_modifier, colors[8]))
    os.system('audot edit modifier {} programs/polybar/settings/alpha_label/value "{}"'.format(pywal_modifier, colors[3]))
    os.system('audot edit modifier {} programs/polybar/settings/alpha_text/value "{}"'.format(pywal_modifier, colors[2]))
    os.system('audot edit modifier {} programs/polybar/settings/alpha_urgent/value "{}"'.format(pywal_modifier, colors[5]))

    # Change rofi colors
    os.system('audot edit modifier {} programs/rofi/settings/background/value "{}"'.format(pywal_modifier, colors[0]))
    os.system('audot edit modifier {} programs/rofi/settings/background_alt/value "{}"'.format(pywal_modifier, colors[0] + '60'))
    os.system('audot edit modifier {} programs/rofi/settings/foreground/value "{}"'.format(pywal_modifier, colors[8]))
    os.system('audot edit modifier {} programs/rofi/settings/selected_background/value "{}"'.format(pywal_modifier, colors[7]))
    os.system('audot edit modifier {} programs/rofi/settings/selected_border/value "{}"'.format(pywal_modifier, colors[6]))

    # Run audot
    os.system('audot start')

    print("Done!")

    # Restart bspwm
    os.system('bspc wm -r')
