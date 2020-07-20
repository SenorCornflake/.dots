import os
import sys

import config
import functions
import go

try:
    if sys.argv[1] == 'go':
        go.go()

    elif sys.argv[1] == 'modify':
        if sys.argv[2] == 'mode':
            name_index = sys.argv.index('--name') + 1
            value_index = sys.argv.index('--value') + 1
            key_path_index = sys.argv.index('--key-path') + 1
            
            name = sys.argv[name_index]
            value = sys.argv[value_index]
            key_path = sys.argv[key_path_index]

            functions.modify_mode(name, key_path, "'" + value + "'")

        elif sys.argv[2] == 'override':
            name_index = sys.argv.index('--name') + 1
            value_index = sys.argv.index('--value') + 1
            key_path_index = sys.argv.index('--key-path') + 1
            
            name = sys.argv[name_index]
            value = sys.argv[value_index]
            key_path = sys.argv[key_path_index]

            functions.modify_override(name, key_path, "'" + value + "'")
        
        elif sys.argv[2] == 'setting':
            name_index = sys.argv.index('--name') + 1
            name = sys.argv[name_index]

            value_index = sys.argv.index('--value') + 1
            value = sys.argv[value_index]

            functions.modify_settings(name, value)

    elif sys.argv[1] == 'query':
        if sys.argv[2] == 'mode':
            name_index = sys.argv.index('--name') + 1
            name = sys.argv[name_index]

            key_path_index = sys.argv.index('--key-path') + 1
            key_path = sys.argv[key_path_index]

            print(functions.query_mode(name, key_path))

        elif sys.argv[2] == 'override':
            name_index = sys.argv.index('--name') + 1
            name = sys.argv[name_index]

            key_path_index = sys.argv.index('--key-path') + 1
            key_path = sys.argv[key_path_index]
            print(functions.query_override(name, key_path))
        
        elif sys.argv[2] == 'setting':
            name_index = sys.argv.index('--name') + 1
            name = sys.argv[name_index]

            print(functions.query_settings(name))
    
    else:
        print('USE CASE #1: Query a value in the settings file, a mode or override')
        print('\tquery mode --name example --key-path applications/example-application/setting')
        print('\tquery override --name example --key-path applications/example-application/setting')
        print('\tquery setting --name already_set')
        print()
        print('USE CASE #2: Modify a value in the settings file, a mode or override')
        print('\tmodify mode --name example --key-path applications/example-application/setting --value examplevalue')
        print('\tmodify override --name example --key-path applications/example-application/setting --value examplevalue')
        print('\tmodify setting --name already_set --value examplevalue')
        print()
        print('USE CASE #3: Start replacing identifiers with their values')
        print('\tgo')

except IndexError:
    print('Something went wrong, please double check your command.')
except ValueError:
    print('Something went wrong, please double check your command.')