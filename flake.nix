{
  description = "Home manager flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    ffplug.url = "github:midoBB/myFirefoxPlugins";
  };
  outputs = { self, nur, nixpkgs, nixpkgs-unstable, nixpkgs-master, home-manager
    , ffplug, }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      mkPkgs = pkgs: extraOverlays:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = extraOverlays;
        };
      master = mkPkgs nixpkgs-master [ ];
      home-common = { lib, ... }: {
        _module.args = {
          colorscheme = import ./colorschemes/tokyonight.nix;
          username = "mh";
        };
        nixpkgs.config = {
          allowUnfree = true;
          allowUnfreePredicate = pkg: true;
          permittedInsecurePackages = [ "openssl-1.1.1u" "electron-21.4.0" ];
        };

        nixpkgs.overlays = [
          (_: _: { myff = ffplug.packages.x86_64-linux; })
          nur.overlay
          (self: super: { inherit master; })
        ];

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
        home.stateVersion = "23.05";
        home.homeDirectory = "/home/mh";
        home.username = "mh";
        imports = [
          ./modules/wezterm
          ./modules/alacritty
          ./modules/neofetch
          ./modules/sioyek.nix
          ./modules/kitty.nix
          ./modules/wallpapers
          ./modules/bat
          ./modules/cli.nix
          ./modules/direnv
          ./modules/git
          ./modules/tmux
          ./modules/programming
          ./modules/zsh
          ./modules/flameshot.nix
          ./modules/nvim
          # Desktop Environment
          ./modules/desktop-environment
          ./modules/deadd
          ./modules/rofi
          ./modules/myscripts
          ./modules/i3
          # ./modules/xmonad
          ./modules/polybar
          ./modules/autorandr
          ./modules/fonts.nix
        ];
      };

      home-laptop = {
        _module.args.workMode = false;
        imports = [
          ./modules/picom
          ./modules/system-management
          ./modules/media.nix
          ./modules/graphical-tools.nix
          ./modules/firefox
        ];
      };
      home-work = {
        _module.args.workMode = true;
        imports = [
          ./modules/system-management
          ./modules/media.nix
          ./modules/graphical-tools.nix
        ];
      };
    in {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./laptop/configuration.nix ./modules/system-services.nix ];
      };

      nixosConfigurations.work = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./work/configuration.nix ./modules/system-services.nix ];
      };
      homeConfigurations = {
        laptop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ home-common home-laptop ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
        work = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ home-common home-work ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
