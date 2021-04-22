import os
import sys

if len(sys.argv) > 2:
    backend = sys.argv[1]
    type = sys.argv[2]
    picture = sys.argv[3]

    # Use schemer2 with autobase16theme
    os.system('schemer2 -maxBright 200 -format img::colors -in {} -out ~/environment/cache/colors.txt && python ~/environment/scripts/auto-base16-theme/AutoBase16Theme.py --inputColorPaletteFile ~/environment/cache/colors.txt ~/environment/scripts/auto-base16-theme/templates/base16-template.yaml ~/environment/base16/schemes/schemer2/schemer2.yaml'.format(picture))

    # Use flavours
    os.system('flavours generate {} "{}" --stdout > ~/environment/base16/schemes/flavours/flavours.yaml'.format(type, picture))

    os.system('exconman set awesome.general.wallpaper \"{}\"'.format(picture))

    # Enables shadows
    os.system('exconman set picom.shadow true')


    if backend == "flavours":
        os.system('python ~/environment/scripts/setup_base16_theme.py ~/environment/base16/schemes/flavours/flavours.yaml true')
    elif backend == "schemer2":
        os.system('python ~/environment/scripts/setup_base16_theme.py ~/environment/base16/schemes/schemer2/schemer2.yaml true')
