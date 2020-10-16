#  This is the file I use to run scripts that don't provide long term use


# Get all base16 themes
import os
import yaml

base16_folder = '~/Repositories/base16-themes'
output_folder = '~/Repositories/vim-base16-colorschemes/colors'

themes = os.listdir(os.path.expanduser(base16_folder))

for theme in themes:
    os.system('base16-builder ')
