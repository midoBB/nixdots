# `dotfiles`

Here lies the `dotfiles` crafted with much care. Shamelessly stolen from [this repository](https://github.com/sherubthakur/dotfiles) then changed to fit my
needs.

## Configuration

A glance at what's present in this lair.

| Name                     | What we're am using (NixOS)                                                  |
| ------------------------ | ------------------------------------------------------------------------ |
| OS                       | [NixOS](https://nixos.org/)                                              |
| Terminal Emulator        | [Wezterm](https://wezfurlong.org/wezterm/)                               |
| Shell                    | [ZSH + ohmyzsh](https://ohmyz.sh/),                                      |
| Font                     | Custom Iosevka font                                                      |
| Editor                   | [Neovim](https://neovim.io/)                                             |
| Desktop Environment      | [I3](https://i3wm.org/),                                                 |
|                          | [Mate](https://mate-desktop.org/),                                       |
|                          | [Polybar](https://polybar.github.io),                                    |
|                          | [picom](https://github.com/yshui/picom),                                 |
|                          | [rofi](https://github.com/davatorium/rofi),                              |
|                          | [deadd](https://github.com/phuhl/linux_notification_center),             |
| Browser                  | [Firefox](https://www.mozilla.org/en-US/firefox/)                        |
| User environment manager | [Home Manager](https://nixos.wiki/wiki/Home_Manager)                     |

## Setup

Here is a walk through of what are the steps one need to take to get this configuration
or parts of it setup on any system.

### Full setup of NixOS (first time)

#### Requirements

- Some way to install NixOS
- Ability to connect to the internet
- Boot drive with label `NIXBOOT`
- Root drive where the OS will go `NIXROOT`
- Swap partition `NIXSWAP`

#### Steps

- Install NixOS
- Make sure you have a way to get this repository. `curl`, `git`, `ansible-vault`.
- Make sure you enable internet
- Get contents of this repository onto your system to `~/.dotfiles`
- `cd` into `~/.dotfiles`
- Decrypt the secrets
- Copy the secrets to the correct places
- Run system configuration
- Run home manager configuration
- After all said and done import treestyletab json to Firefox

```bash
  nix-shell -p curl git ansible gnutar
  git clone https://github.com/midoBB/nixdots.git
  mv nixdots ~/.dotfiles
  cd ~/.dotfiles
  echo 'password' > .vault
  ansible-vault decrypt .secrets/*
  mv .secrets/env .env
  tar xvf .secrets/ssh.tar.gz
  mv .secrets/.ssh ~/.ssh
  cp .secrets/configs-treestyletabs.json ~
  ansible-vault encrypt .secrets/*
  sudo nixos-rebuild switch --flake './#laptop'
  nix run home-manager --no-write-lock-file -- switch --flake "./#laptop"
  nvim --headless "+Lazy! sync" +qa
```

