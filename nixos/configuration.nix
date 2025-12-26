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
      "uinput"
    ];
    initialHashedPassword = "$y$j9T$G2B0eQRQsBc7mN.ihxfKU.$N9zi8NT1GsjcHIeABfeukXZXUu.04.SmiwF14NuQX68";
    shell = pkgs.zsh;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
