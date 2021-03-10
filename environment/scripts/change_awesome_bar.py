import os

bars_dir = os.path.expanduser("~/.config/awesome/ui_elements/bars")
bars = os.listdir(bars_dir)

for i, bar in enumerate(bars):
    bars[i] = bar.replace(".lua", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Bar:"'.format("\n".join(bars))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    bar = bars[index]
    os.system("exconman set awesome.bar {}".format(bar))
