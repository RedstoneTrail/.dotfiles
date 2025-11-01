{
  config,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.redstonetrail = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  services.displayManager.ly.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
