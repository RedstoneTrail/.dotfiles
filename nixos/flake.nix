{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    mountui = {
      url = "github:AlanRandon/mountui";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      mountui,
      ...
    }:
    let
      mkNixosSystem =
        { system, modules }:
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
      nixosConfigurations.karl = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./nixosModules/default.nix
          ./karl/hardware-configuration.nix
          ./karl/intel.nix
          ./karl/specialisations.nix
          ./karl/boot.nix
        ];
      };
    };
}
