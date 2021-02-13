import os
import sys
import yaml

from ImageGoNord import GoNord

if len(sys.argv) < 2:
    print("Pass in path to base16 theme and the picture")
    sys.exit()

theme_path = os.path.expanduser(sys.argv[1])
picture_path = os.path.expanduser(sys.argv[2])

theme = open(theme_path, "r").read()
theme = yaml.load(theme, Loader=yaml.FullLoader)

go_nord = GoNord()

image = go_nord.open_image(picture_path)
#go_nord.enable_avg_algorithm()
#go_nord.enable_gaussian_blur()
go_nord.reset_palette()

go_nord.add_color_to_palette("#" + theme["base00"])
go_nord.add_color_to_palette("#" + theme["base01"])
go_nord.add_color_to_palette("#" + theme["base02"])
go_nord.add_color_to_palette("#" + theme["base03"])
go_nord.add_color_to_palette("#" + theme["base04"])
go_nord.add_color_to_palette("#" + theme["base05"])
go_nord.add_color_to_palette("#" + theme["base06"])
go_nord.add_color_to_palette("#" + theme["base07"])
go_nord.add_color_to_palette("#" + theme["base08"])
go_nord.add_color_to_palette("#" + theme["base09"])
go_nord.add_color_to_palette("#" + theme["base0A"])
go_nord.add_color_to_palette("#" + theme["base0B"])
go_nord.add_color_to_palette("#" + theme["base0C"])
go_nord.add_color_to_palette("#" + theme["base0D"])
go_nord.add_color_to_palette("#" + theme["base0E"])
go_nord.add_color_to_palette("#" + theme["base0F"])

open(os.path.expanduser("~/environment/cache/last_converted_wallpaper.txt"), "w").write(picture_path)
picture_file_name = os.path.basename(picture_path)
base16_theme_name = os.path.basename(theme_path).replace(".yml", "").replace(".yaml", "")

go_nord.convert_image(image, save_path=os.path.expanduser("~/Pictures/wallpapers/generated_from_picture.jpg"))
