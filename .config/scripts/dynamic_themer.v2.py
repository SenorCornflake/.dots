import os
import sys
import re

import time
start_time = time.time()

def e(command):
    return os.popen(command).read()[:-1]

def ex(path):
    return os.path.expanduser(path)

def replace_line(content, regex, replace):
    content = content.split("\n")
    found = False
    for i, line in enumerate(content):
        result = re.search(regex, line)
        
        if result != None:
            content[i] = replace
            found = True
    
    if found:
        return "\n".join(content)
    else:
        return False

applications = [
    'bspwm',
    'rofi',
    'polybar',
    'termite',
    'alacritty',
    'vscode',
    'dunst',
    'neovim'
]


theme = {
    'bspwm': {
        'bspc config normal_border_color "#[a-zA-Z0-9]+"': 'bspc config normal_border_color "lemonpotato"',
        'bspc config active_border_color "#[a-zA-Z0-9]+"': 'bspc config active_border_color "foody"',
        'bspc config focused_border_color "#[a-zA-Z0-9]+"': 'bspc config focused_border_color "foody"'
    },
    'dunst': {
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER LOW': 'background = "lemonpotato" # DYNAMIC THEMER LOW',
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER LOW': 'background = "lemonpotato" # DYNAMIC THEMER LOW',
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER NORMAL': 'background = "lemonpotato" # DYNAMIC THEMER NORMAL',
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER NORMAL': 'background = "lemonpotato" # DYNAMIC THEMER NORMAL',
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER CRITICAL': 'background = "lemonpotato" # DYNAMIC THEMER CRITICAL',
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER CRITICAL': 'background = "lemonpotato" # DYNAMIC THEMER CRITICAL',
        'frame_width = [0-9]+ # DYNAMIC THEMER GENERAL':  'frame_width = 234 # DYNAMIC THEMER GENERAL',
        'frame_color = "#[0-9a-zA-Z]+" # DYNAMIC THEMER GENERAL': 'frame_color = "#lemon" # DYNAMIC THEMER GENERAL'
    },
    'rofi': {
        'background: #[0-9a-zA-Z]+;': 'background: #foodie;',
        'foreground: #[0-9a-zA-Z]+;': 'foreground: #foodie;',
        'border-input: #[0-9a-zA-Z]+;': 'border-input: #foodie;',
        'border-window: #[0-9a-zA-Z]+;': 'border-window: #foodie;',
        'selected: #[0-9a-zA-Z]+;': 'selected: #foodie;',
        'selected-foreground: #[0-9a-zA-Z]+;': 'selected-foreground: #foodie;',
        'urgent: #[0-9a-zA-Z]+;': 'urgent: #foodie;',
        'active-window: #[0-9a-zA-Z]+;': 'active-window: #foodie;'
    },
    'neovim': {
        'colorscheme \\w+': 'colorscheme lemon'
    },
    'termite': {
        'theme': 'base16-atelier-heath-light',
        'font = [a-zA-Z0-9-_\\s]+ [0-9]+': 'font = Fira Code 12'
    }
}

for name in theme:
    if name == 'bspwm':
        content = open(ex('~/.config/bspwm/bspwmrc'), 'r').read()
        for key in theme[name]:
            value = theme[name][key]

            content = re.sub(key, value, content)
        
        open(ex('~/.config/bspwm/bspwmrc'), 'w').write(content)
    
    elif name == 'dunst':
        content = open(ex('~/.config/dunst/dunstrc'), 'r').read()
        for key in theme[name]:
            value = theme[name][key]

            content = re.sub(key, value, content)

        open(ex('~/.config/dunst/dunstrc'), 'w').write(content)

    elif name == 'neovim':
        content = open(ex('~/.config/nvim/init.vim'), 'r').read()
        for key in theme[name]:
            value = theme[name][key]

            content = re.sub(key, value, content)
    
    elif name == 'rofi':
        content = open(ex('~/.config/rofi/config.rasi'), 'r').read()
        for key in theme[name]:
            value = theme[name][key]

            content = re.sub(key, value, content)

        open(ex('~/.config/rofi/config.rasi'), 'w').write(content)

    elif name == 'termite':

        for key in theme[name]:
            value = theme[name][key]
        
            if key == 'theme':
                theme_file = ex('~/.config/termite/colors/{}.config'.format(value))
                theme_file = open(theme_file, 'r').read()
                
                config_file = ex('~/.config/termite/config')
                config_file = open(config_file, 'r').read()
                config_file = config_file.split("\n")

                for i, line in enumerate(config_file):
                    if line.find('# DYNAMIC THEMER FROM HERE') != -1:
                        config_file = config_file[:i+1]
                        config_file = "\n".join(config_file)
                        config_file += "\n" + theme_file
                
                open(ex('~/.config/termite/config'), 'w').write(config_file)
            else:
                content = open(ex('~/.config/termite/config'), 'r').read()
                content = re.sub(key, value, content)

                open(ex('~/.config/termite/config'), 'w').write(content)



print("--- %s seconds ---" % (time.time() - start_time))
