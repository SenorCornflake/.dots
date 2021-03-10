import os

titlebars_dir = os.path.expanduser("~/.config/awesome/ui_elements/titlebars")
titlebars = os.listdir(titlebars_dir)

for i, titlebar in enumerate(titlebars):
    titlebars[i] = titlebar.replace(".lua", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Bar:"'.format("\n".join(titlebars))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    titlebar = titlebars[index]
    os.system("exconman set awesome.titlebar {}".format(titlebar))
