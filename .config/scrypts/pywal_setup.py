import os
import sys
import json

def e(command):
    return os.popen(command).read()[:-1]

if os.path.exists(os.path.expanduser('~/.cache/wal/colors')):
    colors = open(os.path.expanduser('~/.cache/wal/colors'), 'r').read().split('\n')
    
    for i, color in enumerate(colors):
        colors[i] = color.replace('#', '0x')
    
    # Change alacritty pywal colors
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/background --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/foreground --value "{}"'.format(colors[7]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/text --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/cursor --value "{}"'.format(colors[7]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/black_normal --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/red_normal --value "{}"'.format(colors[1]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/green_normal --value "{}"'.format(colors[2]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/yellow_normal --value "{}"'.format(colors[3]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/blue_normal --value "{}"'.format(colors[4]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/magenta_normal --value "{}"'.format(colors[5]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/cyan_normal --value "{}"'.format(colors[6]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/white_normal --value "{}"'.format(colors[7]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/black_bright --value "{}"'.format(colors[8]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/red_bright --value "{}"'.format(colors[9]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/green_bright --value "{}"'.format(colors[10]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/yellow_bright --value "{}"'.format(colors[11]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/blue_bright --value "{}"'.format(colors[12]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/magenta_bright --value "{}"'.format(colors[13]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/cyan_bright --value "{}"'.format(colors[14]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/alacritty_pywal/white_bright --value "{}"'.format(colors[15]))

    for i, color in enumerate(colors):
        colors[i] = color.replace('0x', '#')

    # Change bspwm colors
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/bspwm/normal_border_color --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/bspwm/active_border_color --value "{}"'.format(colors[8]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/bspwm/focused_border_color --value "{}"'.format(colors[6]))

    # Change dunst colors
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/normal_background --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/normal_frame_color --value "{}"'.format(colors[6]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/normal_foreground --value "{}"'.format(colors[8]))

    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/urgent_background --value "{}"'.format(colors[6]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/urgent_frame_color --value "{}"'.format(colors[6]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/dunst/urgent_foreground --value "{}"'.format(colors[0]))

    # change rofi colors
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/rofi_pywal/background --value "{}"'.format(colors[0]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/rofi_pywal/foreground --value "{}"'.format(colors[8]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/rofi_pywal/selected_background --value "{}"'.format(colors[6]))
    os.system('python ~/.config/scrypts/LemonPotato/main.py modify override --name pywal --key-path applications/rofi_pywal/selected_border --value "{}"'.format(colors[5]))
