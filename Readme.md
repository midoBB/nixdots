# `dotfiles`

Here lies the `dotfiles` crafted with much care

## Configuration

A glance at what is present in this lair.

| Name                     | What I am using (NixOS)                                                  |
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

Here is a walkthrough of what are the steps one need to take to get this config
or parts of it setup on any system.

### User config setup

#### Requirements

- nix with flake support is available

#### Steps

- Get contents of this repo onto your system to `~/.dotfiles`
- `cd` into `~/.dotfiles`
- Execute: `nix run home-manager --no-write-lock-file -- switch --flake "./#nixos"`

### Full Setup of NixOS (first time)

#### Requirements

- Some way to install NixOS
- Ability to connect to the internet
- Boot drive with label `NIXBOOT`
- Root drive where the OS will go `NIXROOT`
- Swap partition `NIXSWAP`

#### Steps

- Install NixOS
  - Make sure you have a way to get this repo. `curl`, `git`, etc.
  - Make sure you enable internet
- Get contents of this repo onto your system to `~/.dotfiles`
- `cd` into `~/.dotfiles`
- Execute: `sudo nixos-rebuild switch --flake './#nixos'`
- Execute: `nix run home-manager --no-write-lock-file -- switch --flake "./#nixos"`
