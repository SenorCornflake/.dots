import os
import sys

wallpaper_dir = os.path.expanduser(sys.argv[1])

wallpapers = os.listdir(wallpaper_dir)
cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Wallpaper"'.format("\n".join(wallpapers))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)

    image_location = wallpaper_dir + "/" + wallpapers[index]
    colors_txt = "~/MAIN/tmp/colors.txt"
    script_location = "~/repos/auto-base16-theme/AutoBase16Theme.py"
    template_location = "~/repos/auto-base16-theme/templates/base16-template.yaml"
    output_location = "~/MAIN/tmp/base16_schemes/schemer2.yaml"

    cmd = "schemer2 -threshold 50 -format img::colors -in {} -out {} && python {} --inputColorPaletteFile {} {} {}".format(image_location, colors_txt, script_location, colors_txt, template_location, output_location)
    os.system(cmd)

    os.system('exconman set bspwm.wallpaper "{}"'.format(wallpaper_dir + "/" + wallpapers[index]))

    os.system("python ~/MAIN/scripts/adapt_to_base16.py ~/MAIN/tmp/base16_schemes/schemer2.yaml")

