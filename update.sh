#!/usr/bin/env bash
pushd ~/.dots/config
nix flake update --impure
popd
