import sys
import os

def e(command): 
    return os.popen(command).read()[:-1]

modifiers_root = "~/.config/audot/modifiers"
modifier_paths = os.listdir(os.path.expanduser(modifiers_root))
modifier_names = []

for path in modifier_paths:
    name = e("audot query modifier {} name".format(modifiers_root + '/' + path))
    modifier_names.append(name)

modifier = e('echo "{}" | rofi -dmenu -format i -i -p "Modifier: " -theme-str \'prompt {{ enabled: false; }} element-icon {{ enabled: false; }} \''.format("\n".join(modifier_names)))

if modifier != '':
    modifier = int(modifier)
    name = modifier_names[modifier]

    modifier = modifier_paths[modifier]
    
    # Remove enabled text from the current modifier
    current_modifier = e('audot query config modifier')
    current_modifier_new_name = e('audot query modifier {} name'.format(current_modifier)).replace(' (Enabled)', '')
    e('audot edit modifier {} name "{}"'.format(current_modifier, current_modifier_new_name))

    e('audot edit config modifier "{}"'.format(modifiers_root + '/' + modifier))
    e('audot edit modifier {} name "{}"'.format(modifiers_root + '/' + modifier, name + ' (Enabled)'))
    os.system('audot start')
    os.system('bspc wm -r')


