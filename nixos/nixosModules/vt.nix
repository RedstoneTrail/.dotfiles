{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.vt-config;
in
{
  config = lib.mkIf cfg.enable {
    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkForce "uk";
      useXkbConfig = true; # use xkb.options in tty.
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "doom";
        bigclock = true;
        brightness_down_cmd = "/run/current-system/sw/bin/brightnessctl -q -n s 5%-";
        brightness_down_key = "F5";
        brightness_up_cmd = "/run/current-system/sw/bin/brightnessctl -q -n s +5%";
        brightness_up_key = "F6";
        clear_password = true;
        setup_cmd = "";
        sleep_cmd = "/usr/bin/env systemctl sleep";
      };
      package = pkgs.unstable.ly;
      x11Support = false;
    };
  };
}
