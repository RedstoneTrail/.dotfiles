{
  pkgs,
  lib,
  config,
  ...
}:
{
  config.allowed-unfree-packages = [
    "steam"
    "steam-unwrapped"
  ];

  config.programs.steam.enable = true;
}
