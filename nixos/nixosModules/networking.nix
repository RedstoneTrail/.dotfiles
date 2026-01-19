{
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.networking-control;
in
{
  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
        wifi.powersave = true;
        # dns = "dnsmasq";
      };
      firewall.enable = false;
    };

    services.resolved.enable = true;

    time.timeZone = "Europe/London";

    i18n.defaultLocale = "en_US.UTF-8";
  };
}
