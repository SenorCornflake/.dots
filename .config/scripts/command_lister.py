import os
import sys
import json

def e(command):
    return os.popen(command).read()[:-1]

commands = json.loads(open(os.path.expanduser('~/.config/scripts/storage/commands.json'), 'r').read())

command_list = []

for command in commands:
    command_list.append(command['name'])

index = int(e('echo "{}" | rofi -dmenu -i -format i -p "Command:"'.format("\n".join(command_list))))

print(commands[index]['command'] + ' &')
e(commands[index]['command'] + ' &')
