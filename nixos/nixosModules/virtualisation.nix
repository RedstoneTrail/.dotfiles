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
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  users.groups.libvirtd.members = [ "redstonetrail" ];

  programs = {
    virt-manager.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/virt-manager/virt-manager/connections" = {
              autoconnect = [ "qemu:///system" ];
              uris = [ "qemu:///system" ];
            };
          };
          lockAll = true;
        }
      ];
    };
  };

  environment.systemPackages = [ pkgs.wine ];
}
