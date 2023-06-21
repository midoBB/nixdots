{pkgs-unstable, ...}: {
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs-unstable.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs-unstable.vimPlugins.lazy-nvim
    ];
  };
  home.packages = with pkgs-unstable; [
    # pkgs.mynvim
    vale # linter for prose
    proselint # ditto
    luaformatter # ditto for lua
    prisma-engines # ditto for schema.prisma files
    nil # nix lsp -- better than rnix?
    alejandra # nix formatter alternative
    statix # linter for nix
    shellcheck
    pkgs-unstable.lua-language-server
    nodePackages.svelte-language-server
    black
    python310Packages.python-lsp-server # todo: is specifying 310 an issue?
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    hadolint
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
    pkgs-unstable.docker-compose-language-service
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
    elixir-ls
    fzy
  ];
  xdg.configFile."nvim/init.lua".source = ./init.lua;
}
