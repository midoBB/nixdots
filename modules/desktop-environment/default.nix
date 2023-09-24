{
  pkgs,
  workMode,
  ...
}: {
  imports = [./dconf.nix ./themes.nix ./discord.nix];
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    udiskie = {
      enable = true;
      tray = "always";
    };
    kdeconnect.enable = !workMode;
    kdeconnect.indicator = true;
  };
  # Enable the X11 windowing system.
  home.packages = with pkgs; [
    # Busybox replacements: As the default ones give out very
    # limited info which is extremely unhelpful when debugging
    less
    pciutils
    procps
    psmisc
    # stress
    usbutils
    #brightness and sound control
    brightnessctl
    alsa-utils
    # File browser
    lxqt.pcmanfm-qt
    lxqt.lxqt-sudo
    ffmpegthumbnailer
    lxmenu-data
    shared-mime-info
    #Default terminal emulator for old stuff
    xterm
    # Image viewer
    feh
    qimgv
    #Mate utils
    mate.mate-utils
    mate.mate-tweak
    mate.mate-themes
    mate.mate-settings-daemon-wrapped
    mate.mate-power-manager
    mate.mate-polkit
    mate.mate-notification-daemon
    mate.mate-control-center
    mate.mate-screensaver
    mate.pluma

    # Openvpn interop
    gnome3.networkmanager-openvpn
    # Change resolution based on monitor setup
    autorandr
    #xorg utils
    xorg.xprop
    xorg.xkill
    xclip
    xsel
    xdotool
    # Sound control panel
    pavucontrol
    indicator-sound-switcher

    # System tray (Kind of a hack atm)
    # Need polybar to support this as a first class module
    networkmanagerapplet
    # nm-tray
    dex
    redshift
    #KDE connect
    libsForQt5.kdeconnect-kde
  ];

  xdg = {
    configFile."pcmanfm-qt/default/settings.conf".source = ./pcmanfm-qt.conf;
    configFile."touchegg/touchegg.conf".source = ./touchegg.conf;
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "x-scheme-handler/terminal" = "org.wezfurlong.wezterm.desktop";
        "x-scheme-handler/file" = "pcmanfm-qt.desktop";
        "x-directory/normal" = "pcmanfm-qt.desktop";
        "x-scheme-handler/mailto" = "thunderbird.desktop";
        "x-scheme-handler/mid" = "thunderbird.desktop";
      };
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
        "application/x-shellscript" = "nvim.desktop";
        "application/x-perl" = "nvim.desktop";
        "application/json" = "nvim.desktop";
        "text/x-readme" = "nvim.desktop";
        "text/plain" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/x-csrc" = "nvim.desktop";
        "text/x-chdr" = "nvim.desktop";
        "text/x-python" = "nvim.desktop";
        "text/x-tex" = "texstudio.desktop";
        "text/x-makefile" = "nvim.desktop";
        "inode/directory" = "pcmanfm-qt.desktop";
        "x-directory/normal" = "pcmanfm-qt.desktop";
        "x-scheme-handler/file" = "pcmanfm-qt.desktop";
        "x-scheme-handler/terminal" = "org.wezfurlong.wezterm.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "application/epub+zip" = "calibre-ebook-viewer.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/mailto" = "thunderbird.desktop";
        "x-scheme-handler/mid" = "thunderbird.desktop";
        "image/bmp" = "qimgv.desktop";
        "image/gif" = "qimgv.desktop";
        "image/jpeg" = "qimgv.desktop";
        "image/jp2" = "qimgv.desktop";
        "image/jpeg2000" = "qimgv.desktop";
        "image/jpx" = "qimgv.desktop";
        "image/png" = "qimgv.desktop";
        "image/svg" = "qimgv.desktop";
        "image/tiff" = "qimgv.desktop";
      };
    };
  };
}
