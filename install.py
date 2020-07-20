import os
import sys

dotfiles_dir = os.path.dirname(__file__)
files = os.listdir(dotfiles_dir)


excluded_files = [
    'install.py',
    'install_sys.sh',
    'README.md',
    '.git',
    'scrot.png'
]

for f in excluded_files:
    files.remove(f)


if not os.path.exists(os.path.expanduser('~/.config')):
    os.system('mkdir ~/.config')

for f in files:
    if f == '.config':
        for g in os.listdir(dotfiles_dir + '/.config'):
            if g == 'Code':
                if not os.path.exists(os.path.expanduser('~/.config/Code/User')):
                    command = 'mkdir -p ~/.config/Code/User'
                    os.system(command)
                    print(command)

                if os.path.exists(os.path.expanduser('~/.config/Code/User/settings.json')):
                    command = 'rm ~/.config/Code/User/settings.json'
                    os.system(command)
                    print(command)
                
                command = 'ln -s {} ~/.config/Code/User/settings.json'.format(dotfiles_dir + '/.config/Code/User/settings.json')
                os.system(command)
                print(command)

            else:
                if os.path.exists(os.path.expanduser('~/.config/{}'.format(g))):
                    command = 'rm -r ~/.config/{}'.format(g)
                    os.system(command)
                    print(command)
                
                if os.path.exists(os.path.expanduser('~/.config/{}'.format(g))):
                    print(os.path.expanduser('~/.config/{}'.format(g)))

                command = 'ln -s {} ~/.config/{}'.format(dotfiles_dir + '/.config/' + g, g)
                os.system(command)
                print(command)

            print()
    elif f == '.zshenv':
        if os.path.exists(os.path.expanduser('~/.zshenv')):
            command = 'rm -rf ~/.zshenv'
            print(command)
            os.system(command)
        command = 'ln -s {}/.zshenv ~/.zshenv'.format(dotfiles_dir)
        print(command)
        os.system(command)
    elif f == '.local':
        if not os.path.exists(os.path.expanduser('~/.local/share/dbus-1/services')):
            command = 'mkdir -p ~/.local/share/dbus-1/services'
            os.system(command)
            print(command)
        
        if os.path.exists(os.path.expanduser('~/.local/share/dbus-1/services/usernotify.service')):
            command = 'rm ~/.local/share/dbus-1/services/usernotify.service'
            os.system(command)
            print(command)
            
        command = 'ln -s {} ~/.local/share/dbus-1/services/usernotify.service'.format(dotfiles_dir + '/.local/share/dbus-1/services/usernotify.service')
        os.system(command)
        print(command)
        print()
