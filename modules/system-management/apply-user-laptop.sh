#!/usr/bin/env bash

set -e

pushd ~/.dotfiles
home-manager switch --flake "./#mh@laptop"
popd
