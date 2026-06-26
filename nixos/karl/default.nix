{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./intel.nix
    ./specialisations.nix
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
        android-tooling = enabled;
        bluetooth = enabled;
        cli = enabled;
        gaming = enabled;
        graphical = enabled;
        hardware-accessible = enabled;
        input = enabled;
        networking-control = enabled;
        rclone = enabled;
        school = enabled;
        ssh = enabled;
        tor = enabled;
        torrenting = enabled;
        virtualisation = enabled;
        vt-config = enabled;
        web = enabled;

        pihole = disabled;
        printing = disabled;
      };

    networking.hostName = "karl";
    system.stateVersion = "25.05";
  };
}
