{
  ...
}:
{
  environment.systemPackages = pkgs.bluetui

  services.blueman.enable = true;

  hardware.bluetooth = {
    enabled = true;
    powerOnBoot = false;
  };
}
