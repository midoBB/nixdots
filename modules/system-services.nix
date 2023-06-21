{pkgs, ...}: 
let
  variants = {
    design = {
      tilde = "low";
      asterisk = "penta-low";
      underscore = "low";
      at = "fourfold";
      zero = "dotted";
      dollar = "open";
      percent = "dots";
      four = "semi-open-non-crossing";
    };
  };
  weights = {
    extralight = {
      shape = 200;
      menu = 200;
      css = 200;
    };
    regular = {
      shape = 400;
      menu = 400;
      css = 400;
    };
    bold = {
      shape = 700;
      menu = 700;
      css = 700;
    };
  };
  slopes = {
    upright = {
      angle = 0;
      shape = "upright";
      menu = "upright";
      css = "normal";
    };

    italic = {
      angle = 9.4;
      shape = "italic";
      menu = "italic";
      css = "italic";
    };
  };
  buildIosevka = pkgs.iosevka.override;
  iosevka-ss08 = buildIosevka {
    set = "ss08";
    privateBuildPlan = {
      family = "Iosevka";

      inherit variants weights slopes;
    };
  };
  iosevka-ss08-term = buildIosevka {
    set = "ss08-term";
    privateBuildPlan = {
      family = "Iosevka Term";
      spacing = "term";

      inherit variants weights slopes;
    };
  };
  nf-patch = font:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "${font.pname}-nerd-font-patched";
      version = font.version;

      src = font;

      nativeBuildInputs = [ pkgs.nerd-font-patcher ];

      buildPhase = ''
        mkdir -p $out
        find -name \*.ttf -exec nerd-font-patcher -o $out/share/fonts/truetype/ -c {} \;
      '';
      installPhase = "";
    };
in {
  boot.plymouth.enable = true;
  programs.dconf.enable = true;
  console.keyMap = "fr";

  services.dbus = {
    enable = true;
    packages = [pkgs.dconf];
  };
  services.xserver = {
    desktopManager = {
      mate.enable = true;
    };
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
  services.xbanish.enable = true; # Hide cursor when typing
  # These are needed for PCman FM and for distant shares
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
    portal = {enable = true;};
  };
  fonts.fonts = with pkgs; [
    # Fonts
    (nf-patch iosevka-ss08-term)
    iosevka-ss08
    vistafonts
    jetbrains-mono
    helvetica-neue-lt-std
    meslo-lgs-nf
    corefonts # MS
    font-awesome
    font-awesome_5
    source-code-pro
    cantarell-fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
        "Meslo"
        "Hack"
      ];
    })
  ];
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      experimental-features = ["nix-command" "flakes"]; # enable nix command and flakes
      trusted-users = ["root" "mh"];
      substituters = [
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
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
