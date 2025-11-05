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
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #	 enable = true;
  #	 enableSSHSupport = true;
  # };

  services.openssh.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
