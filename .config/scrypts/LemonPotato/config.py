import os
import json
import sys
import functions

application_config_root = os.path.expanduser('~/.config/lemonpotato')

registry_dir = ''
modes_dir = ''
overrides_dir = ''
current_mode = ''
current_override = ''
already_set = ''

if not os.path.exists(application_config_root + '/settings.json'):
    functions.notify('LemonPotato: ERROR', '"settings.json" file does not exist.', 'critical')
    sys.exit()
else:
    settings_file = functions.open_json_file(application_config_root + '/settings.json')

    if settings_file == False:
        sys.exit()
    else:
        try:
            registry_dir = os.path.expanduser(settings_file['registry_dir'])
            modes_dir = os.path.expanduser(settings_file['modes_dir'])
            overrides_dir = os.path.expanduser(settings_file['overrides_dir'])
            current_mode = settings_file['current_mode']
            current_override = settings_file['current_override']
            already_set = settings_file['already_set']

            if not os.path.exists(registry_dir) or not os.path.exists(modes_dir) or not os.path.exists(overrides_dir):
                functions.notify('LemonPotato: ERROR', 'One or more of the following directories do not exist: "{}", "{}", "{}" '.format(registry_dir, modes_dir, overrides_dir), 'critical')
                sys.exit()

            elif os.path.isfile(registry_dir) or os.path.isfile(modes_dir) or os.path.isfile(overrides_dir):
                functions.notify('LemonPotato: ERROR', 'One or more of the following directories are files: "{}", "{}", "{}" '.format(registry_dir, modes_dir, overrides_dir), 'critical')
                sys.exit()

        except KeyError:
            functions.notify('LemonPotato: ERROR', 'Settings file does not contain all the required keys', 'critical')
            sys.exit()