{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    mountui.url = "github:AlanRandon/mountui";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      mountui,
      nixos-raspberrypi,
      ...
    }:
    let
      mkRpiNixosSystem =
        {
          system,
          modules,
        }:
        nixos-raspberrypi.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                # nixos-raspberrypi.overlays.pkgs

                # nixos-raspberrypi.overlays.bootloader
                # nixos-raspberrypi.overlays.vendor-kernel
                # nixos-raspberrypi.overlays.vendor-firmware
                # nixos-raspberrypi.overlays.kernel-and-firmware

                # nixos-raspberrypi.overlays.vendor-pkgs

                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                  };
                  custom = {
                    mountui = mountui.packages.${system}.default;
                  };
                })
              ];
            }
          ]
          ++ modules;
        };
      mkNixosSystem =
        {
          system,
          modules,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                  };
                  custom = {
                    mountui = mountui.packages.${system}.default;
                  };
                })
              ];
            }
          ]
          ++ modules;
        };
    in
    {
      nixosConfigurations = {
        karl = mkNixosSystem {
          system = "x86_64-linux";

          modules = [
            ./karl
            ./nixosModules
          ];
        };

        raspi = mkRpiNixosSystem {
          system = "aarch64-linux";

          modules = [
            ./raspi
            ./nixosModules
          ];
        };
      };
    };
}
