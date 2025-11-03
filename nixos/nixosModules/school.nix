{
  pkgs,
  lib,
  ...
}:
{
  config.environment.systemPackages = with pkgs; [
    google-chrome
    zathura
  ];

  config.allowed-unfree-packages = [
    "google-chrome"
  ];
}
