import os
import sys
import yaml
import json

if len(sys.argv) < 2:
    print(
        "There are two arguments:\n" +
        "   1. The path to the base16 theme (required)\n" +
        "   2. A neovim colorscheme to use instead generating one (optional)\n" +
        "Options: \n" +
        "   --perform-long-tasks - Perform tasks that'll take a long time, such as generating icons and pictures\n"
    )
    sys.exit()


args_excluding_options = sys.argv

if "--perform-long-tasks" in args_excluding_options:
    args_excluding_options.remove("--perform-long-tasks")

base16_path = os.path.expanduser(sys.argv[1])
base16 = yaml.load(open(base16_path, "r").read(), Loader=yaml.FullLoader)
base16_name = os.path.splitext(os.path.basename(base16_path))[0]

exconman_theme_path = os.path.expanduser("~/MAIN/themes/base16.json")
exconman_settings = {
    "polybar.1_bg": "#" + base16["base00"],
    "polybar.1_fg": "#" + base16["base05"],
    "polybar.1_widget_bg": "#" + base16["base01"],
    "polybar.1_accent": "#" + base16["base0C"],
    "polybar.1_empty": "#" + base16["base02"],
    "polybar.1_error": "#" + base16["base08"],
    "polybar.1_warn": "#" + base16["base09"],
    "polybar.1_success": "#" + base16["base0B"],
    "polybar.1_icon": "#" + base16["base0A"],
    
    "polybar.2_bg": "#" + base16["base00"],
    "polybar.2_fg": "#" + base16["base05"],
    "polybar.2_focused": "#" + base16["base0B"],
    "polybar.2_occupied": "#" + base16["base04"],
    "polybar.2_empty": "#" + base16["base02"],

    "polybar.3_bg": "#" + base16["base00"],
    "polybar.3_fg": "#" + base16["base05"],
    "polybar.3_widget_bg": "#" + base16["base01"],
    "polybar.3_color_1": "#" + base16["base0A"],
    "polybar.3_color_2": "#" + base16["base0B"],
    "polybar.3_color_3": "#" + base16["base0C"],
    "polybar.3_color_4": "#" + base16["base0D"],
    "polybar.3_color_5": "#" + base16["base0E"],

    "polybar.4_bg": "#" + base16["base00"],
    "polybar.4_fg": "#" + base16["base05"],
    "polybar.4_occupied": "#" + base16["base01"],
    "polybar.4_label_1": "#" + base16["base0C"],
    "polybar.4_label_2": "#" + base16["base0B"],
    "polybar.4_label_3": "#" + base16["base0E"],
    "polybar.4_title": "#" + base16["base0A"],


    "polybar.do_you_even_luft_bg": "#" + base16["base00"],
    "polybar.do_you_even_luft_fg": "#" + base16["base00"],
    "polybar.do_you_even_luft_fg_2": "#" + base16["base01"],
    "polybar.do_you_even_luft_accent_left": "#" + base16["base05"],
    "polybar.do_you_even_luft_accent_right": "#" + base16["base05"],
    "polybar.do_you_even_luft_color_1": "#" + base16["base0B"],
    "polybar.do_you_even_luft_color_2": "#" + base16["base05"],

    "bspwm.focused_border_color": "#" + base16["base05"],
    "bspwm.normal_border_color": "#" + base16["base01"],
    "bspwm.active_border_color": "#" + base16["base02"],
    "bspwm.urgent_border_color": "#" + base16["base08"],
    "bspwm.presel_feedback_color": "#" + base16["base05"],

    "herbstluftwm.frame_border_normal_color": "#" + base16["base01"],
    "herbstluftwm.frame_border_active_color": "#" + base16["base0B"],
    "herbstluftwm.frame_bg_normal_color": "#" + base16["base00"] + "80",
    "herbstluftwm.frame_bg_active_color": "#" + base16["base00"] + "80",
    "herbstluftwm.theme.normal.title_color": "#" + base16["base05"],
    "herbstluftwm.theme.active.title_color": "#" + base16["base01"],
    "herbstluftwm.theme.active.color": "#" + base16["base05"],
    "herbstluftwm.theme.normal.color": "#" + base16["base01"],
    "herbstluftwm.theme.urgent.color": "#" + base16["base09"],
    "herbstluftwm.theme.inner_color": "#" + base16["base01"],
    "herbstluftwm.theme.outer_color": "#" + base16["base01"],
    "herbstluftwm.theme.background_color": "#" + base16["base00"],

    "rofi.bottom-bg": "#" + base16["base00"],
    "rofi.bottom-fg": "#" + base16["base05"],
    "rofi.bottom-bg-focused": "#" + base16["base0C"],
    "rofi.bottom-fg-focused": "#" + base16["base00"],
    "rofi.bottom-prompt-fg": "#" + base16["base0E"],
    "rofi.center-bg": "#" + base16["base00"],
    "rofi.center-fg": "#" + base16["base05"],
    "rofi.center-bg-focused": "#" + base16["base0C"],
    "rofi.center-fg-focused": "#" + base16["base00"],
    "rofi.center-prompt-fg": "#" + base16["base0B"],
    "rofi.center-border-color": "#" + base16["base0C"],

    "alacritty.colorscheme": "~/.config/alacritty/colors/base16-" + base16_name + ".yml",

    "kitty.colorscheme": "~/.config/kitty/colors/base16-" + base16_name + ".conf",


    "dunst.background": "#" + base16["base00"],
    "dunst.foreground": "#" + base16["base05"],
    "dunst.frame_color": "#" + base16["base0E"],
}



# If we generated a base16 theme from neovim colorscheme, don't bother generating a base16 colorscheme for neovim
if len(args_excluding_options) == 3:
    exconman_settings["neovim.colorscheme"] = args_excluding_options[2]
else:
    os.system("base16-builder build -t ~/repos/base16-builder/templates/vim/ -s {} -o ~/MAIN/tmp/vim_colors/colors/ -d".format(base16_path))
    exconman_settings["neovim.colorscheme"] = "base16-" + base16_name

# Build alacritty scheme
os.system("base16-builder build -t ~/repos/base16-builder/templates/alacritty/ -s {} -o ~/.config/alacritty/colors/ -d".format(base16_path))

# Build kitty scheme
os.system("base16-builder build -t ~/repos/base16-builder/templates/kitty/ -s {} -o ~/.config/kitty/colors/ -d".format(base16_path))

# Build gtk theme for FlatColor
os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-2.0/ -f colors2 -d".format(base16_path))
os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-3.0/ -f colors3 -d".format(base16_path))
os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-3.20/ -f colors3 -d".format(base16_path))

if "--perform-long-tasks" in sys.argv:
    # Generate archdroid icons
    os.system("sh ~/MAIN/scripts/generate_archdroid_icons.sh {}".format(base16["base0A"]))

# Create/Overwrite exconman base16 theme with the one we just created. 
open(exconman_theme_path, "w").write(json.dumps(exconman_settings, indent=4))

# Load the exconman theme we created
os.system("exconman load {}".format(exconman_theme_path))

# Reload the layout because it might contain settings that the theme overrided
layouts_dir  = os.path.expanduser("~/MAIN/layouts")
layout = os.popen("cat ~/MAIN/tmp/current_layout.txt").read()

filename, extension = os.path.splitext(layout)
if extension == ".sh":
    os.system("sh {}".format(layouts_dir + "/" + layout))
elif extension == ".json":
    os.system("exconman load {}".format(layouts_dir + "/" + layout))

# Restart applications
os.system("sh ~/MAIN/scripts/restart_all.sh")
