{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      recolor-lightcolor = "rgba(0,0,0,0)";
      default-bg = "rgba(0,0,0,0.7)";

      font = "SF Pro Display Regular 11";
      selection-notification = true;

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      zoom-min = "10";
    };

    extraConfig = "include catppuccin-mocha";
  };

  xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dracula/zathura/master/zathurarc";
    hash = "sha256-7qNQK104EW1/heux+DW3dUdfRcKdiUQEp+ktiVw60G4=";
  };
}
