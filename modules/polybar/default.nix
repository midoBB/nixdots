{pkgs, ...}: let
  mainBar = pkgs.callPackage ./bar.nix {};

  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    mpdSupport = true;
    pulseSupport = true;
    iwSupport = true;
    i3Support = true;
  };

  colors = builtins.readFile ./colors.ini;
  mods1 = builtins.readFile ./modules.ini;

  mprisScript = pkgs.callPackage ./mpris.nix {};
  wmclasserScript = pkgs.callPackage ./wmclasser.nix {};
  startScript = pkgs.callPackage ./start.nix {};

  mpris = ''
    [module/mpris]
    type = custom/script
    exec = ${mprisScript}/bin/mpris
    tail = true
    label-maxlen = 60
    interval = 5
    format = <label>
    format-padding = 2
  '';

  wmclasser = ''
    [module/wmclass]
    type = custom/script
    exec = ${wmclasserScript}/bin/wmclasser
    label-maxlen = 60
    tail = true
    format-padding = 2
    module-margin = 12
    interval = 5
    format = <label>
  '';

  # xmonad = ''
  #   [module/xmonad]
  #   type = custom/script
  #   exec = ${pkgs.xmonad-log}/bin/xmonad-log
  #   tail = true
  # '';
  customMods =
    mainBar + mpris + wmclasser
    /*
    + xmonad
    */
    ;
in {
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    twitter-color-emoji # emoji font
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;
    extraConfig = colors + mods1 + customMods;
    # polybar top -l trace (or info) for debugging purposes
    script = "${startScript}/bin/starter";
  };
}
