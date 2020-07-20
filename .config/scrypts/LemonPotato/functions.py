import os
import sys
import json

import config

def e(command):
    return os.popen(command)[:-1]

def notify(title, message, urgency="normal"):
    # Escape double quotes
    title = title.replace('"', '\\"')
    message = message.replace('"', '\\"')

    if urgency == 'critical':
        os.system('notify-send "{}" "{}" --urgency=critical'.format(title, message))
    else:
        os.system('notify-send "{}" "{}" --urgency=normal'.format(title, message))

def open_json_file(file_path):
    try:
        json_file = json.loads(open(file_path, 'r').read())
    except FileNotFoundError:
        notify('LemonPotato: ERROR', '"FileNotFoundError" while trying to read "{}"'.format(file_path), 'critical')
        return False
    except IsADirectoryError:
        notify('LemonPotato: ERROR', '"IsADirectoryError" while trying to read "{}"'.format(file_path), 'critical')
        return False
    except json.decoder.JSONDecodeError:
        notify('LemonPotato: ERROR', '"json.decoder.JSONDecodeError" while trying to read "{}"'.format(file_path), 'critical')
        return False
    
    return json_file

def get_application(name, registry):
    for application in registry:
        if name == application['name']:
            return application
    return False

def query_settings(key):
    if not key in config.settings_file:
        notify('LemonPotato: ERROR', 'Key "{}" does not exist in the settings file'.format(key))
    else:
        return config.settings_file[key]
        
def query_mode(mode_name, key_path):
    mode = open_json_file(config.modes_dir + '/' + mode_name + '.json')

    # Continue if there were no errors reading the mode and override file
    if mode != False:

        key_path = key_path.split('/')

        temp = mode

        for key in key_path:
            if not key in temp:
                notify('LemonPotato: ERROR', 'Key Path "{}" does not exist in mode "{}"'.format("/".join(key_path), mode_name), 'critical')
                return False
            else:
                temp = temp[key]

        return temp

def query_override(override_name, key_path):
    override = open_json_file(config.overrides_dir + '/' + override_name + '.json')

    # Continue if there were no errors reading the override and override file
    if override != False:

        key_path = key_path.split('/')

        temp = override

        for key in key_path:
            if not key in temp:
                notify('LemonPotato: ERROR', 'Key Path "{}" does not exist in override "{}"'.format("/".join(key_path), override_name), 'critical')
                return False
            else:
                temp = temp[key]

        return temp

def modify_settings(key, value):
    if not key in config.settings_file:
        notify('LemonPotato: ERROR', 'Key "{}" does not exist in the settings file'.format(key))
    else:
        config.settings_file[key] = value
        open(config.application_config_root + '/settings.json', 'w').write(json.dumps(config.settings_file, indent=4))

def modify_mode(mode_name, key_path, value):
    mode = open_json_file(config.modes_dir + '/' + mode_name + '.json')

    # Continue if there were no errors reading the mode and override file
    if mode != False:

        key_path = key_path.split('/')
        key_path_dict = 'mode'

        temp = mode

        for i, key in enumerate(key_path):
            if not key in temp:
                notify('LemonPotato: ERROR', 'Key Path "{}" does not exist in mode "{}"'.format("/".join(key_path), mode_name), 'critical')
                return
            else:
                temp = temp[key]
                key = '["{}"]'.format(key)
                key_path_dict += key
                if i == len(key_path) - 1:
                    exec('{} = {}'.format(key_path_dict, value))

        open(config.modes_dir + '/' + mode_name + '.json', 'w').write(json.dumps(mode, indent=4))


def modify_override(override_name, key_path, value):
    override = open_json_file(config.overrides_dir + '/' + override_name + '.json')

    # Continue if there were no errors reading the override and override file
    if override != False:

        key_path = key_path.split('/')
        key_path_dict = 'override'

        temp = override

        for i, key in enumerate(key_path):
            if not key in temp:
                notify('LemonPotato: ERROR', 'Key Path "{}" does not exist in override "{}"'.format("/".join(key_path), override_name), 'critical')
                return
            else:
                temp = temp[key]
                key = '["{}"]'.format(key)
                key_path_dict += key
                if i == len(key_path) - 1:
                    exec('{} = {}'.format(key_path_dict, value))

        open(config.overrides_dir + '/' + override_name + '.json', 'w').write(json.dumps(override, indent=4))