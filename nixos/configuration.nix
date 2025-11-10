{
  config,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "karl";
  users.users.redstonetrail = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "network"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
