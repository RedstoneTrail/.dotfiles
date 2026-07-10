{
  config,
  pkgs,
  lib,
  ...
}:
let
  enabled = config.dotfiles.slsk.enable;
in
{
  config = lib.mkIf enabled {
    environment = {
      systemPackages = [
        pkgs.waves
        pkgs.slskd # NOT using services.slskd because i dont want my password in plaintext
      ];
    };
  };
}
