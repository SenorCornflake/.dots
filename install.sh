#!/usr/bin/env bash

pushd $DOT_ROOT/config

if [[ $1 == "system" || $1 == "all" ]]; then
	sudo nixos-rebuild switch --flake .#slab --impure
fi

if [[ $1 == "home" || $1 == "all" ]]; then
	nix build .#homeManagerConfigurations.a.activationPackage --impure 
	./result/activate
	rm -rf ./result
fi

popd
