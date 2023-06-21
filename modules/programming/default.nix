{
  pkgs-unstable,
  pkgs,
  workMode,
  ...
}: {
  imports = [./lsps.nix];
  home.packages = with pkgs;
    [
      # C
      gcc
      #Java
      # docker
      docker
      # JavaScript
      pkgs-unstable.nodejs
      yarn
      nodePackages.pnpm
      # python
      (python3.withPackages (ps: with ps; [setuptools pip debugpy virtualenv beautifulsoup4 requests lxml]))
      autoflake
      python3Packages.ipython
      # rust
      cargo
      perl # this is required by rust
      rustc
    ]
    ++ (
      if workMode
      then [
        go_1_18
        adoptopenjdk-hotspot-bin-15
        postgresql_12
        protobuf
        postgresql12Packages.postgis
        rabbitmq-server
        redis
        protoc-gen-go
        grpcui
        gitflow
        vscode.fhs
      ]
      else [
        # lua
        lua
        #java
        temurin-bin
        #elixir
        erlangR25
        elixir_1_14
        libnotify
        inotify-tools
        # go
        go
        # golangci-lint
        # SICP
        #racket
      ]
    );
}
