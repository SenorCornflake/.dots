import os
import sys
import re
import json
def e(command):
    return os.popen(command).read()[:-1]

def ex(path):
    return os.path.expanduser(path)

if len(sys.argv) > 2:
    theme = sys.argv[1]

    if not os.path.exists(ex('~/.config/scripts/storage/themes/{}.json'.format(theme))):
        e('notify-send "Dynamic Themer: Theme" "Theme {} doesn\'t exist"'.format('~/.config/scripts/storage/themes/{}.json'.format(theme)))
        sys.exit()
    else:
        theme = '~/.config/scripts/storage/themes/{}.json'.format(theme)
        file = json.loads(open(ex('~/.config/scripts/storage/theme.json'), 'r').read())
        file['theme'] = theme
        open(ex('~/.config/scripts/storage/theme.json'), 'w').write(json.dumps(file, indent=4))

active_theme = json.loads(open(ex('~/.config/scripts/storage/theme.json'), 'r').read())['theme']
theme_file = json.loads(open(ex(active_theme), 'r').read())
print(theme_file)
theme_file = theme_file['config']

regexes = {
    'bspwm': {
        'bspc config normal_border_color "#[a-zA-Z0-9]+"': 'bspc config normal_border_color "{}"'.format(theme_file['bspwm']['normal_border_color']),
        'bspc config active_border_color "#[a-zA-Z0-9]+"': 'bspc config active_border_color "{}"'.format(theme_file['bspwm']['active_border_color']),
        'bspc config focused_border_color "#[a-zA-Z0-9]+"': 'bspc config focused_border_color "{}"'.format(theme_file['bspwm']['focused_border_color']),
        'bspc config borderless_monocle [a-zA-Z]+': 'bspc config borderless_monocle {}'.format(theme_file['bspwm']['borderless_monocle']),
        'bspc config gapless_monocle [a-zA-Z]+': 'bspc config gapless_monocle {}'.format(theme_file['bspwm']['gapless_monocle']),
        'feh --no-fehbg --bg-fill .+': 'feh --no-fehbg --bg-fill {}'.format(theme_file['bspwm']['wallpaper']),
        'bspc config window_gap [0-9]+': 'bspc config window_gap {}'.format(theme_file['bspwm']['window_gap']),
    },
    'dunst': {
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER LOW': 'background = "{}" # DYNAMIC THEMER LOW'.format(theme_file['dunst']['background']),
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER LOW': 'background = "{}" # DYNAMIC THEMER LOW'.format(theme_file['dunst']['foreground']),
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER NORMAL': 'background = "{}" # DYNAMIC THEMER NORMAL'.format(theme_file['dunst']['background']),
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER NORMAL': 'background = "{}" # DYNAMIC THEMER NORMAL'.format(theme_file['dunst']['foreground']),
        'background = "#[0-9a-zA-Z]+" # DYNAMIC THEMER CRITICAL': 'background = "{}" # DYNAMIC THEMER CRITICAL'.format(theme_file['dunst']['background']),
        'foreground = "#[0-9a-zA-Z]+" # DYNAMIC THEMER CRITICAL': 'background = "{}" # DYNAMIC THEMER CRITICAL'.format(theme_file['dunst']['foreground']),
        'frame_width = [0-9]+ # DYNAMIC THEMER GENERAL':  'frame_width = {} # DYNAMIC THEMER GENERAL'.format(theme_file['dunst']['frame_width']),
        'frame_color = "#[0-9a-zA-Z]+" # DYNAMIC THEMER GENERAL': 'frame_color = "{}" # DYNAMIC THEMER GENERAL'.format(theme_file['dunst']['frame_color']),
        'critical_frame_color = "#[0-9a-zA-Z]+" # DYNAMIC THEMER CRITICAL': 'frame_color = "{}" # DYNAMIC THEMER GENERAL'.format(theme_file['dunst']['frame_color']),
        'font = .+ # DYNAMIC THEMER GENERAL': 'font = {} # DYNAMIC THEMER GENERAL'.format(theme_file['dunst']['font'])
    },
    'rofi': {
        'background: #[0-9a-zA-Z]+;': 'background: {};'.format(theme_file['rofi']['background']),
        'foreground: #[0-9a-zA-Z]+;': 'foreground: {};'.format(theme_file['rofi']['foreground']),
        'border-input: #[0-9a-zA-Z]+;': 'border-input: {};'.format(theme_file['rofi']['border_input']),
        'border-window: #[0-9a-zA-Z]+;': 'border-window: {};'.format(theme_file['rofi']['border_window']),
        'selected: #[0-9a-zA-Z]+;': 'selected: {};'.format(theme_file['rofi']['selected']),
        'selected-foreground: #[0-9a-zA-Z]+;': 'selected-foreground: {};'.format(theme_file['rofi']['selected_foreground']),
        'urgent: #[0-9a-zA-Z]+;': 'urgent: {};'.format(theme_file['rofi']['urgent']),
        'active-window: #[0-9a-zA-Z]+;': 'active-window: {};'.format(theme_file['rofi']['active_window']),
        'show-icons: \\w+;': 'show-icons: {};'.format(theme_file['rofi']['show_icons']),
        'icon-theme: \\w+;': 'icon-theme: {};'.format(theme_file['rofi']['icon_theme']),
        'font: ".+";': 'font: {};'.format(theme_file['rofi']['font']),
    },
    'neovim': {
        'colorscheme .+': 'colorscheme {}'.format(theme_file['neovim']['theme'])
    },
    'termite': {
        'theme': theme_file['termite']['theme'],
        'font = .+ [0-9]+': 'font = {}'.format(theme_file['termite']['font'])
    },
    'alacritty': {
        'family: .+': 'family: {}'.format(theme_file['alacritty']['font_family']),
        'size: [0-9.]+': 'size: {}'.format(theme_file['alacritty']['font_size']),
        'theme': theme_file['alacritty']['theme']
    },
    'polybar': {
        '; DYNAMIC THEMER TYPE': theme_file['polybar']['type'],
        '; DYNAMIC THEMER THEME': theme_file['polybar']['theme'],
    },
    'vscode': {
        'theme': theme_file['vscode']['theme']
    }
}

for name in regexes:
    if name == 'bspwm':
        content = open(ex('~/.config/bspwm/bspwmrc'), 'r').read()
        for key in regexes[name]:
            value = regexes[name][key]

            content = re.sub(key, value, content)
        
        open(ex('~/.config/bspwm/bspwmrc'), 'w').write(content)
    
    elif name == 'dunst':
        content = open(ex('~/.config/dunst/dunstrc'), 'r').read()
        for key in regexes[name]:
            value = regexes[name][key]

            content = re.sub(key, value, content)

        open(ex('~/.config/dunst/dunstrc'), 'w').write(content)

    elif name == 'neovim':
        content = open(ex('~/.config/nvim/init.vim'), 'r').read()
        for key in regexes[name]:
            value = regexes[name][key]

            content = re.sub(key, value, content)
        open(ex('~/.config/nvim/init.vim'), 'w').write(content)

    elif name == 'rofi':
        content = open(ex('~/.config/rofi/config.rasi'), 'r').read()
        for key in regexes[name]:
            value = regexes[name][key]

            content = re.sub(key, value, content)

        open(ex('~/.config/rofi/config.rasi'), 'w').write(content)

    elif name == 'termite':

        for key in regexes[name]:
            value = regexes[name][key]
        
            if key == 'theme':
                theme_file = ex('~/.config/termite/colors/{}.config'.format(value))

                if not os.path.exists(theme_file):
                    e('notify-send "Dynamic Themer: Termite" "Theme file {} doesn\'t exist"'.format(theme_file))
                else:
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
    
    elif name == 'alacritty':
        for key in regexes[name]:
            value = regexes[name][key]

            if key == 'theme':
                theme_file = ex('~/.config/alacritty/colors/{}.yml'.format(value))

                if not os.path.exists(theme_file):
                    e('notify-send "Dynamic Themer: Alacritty" "Theme file {} doesn\'t exist"'.format(theme_file))
                    print('lemion')
                else:
                    theme_file = open(theme_file, 'r').read()
                    
                    config_file = ex('~/.config/alacritty/alacritty.yml')
                    config_file = open(config_file, 'r').read()
                    config_file = config_file.split("\n")

                    for i, line in enumerate(config_file):
                        if line.find('# DYNAMIC THEMER FROM HERE') != -1:
                            config_file = config_file[:i+1]
                            config_file = "\n".join(config_file)
                            config_file += "\n" + theme_file

                    open(ex('~/.config/alacritty/alacritty.yml'), 'w').write(config_file)
            else:
                content = open(ex('~/.config/alacritty/alacritty.yml'), 'r').read()
                content = re.sub(key, value, content)
                open(ex('~/.config/alacritty/alacritty.yml'), 'w').write(content)

    elif name == 'polybar':
        type = ''
        for key in regexes[name]:
            value = regexes[name][key]
            config_file = ex('~/.config/polybar/config.ini')
            config_file = open(config_file, 'r').read().split("\n")

            if key == '; DYNAMIC THEMER TYPE':
                type = value
                include = '~/.config/polybar/types/{}/config.ini'.format(value)
                
                if not os.path.exists(ex(include)):
                    e('notify-send "Dynamic Themer: Polybar" "Type file {} doesn\'t exist"'.format(include))
                else:
                    include = ex(include)
                    include = 'include-file = {}'.format(include)

                    for i, line in enumerate(config_file):
                        if re.search(key, line) != None:
                            config_file[i + 1] = include

            elif key == '; DYNAMIC THEMER THEME':
                include = '~/.config/polybar/types/{}/themes/{}.ini'.format(type, value)
                
                if not os.path.exists(ex(include)):
                    e('notify-send "Dynamic Themer: Polybar" "Type file {} doesn\'t exist"'.format(include))
                else:
                    include = ex(include)
                    include = 'include-file = {}'.format(include)

                    for i, line in enumerate(config_file):
                        if re.search(key, line) != None:
                            config_file[i + 1] = include
                    
            config_file = "\n".join(config_file)
            open(ex('~/.config/polybar/config.ini'), 'w').write(config_file)
    
    elif name == 'vscode':
        config_file = open(ex('~/.config/Code/User/settings.json'), 'r').read()
        config_file = json.loads(config_file)

        for key in regexes[name]:
            value = regexes[name][key]

            config_file['workbench.colorTheme'] = value
        
        open(ex('~/.config/Code/User/settings.json'), 'w').write(json.dumps(config_file, indent=4))
            
                
if 'restart' in sys.argv:
    e('bspc wm -r')