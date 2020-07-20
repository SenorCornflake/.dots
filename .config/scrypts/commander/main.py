import os
import json


def e(command): 
    return os.popen(command).read()[:-1]


commander_root = os.path.expanduser('~/.config/scrypts/commander')
commands = open(commander_root + '/commands.json', 'r').read()
commands = json.loads(commands)


def menu(commands, prompt = 'Command: '):
    command_names = []
    command_actions = []
    command_prompts = []

    for command in commands:
        command_names.append(command['name'])
        command_actions.append(command['action'])

        if 'prompt' in command:
            command_prompts.append(command['prompt'])
        else:
            command_prompts.append(prompt)
         

    c = 'echo "{}" | rofi -dmenu -format i -i -p "{}" -theme-str \'element-icon {{ enabled: false; }} \''.format("\n".join(command_names), prompt)

    index = e(c)

    if index != '':
        index = int(index)
        command = command_actions[index]

        if type(command) == list:
            menu(command, command_prompts[index])
        else:
            os.system(command)
    
    print(command_prompts)

menu(commands)