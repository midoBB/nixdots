#!/bin/sh

# Remove all docker shit
docker system prune -a --volumes

# Remove old logs
sudo journalctl --vacuum-time=2d

# Get rid of stuff older than 2 days
sudo nix-garbage-collect --delete-older-than 2d
nix-store --optimize
