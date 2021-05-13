import os

themes_dir = os.path.expanduser("~/MAIN/themes")
themes = os.listdir(themes_dir)

for i, theme in enumerate(themes):
    themes[i] = theme.replace(".json", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Theme:"'.format("\n".join(themes))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    theme = themes[index]
    os.system("exconman load {}".format(themes_dir + "/" + theme + ".json"))
    os.system("sh ~/MAIN/scripts/restart_all.sh")
