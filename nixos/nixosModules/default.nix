{
  config,
  lib,
  ...
}:
{
  options.allowed-unfree-packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };

  config.nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) config.allowed-unfree-packages;

  imports = [
    ./base.nix
    ./boot.nix
    ./cli.nix
    ./firefox.nix
    ./school.nix
    ./steam.nix
    ./vt.nix
    ./wm.nix
  ];
}
