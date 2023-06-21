{
  pkgs,
  colorscheme,
  username,
  ...
}: {
  home.packages = with pkgs; [
    lxappearance
    libsForQt5.qtstyleplugin-kvantum
    qt5ct
    xdg-utils
    dracula-theme
    moka-icon-theme
    numix-icon-theme-square
    whitesur-icon-theme
    palenight-theme
    materia-theme
    materia-kde-theme
    qogir-icon-theme
  ];
  # Settings for QT/Kde theme

  systemd.user.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  xdg.configFile = {
    "qt5ct/qt5ct.conf" = {
      text = ''
        [Appearance]
        custom_palette=false
        icon_theme=Qogir-dark
        standard_dialogs=gtk3
        style=kvantum
      '';
    };
    "Kvantum/kvantum.kvconfig" = {
      text = ''
        [General]
        theme=${colorscheme.qt-theme}
      '';
    };
  };
  fonts.fontconfig.enable = true;
  xresources = {
    properties = {
      "*.foreground" = colorscheme.fg-primary;
      "*.background" = colorscheme.bg-primary;

      "*.color0" = colorscheme.black;
      "*.color1" = colorscheme.red;
      "*.color2" = colorscheme.green;
      "*.color3" = colorscheme.yellow;
      "*.color4" = colorscheme.blue;
      "*.color5" = colorscheme.magenta;
      "*.color6" = colorscheme.cyan;
      "*.color7" = colorscheme.white;

      "*.color8" = colorscheme.bright-black;
      "*.color9" = colorscheme.bright-red;
      "*.color10" = colorscheme.bright-green;
      "*.color11" = colorscheme.bright-yellow;
      "*.color12" = colorscheme.bright-blue;
      "*.color13" = colorscheme.bright-magenta;
      "*.color14" = colorscheme.bright-cyan;
      "*.color15" = colorscheme.bright-white;

      "XTerm*font" = "xft:Hack Nerd Font Mono:pixelsize=12";
      "*.internalBorder" = 4;

      "Xft.antialias" = true;
      "Xft.hinting" = true;
      "Xft.rgba" = "rgb";
      "Xft.autohint" = false;
      "Xft.hintstyle" = "hintslight";
      "Xft.lcdfilter" = "lcddefault";
    };
  };
  gtk = {
    enable = true;
    font = {
      name = "SF Pro Display Regular 11";
      package = pkgs.nur.repos.sagikazarmark.sf-pro;
    };
    iconTheme = {name = colorscheme.gtk-icon-name;};
    cursorTheme = {name = colorscheme.gtk-cursor-name;};
    theme = {name = colorscheme.gtk-name;};
    gtk3.bookmarks = [
      "file:///home/${username}/Drive/Documents Documents"
      "file:///home/${username}/Drive/Music Music"
      "file:///home/${username}/Drive/Pictures Pictures"
      "file:///home/${username}/Videos Videos"
      "file:///home/${username}/Downloads Downloads"
      "file:///home/${username}/Courses Courses"
      "file:///home/${username}/Workspace Workspace"
      "file:///home/${username}/Drive Drive"
      "smb://192.168.1.99/nas/Media Media"
    ];
  };
}
