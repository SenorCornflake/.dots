import os
import sys

from pynvim import attach

if len(sys.argv) < 1:
    sys.exit()

cmd = sys.argv[1]

def get_all_instances():
    instances = []

    # get the content of /tmp
    directory_content = os.listdir('/tmp')
    for directory in directory_content:
        # check if it contains directories starting with nvim
        if directory.startswith('nvim'):
            # check if the nvim directories contains a socket
            dc = os.listdir('/tmp/' + directory)
            if '0' in dc:
                instances.append('/tmp/' + directory + '/0')
    return instances


def reload(instance):
    # connect over the socket
    nvim = attach('socket', path=instance)

    # execute the command
    nvim.command(cmd)


# search for neovim instances
instances = get_all_instances()

# connect to instances and reload them
for instance in instances:
    reload(instance)
