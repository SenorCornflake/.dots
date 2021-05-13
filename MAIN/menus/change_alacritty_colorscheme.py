import os

colors_dir = os.path.expanduser("~/.config/alacritty/colors")
color_files = os.listdir(colors_dir)
color_names = []


for c in color_files:
    color_names.append(c.replace(".yaml", "").replace(".yml", ""))

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Colorscheme"'.format("\n".join(color_names))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    os.system('exconman set alacritty.colorscheme {}'.format(colors_dir + "/" + color_files[index]))
