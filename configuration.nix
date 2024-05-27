# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
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

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.redstonetrail = {
    isNormalUser = true;
    description = "Joe Bearchell";
    extraGroups = [ "networkmanager" "wheel" "%wheel" "video" ];
    packages = with pkgs; [];
    uid = 1000;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow electron-25.9.0
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

 # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	pulseaudio
	wl-clipboard
	neovim
	firefox
	tmux
	git
	zig
	mako
	pulseaudio-ctl
	waybar
	alacritty
	wev
	brightnessctl
	steam-run
	htop
	minecraft
	jre8
	xwayland
	sway-launcher-desktop
	fuse
	lshw
	glxinfo
	neofetch
	pipewire
	yuzu-mainline
	xdg-utils
	r2modman
	libGL
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # gnome thing i will try to understand later
  services.gnome.gnome-keyring.enable = true;

  # Steam?
  programs.steam.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];

  # Be able to read NTFS filesystems e.g. windows partition
  boot.supportedFilesystems = ["ntfs"];

  # Mount windows partition as /windows
  fileSystems."/windows" =
    { device  = "/dev/nvme0n1p3";
      fsType  = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  # Epic bluetooth moment
  hardware.bluetooth.enable      = true;
  hardware.bluetooth.powerOnBoot = true;

  # love nvidia, love closed source, love proprietary --my-next-gpu-wont-be-nvidia
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = [ "nvidia" ]; 

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  hardware.opengl = {
    enable = true;
  };

  # swaywm things (regret trying hyprland not worth it due to laziness)
  programs.sway.enable = true;
 }
