{
  config,
  lib,
  ...
}:
{
  options.allowed-unfree-packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };

  config.nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.allowed-unfree-packages;

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./cli.nix
    ./firefox.nix
    ./gaming.nix
    ./networking.nix
    ./nixosSupport.nix
    ./school.nix
    ./tor.nix
    ./virtualisation.nix
    ./vt.nix
    ./wm.nix
  ];
}
