{pkgs, ...}: let
  ff.sh = pkgs.writeScriptBin "ff.sh" ''
    #!/usr/bin/env bash
    file_to_open=$(fd . ~ --type file | peco)
    setsid --fork xdg-open "$file_to_open" > /dev/null 2>&1
  '';
in {
  xdg.configFile."peco/config.json".text = ''
    {
      "Style": {
        "Basic": ["on_default", "default"],
        "SavedSelection": ["bold", "on_yellow", "white"],
        "Selected": ["underline", "on_cyan", "black"],
        "Query": ["yellow", "bold"],
        "Matched": ["red", "on_white"]
      }
    }
  '';
  home.packages = [ff.sh pkgs.util-linux pkgs.peco pkgs.fd pkgs.xdg-utils];
}
