{ config, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {
    config = { allowUnfree = true; };
  };
  pkgs2311 = import <nixos-23.11> {
    config = { allowUnfree = true; };
  };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader garbage, don't really know to be honest
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # My hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Europe/London";

  # Internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure to use actual keyboard layout (twice?)
  console.keyMap = "uk";

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Define me as a user (kind of important)
  users.users.redstonetrail = {
    isNormalUser = true;
    description = "Joe Bearchell";
    extraGroups = [ "networkmanager" "wheel" "%wheel" "video" ];
    packages = with pkgs; [ ];
    uid = 1000;
  };

  # Allow electron-25.9.0
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # My packages list
  environment.systemPackages = [

    # Basic utilities
    unstable.neovim
    pkgs.git
    pkgs.tmux
    pkgs.gh
    pkgs.zig
    pkgs.htop
    pkgs.brightnessctl
    pkgs.fuse
    pkgs.unzip
    pkgs.wget
    pkgs.xdg-utils
    pkgs.libGL
    pkgs.glow
    pkgs.lshw
    pkgs.lm_sensors
    pkgs.rustup
    pkgs.clang
    pkgs.zsh

    # Funny utilities
    pkgs.neofetch
    pkgs.lolcat
    pkgs.figlet

    # Window manager e.t.c.
    pkgs.pulseaudio
    pkgs.wl-clipboard
    pkgs.firefox
    pkgs.mako
    pkgs.pulseaudio-ctl
    pkgs.alacritty
    pkgs.wev
    pkgs.xwayland
    pkgs.glxinfo
    pkgs.pipewire
    pkgs.grim
    pkgs.slurp
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.sway-launcher-desktop
    pkgs.hyprcursor
    pkgs.hyprland

    # Gaming
    pkgs.steam-run
    pkgs2311.minecraft
    pkgs.jdk21
    pkgs.r2modman
    pkgs.prismlauncher

    # Emulation
    pkgs2311.yuzu-mainline
  ];

  system.stateVersion = "23.11";

  # GNOME keyring (for saved passwords or something)
  services.gnome.gnome-keyring.enable = true;

  # Steam
  programs.steam.enable = true;

  # Use Fira Mono Nerd Font, and we will use nothing else in my christian configuration.nix
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];

  # Be able to read NTFS filesystems e.g. my windows partition
  boot.supportedFilesystems = [ "ntfs" ];

  # Mount windows partition as /windows
  fileSystems."/windows" =
    {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  # Epic bluetooth moment
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # love nvidia, love closed source, love proprietary --my-next-gpu-wont-be-nvidia
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Kind of need OpenGL
  hardware.opengl = {
    enable = true;
  };

  # Enable hyprland
  programs.hyprland.enable = true;

  # Enable zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Delete unused stuff on rebuild and gc weekly (in case auto-optimise-store doesnt help much)
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Update kernel when new versions are available
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
