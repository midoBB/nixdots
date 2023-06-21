{pkgs, ...}: let
  bar = ''
    [bar/mainbar]
    monitor = ''${env:MONITOR}
    width = 100%
    height = 32
    radius = 6.0
    fixed-center = false
    enable-ipc = true
    background = ''${colors.background}
    foreground = ''${colors.foreground}
    border-size = 0
    border-color = ''${colors.background}
    padding-left = 2
    padding-right = 1
    module-margin = 4
    separator = %{F#A4A4A4}|%{F-}
    font-0 = SF Pro Display:style=Bold:pixelsize=10;2
    font-1 = JetBrains Mono NL:style=Regular:pixelsize=10;2
    font-2 = Noto Color Emoji:fontformat=truetype:scale=10:antialias=false;2
    font-3 = MesloLGS NF:style=Regular:pixelsize=10;2
    modules-left = i3
    modules-center = wmclass mpris
    modules-right = backlight-acpi pulseaudio wlan battery date powermenu
    tray-position = right
    tray-padding = 1
    scroll-up = #i3.next
    scroll-down = #i3.prev
    cursor-click = pointer
  '';
in
  bar
