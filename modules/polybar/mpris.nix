{ pkgs, ... }:

let
  pctl = "${pkgs.playerctl}/bin/playerctl";
  grep = "${pkgs.gnugrep}/bin/grep";
  tr = "${pkgs.coreutils}/bin/tr";
in pkgs.writeShellScriptBin "mpris" ''
  ${pctl} --player=spotify,%any metadata --format '{{ artist }} - {{ title }}' 2>&1 | ${tr} -d '\n' | ${grep} -q "No players found" && echo "  " || echo -e "\uf1bc $(${pctl} --player=spotify,%any metadata --format '{{ artist }} - {{ title }}')"
''
