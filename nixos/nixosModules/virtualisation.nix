{
  pkgs,
  ...
}:
{
  virtualisation = {
    waydroid = {
      enable = true;
      package = pkgs.unstable.waydroid-nftables;
    };
  };

  programs = {
    virt-manager.enable = true;
  };
}
