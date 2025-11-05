{
  ...
}:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      wifi.powersave = true;
    };
  };

  # services.dnsmasq = {
  #   enable = true;
  #   resolveLocalQueries = true;
  # };

  services.resolved.enable = true;
}
