#!/usr/bin/env bash

set -e

pushd ~/.dotfiles
home-manager switch --flake "./#work"
popd
