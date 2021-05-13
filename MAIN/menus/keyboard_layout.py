import os

layouts = [
    "us",
    "ara"
]

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join(layouts))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    layout = layouts[index]

    os.system("setxkbmap {}".format(layout))
