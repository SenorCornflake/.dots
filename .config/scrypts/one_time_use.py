#  This is the file I use to run scripts that don't provide long term use


# Get all base16 themes
import os
import yaml

compare2 = '~/Desktop/templates/vim/colors'
compare1 = '~/Repositories/vim-base16-colorschemes/colors'

compare1 = os.listdir(os.path.expanduser(compare1))
compare2 = os.listdir(os.path.expanduser(compare2))

for theme in compare1:
    if not theme in compare2:
        print(theme)
