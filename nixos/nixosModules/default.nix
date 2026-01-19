{
  config,
  lib,
  ...
}:
{
  options.dotfiles.allowed-unfree-packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };

  config.nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.dotfiles.allowed-unfree-packages;

  options.dotfiles = {
    android-tooling.enable = lib.mkEnableOption "Enable android interaction tools";
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth support";
    cli.enable = lib.mkEnableOption "Enable command line utilities";
    gaming.enable = lib.mkEnableOption "Enable settings related to gaming";
    graphical.enable = lib.mkEnableOption "Enable graphical features";
    hardware-accessible.enable = lib.mkEnableOption "Enable hardware access";
    networking-control.enable = lib.mkEnableOption "Enable configuration of networking hardware and low-level software";
    pihole.enable = lib.mkEnableOption "Enable hosting pihole for network-wide adblock";
    printing.enable = lib.mkEnableOption "Enable CUPS and other printing features";
    school.enable = lib.mkEnableOption "Enable software and other such config for school";
    ssh.enable = lib.mkEnableOption "Enable ssh";
    tor.enable = lib.mkEnableOption "Enable tor proxying using torsocks and proxychains";
    torrenting.enable = lib.mkEnableOption "Enable torrenting software";
    virtualisation.enable = lib.mkEnableOption "Enable virtualisation features";
    vt-config.enable = lib.mkEnableOption "Enable vt config";
    web.enable = lib.mkEnableOption "Enable web things like browser";
  };

  imports = [
    ./android.nix
    ./bluetooth.nix
    ./cli.nix
    ./firefox.nix
    ./gaming.nix
    ./input.nix
    ./networking.nix
    ./nixosSupport.nix
    ./pihole.nix
    ./printing.nix
    ./school.nix
    ./ssh.nix
    ./tor.nix
    ./torrent.nix
    ./virtualisation.nix
    ./vt.nix
    ./wm.nix
  ];
}
