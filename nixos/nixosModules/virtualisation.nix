{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.virtualisation;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation = {
      waydroid = {
        enable = true;
        package = pkgs.unstable.waydroid-nftables;
      };
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = [
      pkgs.wineWowPackages.waylandFull
    ];

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
  };
}
