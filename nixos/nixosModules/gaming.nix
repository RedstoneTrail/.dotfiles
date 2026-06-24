{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.gaming;
in
{
  config = lib.mkIf cfg.enable {
    dotfiles.allowed-unfree-packages = [
      "steam"
      "steam-unwrapped"
    ];

    environment.systemPackages = with pkgs; [
      gamescope
      lutris
      mangohud
      mcpelauncher-ui-qt
      prismlauncher
      r2modman
      vkquake
      openjdk25
    ];

    programs = {
      steam.enable = true;
      java.enable = true;
    };
  };
}
