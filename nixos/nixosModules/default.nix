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
    ./school.nix
    ./tor.nix
    ./virtualisation.nix
    ./vt.nix
    ./wm.nix
  ];

  config.specialisation = {
    # default state is integrated graphics only
    # this specialisation provides dedicated graphics support
    hybrid-graphics = {
      inheritParentConfig = true;
      configuration = {
        imports = [
          ../karl/nvidia.nix
        ];
      };
    };
  };
}
