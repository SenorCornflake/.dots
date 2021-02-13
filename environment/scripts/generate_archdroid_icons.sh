#!/bin/bash
rm -r ~/.icons/archdroid
cp -r /opt/oomox/plugins/icons_archdroid/archdroid-icon-theme/archdroid-icon-theme ~/.icons/archdroid

find ~/.icons/archdroid/ -type f -exec sed -i \
	-e "s/CDDC39/${1}/g" \
	-e "s/Archdroid-Lime/archdroid/g" \
	{} \; ;
