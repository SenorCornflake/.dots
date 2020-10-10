
#  This file gets base16 colors from the alacritty colors in my dotfiles and uses them to create audot modifiers for each theme
import yaml
import json
import os

colors_dir = "~/.config/scrypts/themes/alacritty"
modifiers_dir = '~/.config/audot/modifiers'

colors = os.listdir(os.path.expanduser(colors_dir))
sorted_colors = []

for color in colors:
    if color.find('-256.yml') == -1 and color.find('base16') != -1:
        file_name = color
        color = colors_dir + '/' + color
        color = open(os.path.expanduser(color), 'r').read()
        color = yaml.load(color, yaml.Loader)

        color = {
            "name": file_name.replace('.yml', ''),
            "colors": [
                color['colors']['normal']['black'].replace('0x', '#'),
                color['colors']['normal']['red'].replace('0x', '#'),
                color['colors']['normal']['green'].replace('0x', '#'),
                color['colors']['normal']['yellow'].replace('0x', '#'),
                color['colors']['normal']['blue'].replace('0x', '#'),
                color['colors']['normal']['magenta'].replace('0x', '#'),
                color['colors']['normal']['cyan'].replace('0x', '#'),
                color['colors']['normal']['white'].replace('0x', '#'),

                color['colors']['bright']['black'].replace('0x', '#'),
                color['colors']['bright']['red'].replace('0x', '#'),
                color['colors']['bright']['green'].replace('0x', '#'),
                color['colors']['bright']['yellow'].replace('0x', '#'),
                color['colors']['bright']['blue'].replace('0x', '#'),
                color['colors']['bright']['magenta'].replace('0x', '#'),
                color['colors']['bright']['cyan'].replace('0x', '#'),
                color['colors']['bright']['white'].replace('0x', '#'),
            ]
        }

        sorted_colors.append(color)
    else:
        print('ignoring:', color)

colors = sorted_colors

modifier_template = open(os.path.expanduser('~/.config/audot/modifiers/base16-classic-light.json'), 'r').read()
modifier_template = json.loads(modifier_template)

for color in colors:
    modifier = modifier_template

    for a, program in enumerate(modifier['programs']):
        if program['name'] == 'bspwm':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'normal_border_color':
                    setting['value'] = color['colors'][10]
                elif setting['name'] == 'urgent_border_color':
                    setting['value'] = color['colors'][1]
                elif setting['name'] == 'focused_border_color':
                    setting['value'] = color['colors'][9]
                elif setting['name'] == 'presel_feedback_color':
                    setting['value'] = color['colors'][9]
                elif setting['name'] == 'active_border_color':
                    setting['value'] = color['colors'][12]
                program['settings'][b] = setting
        elif program['name'] == 'polybar':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'alpha_background':
                    setting['value'] = color['colors'][0]
                elif setting['name'] == 'alpha_foreground':
                    setting['value'] = color['colors'][13]
                elif setting['name'] == 'alpha_label':
                    setting['value'] = color['colors'][2]
                elif setting['name'] == 'alpha_text':
                    setting['value'] = color['colors'][12]
                elif setting['name'] == 'alpha_urgent':
                    setting['value'] = color['colors'][1]
                program['settings'][b] = setting
        elif program['name'] == 'alacritty':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'theme':
                    setting['value'] = '~/.config/scrypts/themes/alacritty/' + color['name'] + '.yml'
                program['settings'][b] = setting
        elif program['name'] == 'neovim':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'colorscheme':
                    setting['value'] = color['name']
                program['settings'][b] = setting
        elif program['name'] == 'dunst':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'normal_frame_color':
                    setting['value'] = color['colors'][9]
                elif setting['name'] == 'critical_frame_color':
                    setting['value'] = color['colors'][1]
                elif setting['name'] == 'critical_background_color':
                    setting['value'] = color['colors'][1]
                elif setting['name'] == 'normal_background_color':
                    setting['value'] = color['colors'][0]
                elif setting['name'] == 'low_background_color':
                    setting['value'] = color['colors'][0]
                elif setting['name'] == 'critical_foreground_color':
                    setting['value'] = color['colors'][0]
                elif setting['name'] == 'low_foreground_color':
                    setting['value'] = color['colors'][12]
                elif setting['name'] == 'normal_foreground_color':
                    setting['value'] = color['colors'][12]
                program['settings'][b] = setting
        elif program['name'] == 'rofi':
            for b, setting in enumerate(program['settings']):
                if setting['name'] == 'background':
                    setting['value'] = color['colors'][0]
                elif setting['name'] == 'background_alt':
                    setting['value'] = color['colors'][0] + '70'
                elif setting['name'] == 'foreground':
                    setting['value'] = color['colors'][12]
                elif setting['name'] == 'selected_background':
                    setting['value'] = color['colors'][9]
                elif setting['name'] == 'selected_border':
                    setting['value'] = color['colors'][3]
                program['settings'][b] = setting
        modifier['programs'][a] = program

    modifier['name'] = color['name'].split('-')
    for i, word in enumerate(modifier['name']):
        modifier['name'][i] = word.capitalize()
    modifier['name'] = " ".join(modifier['name'])
    modifier = json.dumps(modifier, indent=4)
    open(os.path.expanduser(modifiers_dir + '/' + color['name'] + '.json'), 'w').write(modifier)
