import os
import sys

layouts_dir  = os.path.expanduser("~/MAIN/layouts")
layout_names = []
layouts = []

layouts = os.listdir(layouts_dir)

for l in layouts:
    layout_names.append(l.replace(".json", "").replace(".sh", ""))

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join(layout_names))
index = os.popen(cmd).read()[:-1]

if index == "":
    sys.exit()


index = int(index)
layout = layouts[index]

# load the layout
filename, extension = os.path.splitext(layout)
if extension == ".sh":
    os.system("sh {}".format(layouts_dir + "/" + layout))
elif extension == ".json":
    os.system("exconman load {}".format(layouts_dir + "/" + layout))

# save the newly enabled layout
open(os.path.expanduser("~/MAIN/tmp/current_layout.txt"), "w").write(layout)

# restart everything
os.system("sh ~/MAIN/scripts/restart_all.sh")
