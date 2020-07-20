import os
import re

import config
import functions


def go():
    mode = functions.open_json_file(config.modes_dir + '/' + config.current_mode + '.json')
    override = functions.open_json_file(config.overrides_dir + '/' + config.current_override + '.json')

    # Continue if there were no errors reading the mode and override file
    if mode != False and override != False and config.already_set == 'false':

        # Check and notify if the mode is not setup correctly
        if 'name' not in mode or 'applications' not in mode:
            functions.notify('LemonPotato: ERROR', 'The keys "applications" and "name" were not found in the mode "{}"'.format(config.modes_dir + '/' + config.current_mode + '.json'))
        else:
            registry = []

            # Load all the application files into one dictionary
            for file_path in os.listdir(config.registry_dir):
                file_path = config.registry_dir + '/' + file_path
                
                application = functions.open_json_file(file_path)

                # Continue if there was no error reading the application file
                if application != False:
                    if 'name' not in application or 'file_path' not in application or 'settings' not in application:
                        functions.notify('LemonPotato: ERROR', 'File "{}" does not contain one or more of the required "name", "file_path" and "settings" keys.'.format(file_path), 'critical')
                    else:
                        registry.append(application)
            
            # Loop though all the applications in the mode file
            for application_name in mode['applications']:
                application_settings = mode['applications'][application_name]
                application_registry = functions.get_application(application_name, registry)
                
                # Notify if the application does not exist in the application registry
                if application_registry == False:
                    functions.notify('LemonPotato: ERROR', 'Application "{}" not found.'.format(application_name))

                # Notify if the config file path does not exist
                elif not os.path.exists(os.path.expanduser(application_registry['file_path'])):
                    functions.notify('LemonPotato: ERROR', 'The configuration file path "{}" for "{}" does not exist'.format(application_registry['file_path'], application_name), 'critical')

                # Notify if the config file path is a directory
                elif os.path.isdir(os.path.expanduser(application_registry['file_path'])):
                    functions.notify('LemonPotato: ERROR', 'The configuration file path "{}" for "{}" is a directory'.format(application_registry['file_path'], application_name), 'critical')
                else:
                    config_file = open(os.path.expanduser(application_registry['file_path']), 'r').read().split("\n")

                    # Loop though the settings defined in the mode file
                    for application_setting in application_settings:
                        # Notify if the setting is not in the application's registry
                        if not application_setting in application_registry['settings']:
                            functions.notify('LemonPotato: ERROR', 'Application "{}" does not have setting "{}" registered.'.format(application_name, application_setting), 'critical')
                        
                        # Notify if the setting in the application's registry does not have the required keys 
                        elif \
                        not 'identifier'      in application_registry['settings'][application_setting] or \
                        not 'identifier_type' in application_registry['settings'][application_setting] or \
                        not 'replacer'        in application_registry['settings'][application_setting] or \
                        not 'replacer_type'   in application_registry['settings'][application_setting] or \
                        not 'value_is_file'   in application_registry['settings'][application_setting]:
                            functions.notify('LemonPotato: ERROR', 'The required keys were not found in the setting "{}" in the registry of the application "{}"'.format(application_setting, application_name), 'critical')

                        # If we're replacing a line
                        else:
                            identifier = application_registry['settings'][application_setting]['identifier']
                            identifier_type = application_registry['settings'][application_setting]['identifier_type']
                            replacer = application_registry['settings'][application_setting]['replacer']
                            replacer_type = application_registry['settings'][application_setting]['replacer_type']
                            value_is_file = application_registry['settings'][application_setting]['value_is_file']

                            application_setting_value = application_settings[application_setting]
                            
                            try:
                                application_setting_value = override['applications'][application_name][application_setting]
                            except:
                                pass

                            if value_is_file:
                                application_setting_value = os.path.expanduser(application_setting_value)

                                # Notify if file does not exist
                                if not os.path.exists(application_setting_value):
                                    functions.notify('LemonPotato: ERROR', 'File path "{}" given in setting "{}" for application "{}" does not exist'.format(application_setting_value, application_setting, application_name))
                                    # Continue to the next setting
                                    continue

                                # Notify if it is a directory
                                if os.path.isdir(application_setting_value):
                                    functions.notify('LemonPotato: ERROR', 'File path "{}" given in setting "{}" for application "{}" is a directory'.format(application_setting_value, application_setting, application_name))
                                    # Continue to the next setting
                                    continue
                                else:
                                    application_setting_value = open(application_setting_value, 'r').read()

                            replacer = replacer.replace('<|value|>', application_setting_value)
                            replacer = replacer.replace('<|home|>', os.path.expanduser('~'))

                            if identifier_type == 'line':
                                if type(identifier) == list:
                                    functions.notify('LemonPotato: ERROR', 'Identifier is a list in setting "{}" in application "{}"'.format(application_setting, application_name))
                                else:
                                    # If we're replacing the line we are matching
                                    if replacer_type == 'inline':
                                        found_match = False

                                        for i, line in enumerate(config_file):
                                            m = re.search(identifier, line)

                                            if m != None:  
                                                # Convert string to list to make mutable
                                                config_file[i] = list(config_file[i])   
                                                config_file[i][m.start():m.end()] = replacer
                                                # Convert to string
                                                config_file[i] = "".join(config_file[i])
                                                found_match = True
                                        
                                        if not found_match:
                                            functions.notify('LemonPotato: ERROR', 'Match not found for setting "{}" in file "{}"'.format(application_setting, application_registry['file_path']))
                                            

                                    # If we're replacing the line above the one we're matching
                                    elif replacer_type == 'above':
                                        found_match = False

                                        for i, line in enumerate(config_file):
                                            m = re.search(identifier, line)
                                            
                                            if m != None:
                                                if i > 0:
                                                    config_file[i - 1] = replacer
                                                    found_match = True
                                                else:
                                                    functions.notify('LemonPotato: ERROR', 'The matched line in file "{}" is the first line, can\'t go above it.'.format(application_registry['file_path']))
                                        
                                        if not found_match:
                                            functions.notify('LemonPotato: ERROR', 'Match not found for setting "{}" in file "{}"'.format(application_setting, application_registry['file_path']))

                                    # If we're replacing the line below the one we're matching
                                    elif replacer_type == 'below':
                                        found_match = False

                                        i = 0

                                        while i < len(config_file):
                                            m = re.search(identifier, config_file[i])
                                            
                                            if m != None:
                                                if i < len(config_file) - 1:
                                                    config_file[i + 1] = replacer
                                                    found_match = True
                                                else:
                                                    functions.notify('LemonPotato: ERROR', 'The matched line in file "{}" is the last line, can\'t go below it.'.format(application_registry['file_path']))
                                                # Don't search the next line because that is what we added
                                                i += 2
                                            else:
                                                i += 1
                                        
                                        if not found_match:
                                            functions.notify('LemonPotato: ERROR', 'Match not found for setting "{}" in file "{}"'.format(application_setting, application_registry['file_path']))

                                    # If the replacer type is not supported
                                    else:
                                        functions.notify('LemonPotato: ERROR', 'Replacer type "{}" for setting "{}" in application "{}" is not supported, possible replacer types are "line", "above" and "below".'.format(replacer_type, application_setting, application_name))


                            # If we're replacing the text between two lines
                            elif identifier_type == 'region':
                                if type(identifier) != list or len(identifier) != 2:
                                    functions.notify('Identifier with type of "region" has to be a list with a length of 2 in setting "{}" in registry of application "{}"'.format(application_setting, application_name), 'critical')
                                else:
                                    start = None
                                    end = None
                                    found_match = False

                                    for i, line in enumerate(config_file):
                                        r = re.search(identifier[0], line)

                                        if r != None:
                                            start = i + 1
                                        
                                        r = re.search(identifier[1], line)

                                        if r != None:
                                            end = i
                                    
                                    if start != None and end != None:
                                        config_file[start:end] = replacer.split("\n")
                                        found_match = True
                                    
                                    if not found_match:
                                            functions.notify('LemonPotato: ERROR', 'Match not found for setting "{}" in file "{}"'.format(application_setting, application_registry['file_path']))
                                        

                            # If the identifier type is not supported
                            else:
                                functions.notify('LemonPotato: ERROR', 'Identifier type "{}" for setting "{}" in application "{}" is not supported, possible identifier types are "line" and "region".'.format(identifier_type, application_setting, application_name))

                    config_file = "\n".join(config_file)
                    open(os.path.expanduser(application_registry['file_path']), 'w').write(config_file)
                    functions.modify_settings('already_set', 'true')
