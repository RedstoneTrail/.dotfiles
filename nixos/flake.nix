{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    mountui = {
      url = "github:AlanRandon/mountui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
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
          # ./karl/nvidia.nix
          ./karl/intel.nix
        ];
      };
    };
}
