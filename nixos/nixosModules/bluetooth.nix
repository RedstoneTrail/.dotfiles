{
  config,
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = [
      pkgs.bluetui
    ];

    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}
