{
  pkgs,
  colorscheme,
  ...
}:
/*
let
*/
/*
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
*/
/*
in
*/
{
  home.packages = with pkgs; [
    # iosevka-ss08-term
    victor-mono
    input-fonts
    # iosevka-ss08
    pkgs.nur.repos.sagikazarmark.sf-pro
    pkgs.nur.repos.xeals.monaspace-argon
    pkgs.nur.repos.xeals.monaspace-krypton
    pkgs.nur.repos.xeals.monaspace-radon

    source-code-pro
    cantarell-fonts
  ];
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
}
