{
  pkgs-unstable,
  pkgs,
  ...
}: {
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = true;
    withNodeJs = true;
    /*
       plugins = [
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
          p.astro
          p.bash
          p.c
          p.cpp
          p.clojure
          p.diff
          p.dockerfile
          p.gitcommit
          p.gitignore
          p.go
          p.gomod
          p.gosum
          p.haskell
          p.html
          p.java
          p.javascript
          p.json
          p.kotlin
          p.latex
          p.lua
          p.markdown
          p.markdown-inline
          p.nix
          p.prisma
          p.proto
          p.python
          p.regex
          p.ruby
          p.scala
          p.sql
          p.svelte
          p.toml
          p.tsx
          p.typescript
        ]))
        pkgs.vimPlugins.lazy-nvim
    ];
    */
  };
  home.packages = with pkgs-unstable; [
    # pkgs.mynvim
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
    # hadolint
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
    fzy
  ];
  # xdg.configFile."nvim/init.lua".source = ./init.lua;
}
