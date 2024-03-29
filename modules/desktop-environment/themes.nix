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
    qogir-icon-theme
    qogir-kde
    qogir-theme
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
        theme=Qogir-dark-solid
      '';
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
      "smb://192.168.31.18/nas/Media Media"
    ];
  };
}
