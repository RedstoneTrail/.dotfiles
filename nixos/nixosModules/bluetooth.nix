{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dotfiles.bluetooth;
in
{
  config = lib.mkIf cfg.enable {
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
