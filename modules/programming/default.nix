{
  config,
  pkgs,
  pkgs-unstable,
  workMode,
  ...
}: let
  inherit (pkgs.callPackage ./java.nix {}) graalvm21-ce;
in {
  imports = [./lsps.nix];
  programs.go = {
    #I hate the default go folder
    enable = true;
    package =
      if workMode
      then pkgs.go_1_18
      else pkgs-unstable.go;
    goBin = ".go/bin";
    goPath = ".go";
  };
  programs.java = {
    enable = true;
    package = graalvm21-ce;
  };
  home.sessionPath = [config.home.sessionVariables.GOBIN];
  home.packages = with pkgs;
    [
      # C
      gcc
      # docker
      docker
      # JavaScript
      nodejs_18
      yarn
      corepack
      # python
      (python3.withPackages (ps: with ps; [setuptools pip debugpy virtualenv beautifulsoup4 requests lxml]))
      python3Packages.ipython
      poetry
      #  rust
      # cargo
      # perl # this is required by rust
      # rustc
    ]
    ++ (
      if workMode
      then [
        # go_1_18
        adoptopenjdk-hotspot-bin-15
        postgresql_12
        protobuf
        postgresql12Packages.postgis
        rabbitmq-server
        redis
        protoc-gen-go
        grpcui
        gitflow
      ]
      else [
        # lua
        lua
        leiningen
        clojure
        exercism
        # elixir
        # erlangR25
        # elixir_1_14
        # libnotify
        # inotify-tools
        # go
        # go
        # golangci-lint
        # SICP
        #racket
      ]
    );
}
