import os
import json
import sys

"""
This is the script that all my menus scripts runs on, kept this script through out all my arch reinstallations, still going strong.
"""

def e(command): 
    return os.popen(command).read()[:-1]


if len(sys.argv) > 0:
    commands = open(os.path.expanduser(sys.argv[1]), 'r').read()
    commands = json.loads(commands)

    if len(sys.argv) > 2:
        default_prompt = sys.argv[2]
    else:
        default_prompt = "Commands: "

    def menu(commands, prompt = default_prompt):
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
        
    menu(commands)

