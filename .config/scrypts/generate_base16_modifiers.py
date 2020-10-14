import yaml
import json
import os

def e(command):
    return os.popen(command).read()[:-1]

base16_themes_dir = "~/Repositories/base16-themes/themes"
modifiers_dir = "~/.config/audot/modifiers"

base16_themes_dir = os.path.expanduser(base16_themes_dir)
modifiers_dir = os.path.expanduser(modifiers_dir)


base16_themes = os.listdir(base16_themes_dir)

for theme in base16_themes:
    file_name = theme.replace('.yml', '')

    if not os.path.exists(modifiers_dir + '/' + file_name + '.json'):
        template = os.listdir(modifiers_dir)[0]
        template = open(modifiers_dir + '/' + template, 'r').read()
        open(modifiers_dir + '/' + file_name + '.json', 'w').write(template)

    theme = open(base16_themes_dir + '/' + theme, 'r').read()
    theme = yaml.load(theme, Loader=yaml.BaseLoader)

    modifier_name                   = 'Base16 ' + theme['scheme']
    # BSPWM
    bspwm_normal_border_color       =  '#' + theme['base01']
    bspwm_urgent_border_color       =  '#' + theme['base08']
    bspwm_focused_border_color      =  '#' + theme['base09']
    bspwm_presel_feedback_color     =  '#' + theme['base09']
    bspwm_active_border_color       =  '#' + theme['base04']
    # POLYBAR
    polybar_alpha_background        =  '#' + theme['base00']
    polybar_alpha_foreground        =  '#' + theme['base06']
    polybar_alpha_label             =  '#' + theme['base0B']
    polybar_alpha_text              =  '#' + theme['base04']
    polybar_alpha_urgent            =  '#' + theme['base08']
    polybar_alpha_surround          =  '#' + theme['base09']
    # ALACRITTY
    alacritty_theme                 =  '~/.config/scrypts/themes/alacritty/' + file_name + '.yml'
    # NEOVIM
    neovim_colorscheme              =  file_name
    neovim_termguicolors            =  'set termguicolors'
    # DUNST
    dunst_normal_frame_color        =  '#' + theme['base09']
    dunst_normal_background_color   =  '#' + theme['base00']
    dunst_normal_foreground_color   =  '#' + theme['base04']
    dunst_low_background_color      =  '#' + theme['base00']
    dunst_low_foreground_color      =  '#' + theme['base04']
    dunst_critical_frame_color      =  '#' + theme['base08']
    dunst_critical_background_color =  '#' + theme['base08']
    dunst_critical_foreground_color =  '#' + theme['base00']
    # ROFI
    rofi_background                 =  '#' + theme['base00']
    rofi_background_alt             =  '#' + theme['base00'] + '90'
    rofi_foreground                 =  '#' + theme['base04']
    rofi_selected_border            =  '#' + theme['base0A']
    rofi_selected_background        =  '#' + theme['base09']

    print(modifier_name)
    os.system('audot edit modifier "{}" name "{}"'.format(modifiers_dir + '/' + file_name + '.json', modifier_name))
    os.system('audot edit modifier "{}" programs/bspwm/settings/normal_border_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', bspwm_normal_border_color))
    os.system('audot edit modifier "{}" programs/bspwm/settings/urgent_border_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', bspwm_urgent_border_color))
    os.system('audot edit modifier "{}" programs/bspwm/settings/active_border_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', bspwm_active_border_color))
    os.system('audot edit modifier "{}" programs/bspwm/settings/focused_border_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', bspwm_focused_border_color))
    os.system('audot edit modifier "{}" programs/bspwm/settings/presel_feedback_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', bspwm_presel_feedback_color))
    os.system('audot edit modifier "{}" programs/polybar/settings/alpha_background/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', polybar_alpha_background))
    os.system('audot edit modifier "{}" programs/polybar/settings/alpha_label/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', polybar_alpha_label))
    os.system('audot edit modifier "{}" programs/polybar/settings/alpha_text/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', polybar_alpha_text))
    os.system('audot edit modifier "{}" programs/polybar/settings/alpha_urgent/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', polybar_alpha_urgent))
    os.system('audot edit modifier "{}" programs/polybar/settings/alpha_surround/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', polybar_alpha_surround))
    os.system('audot edit modifier "{}" programs/alacritty/settings/theme/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', alacritty_theme))
    os.system('audot edit modifier "{}" programs/neovim/settings/colorscheme/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', neovim_colorscheme))
    os.system('audot edit modifier "{}" programs/neovim/settings/termguicolors/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', neovim_termguicolors))
    os.system('audot edit modifier "{}" programs/dunst/settings/normal_frame_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_normal_frame_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/critical_frame_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_critical_frame_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/normal_background_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_normal_background_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/critical_background_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_critical_background_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/low_background_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_low_background_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/normal_foreground_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_normal_foreground_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/critical_foreground_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_critical_foreground_color))
    os.system('audot edit modifier "{}" programs/dunst/settings/low_foreground_color/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', dunst_low_foreground_color))
    os.system('audot edit modifier "{}" programs/rofi/settings/background/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', rofi_background))
    os.system('audot edit modifier "{}" programs/rofi/settings/background_alt/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', rofi_background_alt))
    os.system('audot edit modifier "{}" programs/rofi/settings/foreground/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', rofi_foreground))
    os.system('audot edit modifier "{}" programs/rofi/settings/selected_background/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', rofi_selected_background))
    os.system('audot edit modifier "{}" programs/rofi/settings/selected_border/value "{}"'.format(modifiers_dir + '/' + file_name + '.json', rofi_selected_border))
