{
  pkgs,
  colorscheme,
  ...
}: let
  powermenu = pkgs.writeScriptBin "powermenu" ''
    ${builtins.readFile ./powermenu.sh}
  '';

  displayctl = pkgs.writeScriptBin "displayctl" ''
    ${builtins.readFile ./displayctl.sh}
  '';
in {
  home.packages = [powermenu displayctl];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "SF Pro Display Regular 11";
  };
  home.file.".config/rofi/colors.rasi".text = ''
    * {
      accent: ${colorscheme.accent-primary};
      accent-secondary: ${colorscheme.accent-secondary};
      background: ${colorscheme.bg-primary};
      foreground: ${colorscheme.fg-primary};
    }
  '';
  home.file.".config/rofi/grid.rasi".source = ./grid.rasi;
  home.file.".config/rofi/launcher.rasi".source = ./launcher.rasi;
  home.file.".config/rofi/powermenu.rasi".source = ./powermenu.rasi;
  home.file.".config/rofi/kde_launcher.rasi".source = ./kde_launcher.rasi;
}
