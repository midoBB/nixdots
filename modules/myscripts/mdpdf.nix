{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-tetex
      fancyvrb
      newverbs
      geometry
      hyperref
      tcolorbox
      enumitem
      pdfcol
      framed
      xltxtra
      realscripts
      ;
  };
  mdpdf = pkgs.writeScriptBin "mdpdf" ''
    #!/usr/bin/env bash
    name=$(basename "$1" .md)
    path=$(dirname "$1")
    pandoc --pdf-engine=xelatex \
        --highlight-style tango \
        --include-in-header ~/.local/opt/mdpdf/head.tex \
        -V fontsize=10pt \
        -V colorlinks \
        -V toccolor=NavyBlue \
        -V linkcolor=red \
        -V urlcolor=teal \
        -V filecolor=magenta \
        -s \
        "$1" -o "$path/$name.pdf" && xdg-open "$path/$name.pdf"
  '';
in {
  home.packages = [
    mdpdf
    tex
    pkgs.coreutils
    pkgs.nur.repos.xeals.monaspace-argon
    pkgs.pandoc
    pkgs.fd
    pkgs.xdg-utils
  ];
  home.file = {".local/opt/mdpdf/head.tex".source = ./head.tex;};
}
