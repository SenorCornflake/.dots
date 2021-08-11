#!/usr/bin/env bash
notify-send "Generating Icons"
rm -rf ~/.icons/archdroid
cp -r ~/$DOTFILES_BRAIN_ROOT/icons/Archdroid-Lime ~/.icons/archdroid

find ~/.icons/archdroid/ -type f -exec sed -i \
	-e "s/CDDC39/${1}/g" \
	-e "s/Archdroid-Lime/archdroid/g" \
	{} \; ;

notify-send "Done!"
