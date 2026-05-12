{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "";
        nix-path = config.nix.nixPath;
        # cachix
        substituters = [
          "https://nix-community.cachix.org"
          "https://nixos-raspberrypi.cachix.org"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  programs = {
    nix-ld.enable = true;
    nh = {
      enable = true;
      flake = "/home/redstonetrail/.dotfiles/nixos";
    };
  };

  services.envfs.enable = true;

  environment.systemPackages = [
    pkgs.nix-output-monitor
  ];
}
