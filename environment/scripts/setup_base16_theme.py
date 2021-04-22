import os
import sys

import yaml

if len(sys.argv) < 3:
    print("Provide a base16 theme and state whether to avoid converting the wallpapers colors")
    sys.exit()

theme_path = os.path.expanduser(sys.argv[1])
theme_name = os.path.splitext(os.path.basename(theme_path))[0]
avoid_conversion = sys.argv[2]

if avoid_conversion == "true":
    avoid_conversion = True
elif avoid_conversion == "false":
    avoid_conversion = False

# os.system("notify-send \"{}\"".format(theme_name))

if not os.path.exists(theme_path):
    print("Path does not exist")
    sys.exit()

theme = open(theme_path, 'r').read()
theme = yaml.load(theme, Loader=yaml.FullLoader)

wallpaper_path = os.popen("exconman get awesome.general.wallpaper").read()[:-1]

settings = {
    # GENERAL
    "awesome.general.borderNormal"      : "#" + theme["base01"],
    "awesome.general.borderFocused"     : "#" + theme["base05"],
                                           
    # ALPHA BAR                            
    "awesome.alpha.bar.bg"              : "#" + theme["base00"],
    "awesome.alpha.bar.fg"              : "#" + theme["base05"],
    "awesome.alpha.bar.focusedTagFg"    : "#" + theme["base0E"],
    "awesome.alpha.bar.occupiedTagFg"   : "#" + theme["base0B"],
    "awesome.alpha.bar.emptyTagFg"      : "#" + theme["base03"],
    "awesome.alpha.bar.labelFg"         : "#" + theme["base0C"],
    "awesome.alpha.bar.decorationFg"    : "#" + theme["base0D"],
    "awesome.alpha.bar.mutedFg"         : "#" + theme["base08"],
    "awesome.alpha.bar.lowBatteryFg"    : "#" + theme["base08"],
    "awesome.alpha.bar.middleBatteryFg" : "#" + theme["base0A"],
    "awesome.alpha.bar.fullBatteryFg"   : "#" + theme["base0B"],

    # ALPHA TITLEBAR                           
    "awesome.alpha.titlebar.bgNormal"   : "#" + theme["base01"],
    "awesome.alpha.titlebar.fgNormal"   : "#" + theme["base05"],
    "awesome.alpha.titlebar.bgFocused"  : "#" + theme["base05"],
    "awesome.alpha.titlebar.fgFocused"  : "#" + theme["base05"],

    # ALPHA ROFI                           
    "rofi.alpha.bg"                     : "#" + theme["base00"],
    "rofi.alpha.fg"                     : "#" + theme["base05"],
    "rofi.alpha.bg_focused"             : "#" + theme["base0C"],
    "rofi.alpha.fg_focused"             : "#" + theme["base00"],
    "rofi.alpha.prompt_fg"              : "#" + theme["base0F"],

    # BRAVO BAR
    "awesome.bravo.bar.bg"              : "#" + theme["base00"],
    "awesome.bravo.bar.fg"              : "#" + theme["base05"],
    "awesome.bravo.bar.focusedTagFg"    : "#" + theme["base0E"],
    "awesome.bravo.bar.occupiedTagFg"   : "#" + theme["base0A"],
    "awesome.bravo.bar.emptyTagFg"      : "#" + theme["base03"],
    "awesome.bravo.bar.labelFg"         : "#" + theme["base0D"],
    "awesome.bravo.bar.sepFg"           : "#" + theme["base02"],
    "awesome.bravo.bar.mutedFg"         : "#" + theme["base08"],

    # ALACRITTY
    "alacritty.theme"                   : "~/environment/application_colorschemes/alacritty/colors/base16-" + theme_name + ".yml",

    # NEOVIM
    "neovim.colorscheme"                : "base16-" + theme_name,

    # DUNST
    "dunst.background"                  : "#" + theme["base00"],
    "dunst.foreground"                  : "#" + theme["base05"],
    "dunst.frame_color"                 : "#" + theme["base05"],
    "dunst.icon"                        : "archdroid",
}

# Generate plain color wallpaper
os.system('convert -size 1920x1080 xc:#{} ~/Pictures/wallpapers/generated.png'.format(theme["base00"]))

# Generate flatcolor base16 theme
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-2\" --output-root ~/.themes/FlatColor/gtk-2.0 --output-file colors2 -d".format(theme_path))
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-3\" --output-root ~/.themes/FlatColor/gtk-3.0 --output-file colors3 -d".format(theme_path))
os.system("base16-builder build --scheme {} --template-repo ~/Repositories/base16-builder/templates/gtk-flatcolor --template-name \"gtk-3\" --output-root ~/.themes/FlatColor/gtk-3.20 --output-file colors3 -d".format(theme_path))

# Generate Neovim and Alacritty Colorscheme (Even though this is useless, I placed it here so that if I create my own base16 theme I do not have to build it manually)
os.system('base16-builder build --scheme {} --template-repo ~/environment/base16/templates/alacritty --template-name default --output-root ~/environment/application_colorschemes/alacritty'.format(theme_path))
os.system('base16-builder build --scheme {} --template-repo ~/environment/base16/templates/vim --output-root ~/.local/share/nvim/site/pack/packer/start/vim-base16-colorschemes'.format(theme_path))

# Change exconman base16 style
for setting in settings.keys():
    value = settings[setting]
    os.system('python ~/environment/scripts/modify_json.py ~/environment/themes/styles/base16.json "{}" "{}"'.format(setting, value))
os.system("exconman load ~/environment/themes/styles/base16.json")

# Generate icon theme
os.system("exec ~/environment/scripts/generate_archdroid_icons.sh {}".format(theme["base0D"]))

# Restart all programs that need restarting
os.system("python ~/environment/scripts/restart_all.py")

wallpapers_with_no_shadow = [
    os.path.expanduser("~/Pictures/wallpapers/generated.png"),
    os.path.expanduser("~/Pictures/wallpapers/color-skull.jpg"),
    os.path.expanduser("~/Pictures/wallpapers/astronaut-powers.jpg"),
]

# Convert current wallpaper to base16 theme
if not avoid_conversion:
    if wallpaper_path == os.path.expanduser("~/Pictures/wallpapers/generated_from_picture.jpg"):
        last_converted_wallpaper = open(os.path.expanduser("~/environment/cache/last_converted_wallpaper.txt"), "r").read()
        os.system("python ~/environment/scripts/match_image_to_base16.py {} {}".format(theme_path, last_converted_wallpaper))
        os.system("awesome-client 'require(\"CONFIG.util\").set_wallpaper(\"{}\")'".format(wallpaper_path))

        # Disable shadows if last converted wallpaper is any of the following
        if last_converted_wallpaper in wallpapers_with_no_shadow:
            os.system("exconman set picom.shadow false")
    elif wallpaper_path != os.path.expanduser("~/Pictures/wallpapers/generated.png"):
        os.system("python ~/environment/scripts/match_image_to_base16.py {} {}".format(theme_path, wallpaper_path))
        os.system("awesome-client 'require(\"CONFIG.util\").set_wallpaper(\"{}\")'".format("~/Pictures/wallpapers/generated_from_picture.jpg"))

        if wallpaper_path in wallpapers_with_no_shadow:
            os.system("exconman set picom.shadow false")
os.system("notify-send \"COMPLETED\"")
