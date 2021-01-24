import os
import sys

if len(sys.argv) > 2:
    backend = sys.argv[1]
    type = sys.argv[2]
    picture = sys.argv[3]

    # Use schemer2 with autobase16theme
    os.system('schemer2 -format img::colors -in {} -out ~/environment/cache/colors.txt && python ~/environment/scripts/auto-base16-theme/AutoBase16Theme.py --inputColorPaletteFile ~/environment/cache/colors.txt ~/environment/scripts/auto-base16-theme/templates/base16-template.yaml ~/environment/base16/schemes/schemer2/schemer2.yaml'.format(picture))

    # Use flavours
    os.system('flavours generate {} "{}" --stdout > ~/environment/base16/schemes/flavours/flavours.yaml'.format(type, picture))

    # Build the generated and 
    os.system('base16-builder build --scheme ~/environment/base16/schemes/schemer2/schemer2.yaml --template ~/environment/base16/templates/alacritty --output-root ~/environment/themes/alacritty')
    os.system('base16-builder build --scheme ~/environment/base16/schemes/schemer2/schemer2.yaml --template ~/environment/base16/templates/vim --output-root ~/.local/share/nvim/site/pack/packer/start/vim-base16-colorschemes/colors')

    os.system('base16-builder build --scheme ~/environment/base16/schemes/flavours/flavours.yaml --template ~/environment/base16/templates/alacritty --output-root ~/environment/themes/alacritty')
    os.system('base16-builder build --scheme ~/environment/base16/schemes/flavours/flavours.yaml --template ~/environment/base16/templates/vim --output-root ~/.local/share/nvim/site/pack/packer/start/vim-base16-colorschemes/colors')

    os.system('exconman -r ~/environment/registry.json set awesome.general.wallpaper \"{}\"'.format(picture))

    if backend == "flavours":
        os.system('python ~/environment/scripts/setup_base16_theme.py ~/environment/base16/schemes/flavours/flavours.yaml')
    elif backend == "schemer2":
        os.system('python ~/environment/scripts/setup_base16_theme.py ~/environment/base16/schemes/schemer2/schemer2.yaml')
