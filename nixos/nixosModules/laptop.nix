{ config, lib, ... }:
let
  cfg = config.dotfiles.laptop.enable;
in
{
  config = lib.mkIf cfg {
    services = {
      upower.ignoreLid = true;
      logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
    };
  };
}
