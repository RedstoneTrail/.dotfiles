{
  pkgs,
  config,
  lib,
  nixos-raspberrypi,
  ...
}:
{
  imports = [
    # ./boot.nix
    ./fw-config.nix
  ]
  ++ (with nixos-raspberrypi.nixosModules.raspberry-pi-5; [
    base

    page-size-16k
    display-vc4

    bluetooth
  ]);

  config = {
    dotfiles =
      let
        enabled = {
          enable = true;
        };
        disabled = {
          enable = false;
        };
      in
      {
        android-tooling = disabled;
        bluetooth = disabled;
        cli = disabled;
        gaming = disabled;
        graphical = disabled;
        hardware-accessible = disabled;
        input = disabled;
        networking-control = disabled;
        school = disabled;
        ssh = disabled;
        tor = disabled;
        torrenting = disabled;
        virtualisation = disabled;
        vt-config = disabled;
        web = disabled;

        pihole = disabled;
        printing = disabled;
      };

    networking.hostName = "raspi";
    system.stateVersion = "25.11";

    boot = {
      loader.raspberry-pi.bootloader = "kernel";
      tmp.useTmpfs = true;
    };

    users.users.redstonetrail = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "network"
        "networkmanager"
        "uinput"
        # ]
        # ++ lib.mkIf config.dotfiles.pihole.enabled [
        #   "docker"
      ];
      initialHashedPassword = "";
      # initialHashedPassword = "$y$j9T$rQ1v1g1IaFIJ6P7UHWsJ91$LjP8EG33DaUg9DTwbU8gbV6/eY4TB/SgUvRMvAphWFD";

      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;

    # joinked from github.com/nvmd/nixos-raspberrypi-demo
    services.udev.extraRules = ''
      # Ignore partitions with "Required Partition" GPT partition attribute
      # On our RPis this is firmware (/boot/firmware) partition
      ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
        ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
        ENV{UDISKS_IGNORE}="1"
    '';

    nixpkgs.flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };

    # hardware.raspberry-pi.config.all.base-dt-params = {
    #   pciex1 = {
    #     enable = true;
    #     value = "on";
    #   };

    #   pciex1_gen = {
    #     enable = true;
    #     value = "3";
    #   };
    # };
  };
}
