{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dotfiles.rclone;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.rclone
    ];
  };
}
