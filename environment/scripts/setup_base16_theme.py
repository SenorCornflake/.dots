import os
import sys

import yaml

if len(sys.argv) < 2:
    print("Provide a base16 theme")
    sys.exit()

theme_path = os.path.expanduser(sys.argv[1])
theme_name = os.path.splitext(os.path.basename(theme_path))[0]

os.system("notify-send \"Please wait, this'll take a while.\"")

if not os.path.exists(theme_path):
    print("Path does not exist")
    sys.exit()

theme = open(theme_path, 'r').read()
theme = yaml.load(theme, Loader=yaml.FullLoader)

wallpaper_path = os.popen("exconman get awesome.general.wallpaper").read()[:-1]
wallpaper_name = os.path.splitext(os.path.basename(wallpaper_path))[0]

# Disable shadows if the wallpaper is generated (because it's ugly)
if wallpaper_name == "generated":
    os.system("exconman set picom.shadow false")

settings = {
    # GENERAL
    "awesome.general.border_normal"       : "#" + theme["base01"],
    "awesome.general.border_focused"      : "#" + theme["base09"],
                                                 
    # ALPHA BAR                                  
    "awesome.alpha.bar.bg"                : "#" + theme["base00"],
    "awesome.alpha.bar.fg"                : "#" + theme["base05"],
    "awesome.alpha.bar.focused_tag_fg"    : "#" + theme["base09"],
    "awesome.alpha.bar.occupied_tag_fg"   : "#" + theme["base0B"],
    "awesome.alpha.bar.empty_tag_fg"      : "#" + theme["base03"],
    "awesome.alpha.bar.label_fg"          : "#" + theme["base0E"],
    "awesome.alpha.bar.decoration_fg"     : "#" + theme["base0D"],
    "awesome.alpha.bar.muted_fg"          : "#" + theme["base08"],
    "awesome.alpha.bar.low_battery_fg"    : "#" + theme["base08"],
    "awesome.alpha.bar.middle_battery_fg" : "#" + theme["base0A"],
    "awesome.alpha.bar.full_battery_fg"   : "#" + theme["base0B"],
                                                 
    # ALPHA TITLEBAR                             
    "awesome.alpha.titlebar.bg_normal"    : "#" + theme["base01"],
    "awesome.alpha.titlebar.fg_normal"    : "#" + theme["base09"],
    "awesome.alpha.titlebar.bg_focused"   : "#" + theme["base09"],
    "awesome.alpha.titlebar.fg_focused"   : "#" + theme["base01"],

    # ALPHA NOTIFICATION                             
    "awesome.alpha.notification.bg"       : "#" + theme["base00"],
    "awesome.alpha.notification.fg"       : "#" + theme["base05"],
                                                 
    # ALPHA ROFI                                 
    "rofi.alpha.bg"                       : "#" + theme["base00"],
    "rofi.alpha.fg"                       : "#" + theme["base05"],
    "rofi.alpha.bg_focused"               : "#" + theme["base0C"],
    "rofi.alpha.fg_focused"               : "#" + theme["base00"],
    "rofi.alpha.prompt_fg"                : "#" + theme["base0F"],

    # ALACRITTY
    "alacritty.theme"                     : "~/environment/themes/alacritty/colors/base16-" + theme_name + ".yml",

    # NEOVIM
    "neovim.colorscheme"                  : "base16-" + theme_name
}

# Generate plain color wallpaper
os.system('convert -size 1920x1080 xc:#{} ~/Pictures/wallpapers/generated.png'.format(theme["base00"]))
os.system('notify-send "Generated plain wallpaper"')

# Generate flatcolor base16 theme
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-2\" --output-root ~/.themes/FlatColor/gtk-2.0 --output-file colors2 -d".format(theme_path))
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-3\" --output-root ~/.themes/FlatColor/gtk-3.0 --output-file colors3 -d".format(theme_path))
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-3\" --output-root ~/.themes/FlatColor/gtk-3.20 --output-file colors3 -d".format(theme_path))
os.system('notify-send "Built gtk-flatcolor schemes"')

# Generate Neovim Colorscheme (Even though this is useless, I placed it here so that if I create my own base16 theme I do not have to build it manually)
os.system('base16-builder build --scheme {} --template-repo ~/environment/base16/templates/alacritty --template-name default --output-root ~/environment/themes/alacritty'.format(theme_path))
os.system('base16-builder build --scheme {} --template-repo ~/environment/base16/templates/vim --output-root ~/.local/share/nvim/site/pack/packer/start/vim-base16-colorschemes'.format(theme_path))

# Generate icon theme
os.system("exec ~/environment/scripts/generate_archdroid_icons.sh {}".format(theme["base0D"]))
os.system("notify-send \"Generated icons\"")

# Convert current wallpaper to base16 theme
if wallpaper_name == "generated_from_picture":
    last_converted_wallpaper = open(os.path.expanduser("~/environment/cache/last_converted_wallpaper.txt"), "r").read()
    os.system("python ~/environment/scripts/match_image_to_base16.py {} {}".format(theme_path, last_converted_wallpaper))
else:
    os.system("python ~/environment/scripts/match_image_to_base16.py {} {}".format(theme_path, wallpaper_path))
os.system("notify-send \"Converted wallpaper\"")

# Exconman settings
for setting in settings.keys():
    value = settings[setting]
    os.system('exconman set "{}" "{}"'.format(setting, value))
os.system("notify-send \"Set exconman settings\"")

# Reload awesomewm
os.system('awesome-client "require(\'util\').session.restart()" &')
# Reload neovim colorscheme
os.system('python ~/environment/scripts/execute_command_for_all_neovim_instances.py ":luafile ~/.config/nvim/lua/config/opts.lua" &')
# Reload xsettingsd
os.system('killall xsettingsd')
os.system('xsettingsd &')
