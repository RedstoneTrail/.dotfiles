{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dotfiles.torrenting;
in
{
  config = lib.mkIf cfg.enable {
    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "${config.users.users.redstonetrail.home}/Downloads";
      };
    };
  };
}
