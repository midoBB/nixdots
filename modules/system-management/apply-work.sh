#!/usr/bin/env bash

set -e

pushd ~/.dotfiles
sudo nixos-rebuild switch --flake './#work'
popd
