import os

layouts = [
    "us",
    "ara",
    "dvorak",
    "dvp",
]

layouts = [
    { 
        "name": "US QWERTY",
        "layout": "us",
        "variant": "\"\""
    },
    { 
        "name": "US DVORAK Programmer",
        "layout": "us",
        "variant": "dvp"

    },
    { 
        "name": "US DVORAK",
        "layout": "us",
        "variant": "dvorak"
    },
    { 
        "name": "ARA QWERTY",
        "layout": "ara",
        "variant": "qwerty"
    }
]

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join([layout["name"] for layout in layouts]))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    layout = layouts[index]

    os.system("setxkbmap -layout {} -variant {}".format(layout["layout"], layout["variant"]))
