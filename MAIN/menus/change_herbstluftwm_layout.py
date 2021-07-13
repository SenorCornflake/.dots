import os

layouts_dir = os.path.expanduser("~/MAIN/layouts/herbstluftwm")
layouts = os.listdir(layouts_dir)

for i, layout in enumerate(layouts):
    layouts[i] = layout.replace(".json", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join(layouts))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    layout = layouts[index]
    os.system("exconman load {}".format(layouts_dir + "/" + layout + ".json"))
    os.system("herbstclient reload")
