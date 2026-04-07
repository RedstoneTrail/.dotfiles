{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./intel.nix
    ./specialisations.nix
  ];

  config = {
    dotfiles =
      let
        enabled = {
          enable = true;
        };
        disabled = {
          enable = false;
        };
      in
      {
        android-tooling = enabled;
        bluetooth = enabled;
        cli = enabled;
        gaming = enabled;
        graphical = enabled;
        hardware-accessible = enabled;
        networking-control = enabled;
        school = enabled;
        ssh = enabled;
        tor = enabled;
        torrenting = enabled;
        virtualisation = enabled;
        vt-config = enabled;
        web = enabled;

        pihole = disabled;
        printing = disabled;
      };

    networking.hostName = "karl";
    system.stateVersion = "25.05";

    users.users.redstonetrail = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "network"
        "networkmanager"
        "uinput"
        # ]
        # ++ lib.mkIf config.dotfiles.pihole.enabled [
        #   "docker"
      ];
      initialHashedPassword = "$y$j9T$rQ1v1g1IaFIJ6P7UHWsJ91$LjP8EG33DaUg9DTwbU8gbV6/eY4TB/SgUvRMvAphWFD";
      shell = pkgs.zsh;
    };
  };
}
