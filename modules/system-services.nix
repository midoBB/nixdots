{pkgs, ...}: {
  boot.plymouth.enable = true;
  programs.dconf.enable = true;
  console.keyMap = "fr";
  # Lock the system when going into a sleep mode
  systemd.services.screenlocker = {
    enable = true;
    description = "Make extra sure to lock the screen when suspending";
    unitConfig = {
      Type = "oneshot";
      User = "root";
    };
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/bin/loginctl lock-sessions";
    };
    wantedBy = ["suspend.target"];
  };
  programs.seahorse.enable = true;
  security = {
    # User does not need to give password when using sudo.
    sudo.wheelNeedsPassword = false; # I hate having to enter sudo password
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (subject.isInGroup("wheel")) {
      	return polkit.Result.YES;
          }
      });
    ''; # Removes the need to enter passwords for graphical needs
    pam.services.lightdm.enableGnomeKeyring = true;
  };
  environment.systemPackages = with pkgs; [
    vim
    gnome.dconf-editor
    python3Full
    sqlite
    cachix
    ansible
  ];
  environment.mate.excludePackages = with pkgs; [
    mate.pluma
    mate.mate-notification-daemon
  ];
  # Themes for QT apps. Doesn't work in home manager config
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  services = {
    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };
    xserver = {
      desktopManager = {mate.enable = true;};
      displayManager.lightdm.background = ./wallpapers/files/nix-wallpaper-stripes-logo.png;
      displayManager.defaultSession = "mate";
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      # windowManager.xmonad = {
      #   enable = true;
      #   enableContribAndExtras = true;
      # };
    };
    xbanish.enable = true; # Hide cursor when typing
    # These are needed for PCman FM and for distant shares
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    touchegg.enable = true;
  };
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
    portal = {enable = true;};
  };
  fonts.fonts = with pkgs; [
    # Fonts
    vistafonts
    jetbrains-mono
    helvetica-neue-lt-std
    meslo-lgs-nf
    corefonts # MS
    font-awesome
    font-awesome_5
    (nerdfonts.override {
      fonts = ["NerdFontsSymbolsOnly" "Hack"];
    })
  ];
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      experimental-features = ["nix-command" "flakes"]; # enable nix command and flakes
      trusted-users = ["root" "mh"];
      substituters = ["https://nix-community.cachix.org" "https://midobbdots.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "midobbdots.cachix.org-1:LrxKMSxUgZaR7t7PWz3+sKwgxnhanbmv/rAL9RMS8II="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # KDE connect shit
  networking.firewall = {
    enable = false;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
