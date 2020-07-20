import os

def e(command):
    return os.popen(command).read()[:-1]

confirm = e('echo "No.\nYes." | rofi -dmenu -format i -p "Are you sure?"')

if confirm != '' and confirm != '0':
        e('notify-send "Closing" "Closing all windows."')
        
        node_list = e('bspc query -N').split("\n")

        for node in node_list:
            e('bspc node {} --close'.format(node))