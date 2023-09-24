{pkgs, ...}: let
  fd.sh = pkgs.writeScriptBin "fd.sh" ''
    #!/usr/bin/env bash
    file_to_open=$(fd . ~ --type directory | fzf)
    setsid --fork xdg-open "$file_to_open" > /dev/null 2>&1
  '';
in {
  home.packages = [fd.sh pkgs.util-linux pkgs.fzf pkgs.fd pkgs.xdg-utils];
}
