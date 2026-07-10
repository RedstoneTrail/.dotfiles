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
      pkgs.alsa-utils
    ];

    boot = {
      loader = {
        limine.secureBoot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      tmp.cleanOnBoot = true;
    };

    nix = {
      buildMachines = [
        {
          hostName = "karl";
          system = "x86_64-linux";
          protocol = "ssh-ng";
          maxJobs = 8;
          speedFactor = 2;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "big-parallel"
            "kvm"
          ];
          mandatoryFeatures = [ ];
        }
      ];
      distributedBuilds = true;
      extraOptions = ''
        builders-use-substitutes = true
      '';
    };
  };
}
