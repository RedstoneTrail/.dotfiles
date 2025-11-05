{
  pkgs,
  lib,
  ...
}:
{
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
      sleep_cmd = "/usr/bin/env systemctl sleep";
      brightness_down_key = "F5";
      brightness_down_cmd = "/run/current-system/sw/bin/brightnessctl -q -n s 10%-";
      brightness_up_key = "F6";
      brightness_up_cmd = "/run/current-system/sw/bin/brightnessctl -q -n s +10%";
      clear_password = true;
      setup_cmd = "";
    };
    package = pkgs.unstable.ly;
  };
}
