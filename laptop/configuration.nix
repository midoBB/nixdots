# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  # Get me proprietary packages
  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      # Bootloader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["i2c-dev" "i2c-piix4" "kvm-amd"];
    initrd.kernelModules = ["amdgpu"];
    initrd.systemd.enable = true;
    kernelParams = ["quiet"];
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # https://github.com/NixOS/nixpkgs/issues/124215
    settings.extra-sandbox-paths = ["/bin/sh=${pkgs.bash}/bin/sh"];
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
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
  time.timeZone = "Africa/Tunis";

  # Some programs need SUID wrappers, can be configured further or are

  powerManagement.powertop.enable = true;
  # List services that you want to enable:
  services = {
    printing.enable = true;
    xserver = {
      layout = "fr"; # XServer keyboard layout
      enable = true;
      libinput = {
        # Needed for all input devices
        enable = true;
      };
    };
    blueman.enable = true; # Bluetooth
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
    auto-cpufreq.enable = true;

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    ''; #INFO: Needed for polybar to be able to control brightness
  };

  # Enable sound.
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mh = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
      "video"
      "audio"
      "camera"
      "networkmanager"
      "lp"
      "lpadmin"
      "docker"
      "libvirt"
      "scanner"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  environment = {
    # List packages installed in system profile. To search, run:
    systemPackages = with pkgs; [wget curl git];
    pathsToLink = ["/libexec" "/share/zsh"];
    shells = with pkgs; [zsh];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
}
