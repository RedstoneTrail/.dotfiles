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
    ./android.nix
    ./bluetooth.nix
    ./cli.nix
    ./firefox.nix
    ./gaming.nix
    ./input.nix
    ./networking.nix
    ./nixosSupport.nix
    ./printing.nix
    ./school.nix
    ./tor.nix
    ./torrent.nix
    ./virtualisation.nix
    ./vt.nix
    ./wm.nix
  ];
}
