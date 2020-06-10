"""
Each program's dotfiles will have a template with placeholders that need to be
replaced with values 
"""

import os
import sys
import json
import time

def e(command):
    return os.popen(command).read()[:-1]

def replace_keys(template, config, output_file):
    template = open(os.path.expanduser(template), 'r').read()
    
    for key in config:
        value = config[key]['value']

        if config[key]['is_file'] == "true":
            if os.path.exists(os.path.expanduser(value)):
                template = template.replace(key, open(os.path.expanduser(value), 'r').read())
            else:
                e('notify-send "Dynamic themer" "File \"{}\" doesn\'t exist!"'.format(os.path.expanduser(value)))
                time.sleep(2)
                return False
        else:
            template = template.replace(key, value)
        print(template)
    
    open(os.path.expanduser(output_file), 'w').write(template)

current_theme = json.loads(open(os.path.expanduser('~/.config/scripts/storage/theme.json'), 'r').read())

theme_set = True

# Config
if 'set' in sys.argv:
    theme_set = False
    theme_names = []
    theme_configs = []
    theme_files = os.listdir(os.path.expanduser('~/.config/scripts/storage/themes'))

    # Convert to absolute path and append theme file's json to themes array
    for i, file in enumerate(theme_files):
        theme_files[i] = '~/.config/scripts/storage/themes/' + file
        
        file = json.loads(open(os.path.expanduser(theme_files[i]), 'r').read())
        theme_names.append(file['name'])

    chosen_theme_index = e('echo "{}" | rofi -dmenu -i -format i -p "Theme:"'.format("\n".join(theme_names)))

    if chosen_theme_index != '':
        theme_set = True
        current_theme['theme'] = theme_files[int(chosen_theme_index)]


    

chosen_theme = current_theme['theme']

theme_config = json.loads(open(os.path.expanduser(chosen_theme), 'r').read())['config']

for name in theme_config:
    
    if name == 'bspwm':
        replace_keys('~/.config/bspwm/bspwmrc_template', theme_config[name], '~/.config/bspwm/bspwmrc' )

    elif name == 'rofi':
        replace_keys('~/.config/rofi/config_template.rasi', theme_config[name], '~/.config/rofi/config.rasi' )

    elif name == 'dunst':
        replace_keys('~/.config/dunst/dunstrc_template', theme_config[name], '~/.config/dunst/dunstrc' )

    elif name == 'neovim':
        replace_keys('~/.config/nvim/init_template.vim', theme_config[name], '~/.config/nvim/init.vim' )

    elif name == 'polybar':
        replace_keys('~/.config/polybar/config_template.ini', theme_config[name], '~/.config/polybar/config.ini' )

    elif name == 'termite':
        replace_keys('~/.config/termite/config_template', theme_config[name], '~/.config/termite/config' )

    elif name == 'vscode':
        settings = json.loads(open(os.path.expanduser('~/.config/Code/User/settings.json'), 'r').read())
        settings['workbench.colorTheme'] = '<>|theme|<>'
        settings = json.dumps(settings, indent=True)
        open(os.path.expanduser('~/.config/Code/User/settings.json'), 'w').write(settings)

        replace_keys('~/.config/Code/User/settings.json', theme_config[name], '~/.config/Code/User/settings.json' )

    elif name == 'alacritty':
        replace_keys('~/.config/alacritty/alacritty_template.yml', theme_config[name], '~/.config/alacritty/alacritty.yml' )

open(os.path.expanduser('~/.config/scripts/storage/theme.json'), 'w').write(json.dumps(current_theme))

if 'restart' in sys.argv and theme_set:
    e('bspc wm -r')