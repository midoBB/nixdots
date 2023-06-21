# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
  };
  # Get me proprietary packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # https://github.com/NixOS/nixpkgs/issues/124215
    settings.extra-sandbox-paths = ["/bin/sh=${pkgs.bash}/bin/sh"];
  };

  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "work";
    networkmanager.enable = true;
    defaultGateway = "192.168.1.1";
    nameservers = ["1.1.1.1"]; # Cloudflare
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };
  time.timeZone = "Africa/Tunis"; # Time zone and internationalisation

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [wget curl git];
  environment.pathsToLink = ["/libexec" "/share/zsh"];

  # Some programs need SUID wrappers, can be configured further or are

  # List services that you want to enable:
  services = {
    xserver = {
      layout = "fr"; # XServer keyboard layout
      enable = true;
      libinput = {
        # Needed for all input devices
        enable = true;
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mh = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "camera" "networkmanager"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  services.spice-vdagentd.enable = true;
}
