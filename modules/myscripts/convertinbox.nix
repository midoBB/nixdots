{
  pkgs,
  workMode,
  ...
}: let
  convertinbox = pkgs.writeScriptBin "convertinbox" ''
    #!/usr/bin/env bash
    cd "$(dirname "$HOME/Drive/Documents/0-Inbox/output/")" || exit
    parallel --tag -j 2 ocrmypdf '{}' 'output/{}' --clean --clean-final -l fra ::: *.pdf
  '';
in {
  home.packages =
    if workMode
    then []
    else [
      convertinbox
      pkgs.coreutils
      # tools needed for my ocr setup
      pkgs.ocrmypdf
      pkgs.tesseract4
      pkgs.jbig2enc
      pkgs.parallel
    ];
}
