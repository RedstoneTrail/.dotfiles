{
  config,
  pkgs,
  ...
}:
{
  config = {
    specialisation = {
      # default state is integrated graphics only
      # this specialisation provides dedicated graphics support
      hybrid-graphics = {
        inheritParentConfig = true;
        configuration = {
          imports = [
            ./specialisations/hybrid-graphics.nix
          ];
        };
      };
      # this specialisation provides pci passthrough on:
      # the dedicated gpu - for general vm uses (inc. below)
      # the windows ssd - for running the windows installation as a vm
      vfio-maxxing = {
        inheritParentConfig = true;
        configuration = {
          imports = [
            ./specialisations/vfio-maxxing.nix
          ];
        };
      };
    };

    environment.systemPackages = pkgs.lib.mkIf (config.specialisation != { }) [
      pkgs.nvtopPackages.intel
      pkgs.btop
    ];

    # system.nixos.tags = [ config.specialisation ];

    system.nixos.tags = if (config.specialisation != { }) then [ "default" ] else [ ];
  };
}
