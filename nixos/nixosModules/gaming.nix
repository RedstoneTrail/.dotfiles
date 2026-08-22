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
      openjdk25
      prismlauncher
      protontricks
      r2modman
      vkquake
      winetricks
    ];

    programs = {
      steam.enable = true;
      java.enable = true;
    };
  };
}
