import os

notifications_dir = os.path.expanduser("~/.config/awesome/ui_elements/notifications")
notifications = os.listdir(notifications_dir)

for i, notification in enumerate(notifications):
    notifications[i] = notification.replace(".lua", "")

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Bar:"'.format("\n".join(notifications))

index = os.popen(cmd).read()[:-1]


if index != "":
    index = int(index)
    notification = notifications[index]
    os.system("exconman set awesome.notification {}".format(notification))
