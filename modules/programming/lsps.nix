{
  pkgs-unstable,
  pkgs,
  ...
}: {
  home.packages = with pkgs-unstable; [
    #Mardown and stuff
    vale # linter for prose
    proselint # ditto
    markdownlint-cli2
    ltex-ls
    #Nix
    nil # nix lsp -- better than rnix?
    alejandra # nix formatter alternative
    statix # linter for nix
    #Bash
    shellcheck
    python311Packages.beautysh
    nodePackages.bash-language-server
    #Lua
    lua-language-server
    stylua
    # Python
    black
    python310Packages.python-lsp-server
    python310Packages.pylsp-rope
    python310Packages.python-lsp-ruff
    python310Packages.ruff-lsp
    ruff
    #Docker
    pkgs.hadolint
    nodePackages.dockerfile-language-server-nodejs
    #golang
    gopls
    go-tools
    gofumpt
    delve
    golangci-lint
    gotests
    reftools
    gomodifytags
    iferr
    # SQL
    sqls
    sqlfluff
    # Protobuf
    protolint
    buf-language-server
    # YAML
    nodePackages.yaml-language-server
    yamllint
    # Json
    jq
    #XML
    html-tidy
    libxml2
    /*
    WEB Dev
    */
    #Svelte
    nodePackages.svelte-language-server
    #Prisma
    prisma-engines # ditto for schema.prisma files
    nodePackages."@tailwindcss/language-server"
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier_d_slim
    nodePackages.eslint_d
    nodePackages.typescript-language-server
    # Clojure
    clj-kondo
    clojure-lsp
    #Generate types for any language from json
    nodePackages_latest.quicktype
  ];
}
