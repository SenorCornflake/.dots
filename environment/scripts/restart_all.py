import os

# Reload neovim
os.system('python ~/environment/scripts/execute_command_for_all_neovim_instances.py ":luafile ~/.config/nvim/init.lua" &')

# Reload awesomewm
os.system('awesome-client "require(\'CONFIG.session\').restart()" &')

# Reload xsettingsd
os.system('killall xsettingsd')
os.system('xsettingsd &')
