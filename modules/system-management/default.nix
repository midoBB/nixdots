{ pkgs, workMode, ... }:
let
  apply-system = if workMode then
    pkgs.writeScriptBin "apply-system" ''
      ${builtins.readFile ./apply-work.sh}
    ''
  else
    pkgs.writeScriptBin "apply-system" ''
      ${builtins.readFile ./apply-laptop.sh}
    '';

  apply-user-nixos = if workMode then
    pkgs.writeScriptBin "apply-user" ''
      ${builtins.readFile ./apply-user-work.sh}
    ''
  else
    pkgs.writeScriptBin "apply-user" ''
      ${builtins.readFile ./apply-user-laptop.sh}
    '';

  update-dots = pkgs.writeScriptBin "update-dots" ''
    ${builtins.readFile ./update-dots.sh}
  '';
  clean-sytem = pkgs.writeScriptBin "clean-system" ''
    ${builtins.readFile ./clean-system.sh}
  '';
in {
  home.packages = [ apply-system apply-user-nixos update-dots clean-sytem ];
}
