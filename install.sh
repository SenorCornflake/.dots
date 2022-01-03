#!/usr/bin/env bash

pushd $DOT_ROOT/config


if [[ $1 == "system" || $1 == "all" ]]; then
	echo "Setting up system."
	sudo nixos-rebuild switch --flake .# --impure
fi


if [[ $1 == "home" || $1 == "all" ]]; then
	echo "Setting up home."
	nix build .#homeManagerConfigurations.a.activationPackage --impure 
	./result/activate
	rm -rf ./result
fi

popd
