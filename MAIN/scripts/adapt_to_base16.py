import os
import sys
import yaml
import json

if len(sys.argv) > 1:
    base16_path = os.path.expanduser(sys.argv[1])
    base16 = yaml.load(open(base16_path, "r").read(), Loader=yaml.FullLoader)
    base16_name = os.path.splitext(os.path.basename(base16_path))[0]

    exconman_theme_path = os.path.expanduser("~/MAIN/themes/base16.json")
    exconman_settings = {
        "polybar.1_bg": "#" + base16["base00"],
        "polybar.1_fg": "#" + base16["base05"],
        "polybar.1_widget_bg": "#" + base16["base01"],
        "polybar.1_accent": "#" + base16["base0C"],
        "polybar.1_empty": "#" + base16["base01"],
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

        "bspwm.focused_border_color": "#" + base16["base05"],
        "bspwm.normal_border_color": "#" + base16["base01"],
        "bspwm.active_border_color": "#" + base16["base02"],
        "bspwm.urgent_border_color": "#" + base16["base08"],
        "bspwm.presel_feedback_color": "#" + base16["base05"],

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

        "dunst.background": "#" + base16["base00"],
        "dunst.foreground": "#" + base16["base05"],
        "dunst.frame_color": "#" + base16["base0E"],
    }

    os.system("base16-builder build -t ~/repos/base16-builder/templates/alacritty/ -s {} -o ~/.config/alacritty/colors/ -d".format(base16_path))

    # If we generated a base16 theme from neovim colorscheme, don't bother generating a base16 colorscheme for neovim
    if len(sys.argv) == 3:
        exconman_settings["neovim.colorscheme"] = sys.argv[2]
    else:
        os.system("base16-builder build -t ~/repos/base16-builder/templates/vim/ -s {} -o ~/MAIN/tmp/vim_colors/colors/ -d".format(base16_path))
        exconman_settings["neovim.colorscheme"] = "base16-" + base16_name

    # Build alacritty scheme
    os.system("base16-builder build -t ~/repos/base16-builder/templates/alacritty/ -s {} -o ~/.config/alacritty/colors/ -d".format(base16_path))

    # Build gtk theme for FlatColor
    os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-2.0/ -f colors2 -d".format(base16_path))
    os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-3.0/ -f colors3 -d".format(base16_path))
    os.system("base16-builder build -t ~/repos/base16-builder/templates/gtk-flatcolor/ -s {} -o ~/.themes/FlatColor/gtk-3.20/ -f colors3 -d".format(base16_path))

    # Generate archdroid icons
    os.system("sh ~/MAIN/scripts/generate_archdroid_icons.sh {}".format(base16["base0A"]))

    # Create/Overwrite exconman base16 theme with the one we just created. 
    open(exconman_theme_path, "w").write(json.dumps(exconman_settings, indent=4))

    # Load the exconman theme we created
    os.system("exconman load {}".format(exconman_theme_path))

    # Restart most applications
    os.system("sh ~/MAIN/scripts/restart_all.sh")
