{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.android-tooling;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      scrcpy
      android-tools
    ];
  };
}
