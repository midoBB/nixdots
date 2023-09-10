{pkgs-unstable, ...}: {
  home.packages = with pkgs-unstable; [
    vale # linter for prose
    proselint # ditto
    luaformatter # ditto for lua
    prisma-engines # ditto for schema.prisma files
    nil # nix lsp -- better than rnix?
    alejandra # nix formatter alternative
    statix # linter for nix
    shellcheck
    lua-language-server
    nodePackages.svelte-language-server
    black
    python310Packages.python-lsp-server # todo: is specifying 310 an issue?
    nodePackages.bash-language-server
    shellcheck
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
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier_d_slim
    nodePackages.eslint_d
    nodePackages.typescript-language-server
    nodePackages.markdownlint-cli
    sqls
    sqlfluff
    jq
    haskell-language-server
    # YAML
    nodePackages.yaml-language-server
    yamllint
    #Kotlin
    kotlin-language-server
    ktlint
    kotlin
  ];
}
