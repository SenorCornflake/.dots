import os

themes_dir = os.path.expanduser("~/environment/themes")
themes = os.listdir(themes_dir)

for i, theme in enumerate(themes):
    themes[i] = theme.replace(".json", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Bar:"'.format("\n".join(themes))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    theme = themes[index]
    os.system("exconman load {}".format(themes_dir + "/" + theme + ".json"))
    os.system("python ~/environment/scripts/restart_all.py")
