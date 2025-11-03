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
	./karl/hardware-configuration.nix
	./karl/intel.nix
	./karl/nvidia.nix
        ./nixosModules/default.nix
      ];
    };
  };
}
