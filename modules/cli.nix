{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI tools / Terminal facification
    docker-compose
    ngrok
    nix-du
    unrar
    unzip
    tree
    # Searching/Movement helpers
    ripgrep
    zoxide
    # system info
    btop
    # Nix itself
    nix
    doppler
    fd
    nixfmt
    zsh
    gh
    delta
    rsync
    just
    unzip
    zip
    git
    curl
    wget
    yt-dlp
    lazygit
    lazydocker
    pandoc
    wkhtmltopdf-bin
    peco
    duf
    du-dust
    lnav
    croc
    keychain
    pgcli
    mycli
    litecli

    httpie
    tokei
    # some sane alternatives to mv and rm
    rename
  ];
  # Use program without necessarily installing it prior
  programs.nix-index-database.comma.enable = true;
}
