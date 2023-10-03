{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.neovim = {
    package = pkgs.neovim-nightly;
    enable = true;
    withNodeJs = true;
  };
  home.packages = with pkgs-unstable; [
    vale # linter for prose
    proselint # ditto
    luaformatter # ditto for lua
    prisma-engines # ditto for schema.prisma files
    nil # nix lsp -- better than rnix?
    alejandra # nix formatter alternative
    shellcheck
    lua-language-server
    nodePackages.svelte-language-server
    black
    python310Packages.python-lsp-server # todo: is specifying 310 an issue?
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    pkgs.hadolint
    gopls
    reftools
    impl
    gotools
    delve
    golines
    golangci-lint
    nodePackages.diagnostic-languageserver
    nodePackages."@tailwindcss/language-server"
    nodePackages."@prisma/language-server"
    docker-compose-language-service
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier_d_slim
    nodePackages.eslint_d
    nodePackages.typescript-language-server
    nodePackages.markdownlint-cli
    deadnix
    sqls
    jq
    # YAML
    nodePackages.yaml-language-server
    yamllint
    fzy
  ];
  xdg.configFile."nvim" = {
   source = ./config;
   recursive = true;
  };
}
