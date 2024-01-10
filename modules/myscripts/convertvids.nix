{
  pkgs,
  workMode,
  ...
}: let
  convertvideos = pkgs.writeScriptBin "convertvideos" (builtins.readFile ./convertvids.bash);
in {
  home.packages =
    if workMode
    then []
    else [
      convertvideos
      pkgs.libva-utils
      pkgs.glxinfo
      pkgs.coreutils
      # tools needed for my ocr setup
      pkgs.ffmpeg
    ];
}
