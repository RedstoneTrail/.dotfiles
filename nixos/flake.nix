{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    mountui = {
      url = "github:AlanRandon/mountui";
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
          ./karl
          ./nixosModules
        ];
      };
    };
}
