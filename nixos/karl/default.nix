{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
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
        pihole = disabled;
        printing = enabled;
        school = enabled;
        ssh = enabled;
        tor = enabled;
        torrenting = enabled;
        virtualisation = enabled;
        vt-config = enabled;
        web = enabled;
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
        "docker"
      ];
      initialHashedPassword = "$y$j9T$G2B0eQRQsBc7mN.ihxfKU.$N9zi8NT1GsjcHIeABfeukXZXUu.04.SmiwF14NuQX68";
      shell = pkgs.zsh;
    };
  };
}
