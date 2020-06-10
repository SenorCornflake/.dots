import os
import sys
import time

def e(command):
    return os.popen(command).read()[:-1]

action = e('echo "Shutdown.\nReboot.\nLogout.\nCancel." | rofi -dmenu -i -columns 1 -format i -p "Action: "')

if action != '':
    if action == '0':
        confirm = e('echo "No.\nYes." | rofi -dmenu -columns -1 -format i -p "Are you sure?"')

        if confirm != '' and confirm != '0':
            e('shutdown now')

    elif action == '1':
        confirm = e('echo "No.\nYes." | rofi -dmenu -columns -1 -format i -p "Are you sure?"')

        if confirm != '' and confirm != '0':
            e('shutdown -r now')
    
    elif action == '2':
        confirm = e('echo "No.\nYes." | rofi -dmenu -columns -1 -format i -p "Are you sure?"')

        if confirm != '' and confirm != '0':
            e('bspc quit && while pgrep -x bspwm >/dev/null; do sleep 1; done && kill -9 -1')

    else:
        pass