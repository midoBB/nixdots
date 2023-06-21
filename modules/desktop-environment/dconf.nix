{
  # home.file.".local/share/applications/xmonad.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Name=XMonad
  #   Exec=/usr/bin/xmonad
  #   NoDisplay=true
  #   X-GNOME-WMName=XMonad
  #   X-GNOME-Autostart-Phase=WindowManager
  #   X-GNOME-Provides=windowmanager
  #   X-GNOME-Autostart-Notify=true
  # '';
  # home.file.".config/autostart/xmonad.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Exec=xmonad --replace
  #   Hidden=false
  #   Name[en_US]=Xmonad
  #   Name=Xmonad
  #   Comment[en_US]=Should start xmonad
  #   Comment=Should start xmonad
  #   X-MATE-Autostart-Delay=0
  # '';
  dconf.settings = {
    "org/mate/desktop" = {
      "session/required-components/windowmanager" = "i3";
      "session/required-components-list" = ["windowmanager"];
      "background/show-desktop-icons" = false;
      "background/draw-background" = false;
      "peripherals/touchpad/tap-to-click" = true;
      "peripherals/touchpad/natural-scroll" = true;
      "peripherals/touchpad/two-finger-click" = 3;
      "peripherals/touchpad/vertical-two-finger-scrolling" = true;
      "peripherals/touchpad/horizontal-two-finger-scrolling" = true;
      "interface/font-name" = "SF Pro Display Regular 11";
      "interface/document-font-name" = "SF Pro Display Regular 11";
      "interface/monospace-font-name" = "MesloLGS Nerd Font Regular 13";
      "font-rendering/hinting" = "full";
      "interface/color-scheme" = "prefer-dark";
      "interface/icon-theme" = "Qogir-dark";
      "interface/gtk-theme" = "Materia-dark-compact";
      "peripherals/mouse/cursor-theme" = "Qogir-dark";
    };
  };
}
