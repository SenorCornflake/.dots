import os

rofi_layouts_dir = os.path.expanduser("~/.config/rofi/layouts")
rofi_layouts = os.listdir(rofi_layouts_dir)

for i, layout in enumerate(rofi_layouts):
    rofi_layouts[i] = layout.replace(".rasi", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Bar:"'.format("\n".join(rofi_layouts))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    layout = rofi_layouts[index]
    os.system("exconman set rofi.layout {}".format(layout))
