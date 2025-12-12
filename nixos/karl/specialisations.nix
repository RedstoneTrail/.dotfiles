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
            ../karl/nvidia.nix
          ];
        };
      };
    };
    system.nixos.tags = if (config.specialisation != { }) then [ "default" ] else [ "hybrid-graphics" ];

    environment.etc = {
      "redstonetrail/specialisation".text =
        if (config.specialisation != { }) then
          ''
            default
          ''
        else
          ''
            hybrid-graphics
          '';
    };

    # disable all usb power management if in hybrid-graphics specialisation
    powerManagement.powertop.postStart =
      if (config.specialisation != { }) then
        ''''
      else
        ''for i in /sys/bus/usb/devices/*/power/control; do /bin/sh -c "echo on > $i"; done'';

    environment.systemPackages =
      if (config.specialisation != { }) then
        [
          pkgs.nvtopPackages.intel
        ]
      else
        [
          pkgs.nvtopPackages.full
        ];
  };
}
