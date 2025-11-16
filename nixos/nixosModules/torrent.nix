{
  config,
  pkgs,
  ...
}:
{
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    settings = {
      download-dir = "${config.users.users.redstonetrail.home}/Downloads";
    };
  };
}
