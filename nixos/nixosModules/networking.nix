{
  # lib,
  # pkgs,
  ...
}:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      wifi.powersave = true;
      # dns = "dnsmasq";
    };
    firewall.enable = false;
  };

  # services.dnsmasq = {
  #   enable = true;
  #   resolveLocalQueries = true;
  #   package = pkgs.unstable.dnsmasq;
  # };

  services.resolved.enable = true;
}
