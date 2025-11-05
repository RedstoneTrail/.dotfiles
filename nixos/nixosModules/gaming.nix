{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {
    allowed-unfree-packages = [
      "steam"
      "steam-unwrapped"
    ];

    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      lutris
    ];
  };
}
