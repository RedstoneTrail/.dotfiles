{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        ./nixosModules/default.nix
	./karl/hardware-configuration.nix
	./karl/nvidia.nix
      ];
    };
  };
}
