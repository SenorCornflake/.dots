import os

styles_dir = os.path.expanduser("~/environment/themes/styles")
styles = os.listdir(styles_dir)

for i, style in enumerate(styles):
    styles[i] = style.replace(".json", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Style:"'.format("\n".join(styles))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    style = styles[index]
    os.system("exconman load {}".format(styles_dir + "/" + style + ".json"))
    os.system("python ~/environment/scripts/restart_all.py")
