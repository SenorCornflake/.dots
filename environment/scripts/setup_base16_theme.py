import os
import sys

import yaml

if len(sys.argv) < 2:
    print("Provide a base16 theme")
    sys.exit()

theme_path = os.path.expanduser(sys.argv[1])
theme_name = os.path.splitext(os.path.basename(theme_path))[0]

if not os.path.exists(theme_path):
    print("Path does not exist")
    sys.exit()

theme = open(theme_path, 'r').read()
theme = yaml.load(theme, Loader=yaml.FullLoader)

# Genrate plain color wallpaper
os.system('convert -size 1920x1080 xc:#{} ~/Pictures/wallpapers/generated.png'.format(theme["base00"]))


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
    "awesome.alpha.notification.bg"    : "#" + theme["base00"],
    "awesome.alpha.notification.fg"    : "#" + theme["base05"],
                                                 
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

for setting in settings.keys():
    value = settings[setting]
    os.system('exconman set "{}" "{}"'.format(setting, value))

wallpaper_path = os.popen("exconman get awesome.general.wallpaper").read()[:-1]
wallpaper_name = os.path.splitext(os.path.basename(wallpaper_path))[0]

# Disable shadows if the wallpaper is generated (because it's ugly)
if wallpaper_name == "generated":
    os.system("exconman set picom.shadow false")

# Reload awesomewm
os.system('awesome-client "require(\'util\').session.restart()" &')
# Reload neovim colorscheme
os.system('python ~/environment/scripts/execute_command_for_all_neovim_instances.py ":luafile ~/.config/nvim/lua/config/opts.lua" &')

# Lastly, because it takes the longest time, create a base16 colored version of the current wallpaper
os.system("python ~/environment/scripts/match_image_to_base16.py {} {}".format(theme_path, wallpaper_path))

if wallpaper_name == "generated_from_picture":
    print("Re-applying wallpaper...")
    os.system('awesome-client "require(\\"util\\").set_wallpaper(\\"{}\\")"'.format(os.path.expanduser("~/Pictures/wallpapers/generated_from_picture.jpg")))
