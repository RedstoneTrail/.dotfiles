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

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "redstonetrail" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  programs.dconf = {
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
}
