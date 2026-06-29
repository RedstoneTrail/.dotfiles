{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../nixosModules/limine.nix
    ../nixosModules/user.nix
  ];

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
        bluetooth = enabled;
        cli = enabled;
        graphical = enabled;
        hardware-accessible = enabled;
        input = enabled;
        networking-control = enabled;
        rclone = enabled;
        ssh = enabled;
        tor = enabled;
        torrenting = enabled;
        vt-config = enabled;
        web = enabled;

        android-tooling = disabled;
        gaming = disabled;
        pihole = disabled;
        printing = disabled;
        school = disabled;
        virtualisation = disabled;
      };

    system.stateVersion = "26.05";
    networking.hostName = "bosco";

    environment.systemPackages = [
      pkgs.prismlauncher
      pkgs.unstable.sbctl
    ];

    boot = {
      loader = {
        limine.secureBoot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      tmp.cleanOnBoot = true;
    };
  };
}
