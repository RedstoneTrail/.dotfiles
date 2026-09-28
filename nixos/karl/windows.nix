{ config, pkgs, ... }:
{
  config = {
    fileSystems."/windows/boot" = {
      device = "/dev/disk/by-label/WINBOOT";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    fileSystems."/windows/root" = {
      device = "/dev/disk/by-label/WINROOT";
      fsType = "ntfs3";
      options = [
        "fmask=0022"
        "dmask=0022"
        "uid=1000"
      ];
    };

    environment.systemPackages = with pkgs; [
      chntpw
      ntfs3g
      rlwrap
    ];

    boot = {
      supportedFilesystems = [ "ntfs" ];
      loader.limine.extraEntries = ''
        /Windows 11
        protocol: efi
        path: fslabel(WINBOOT):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
  };
}
