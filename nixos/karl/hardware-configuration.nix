{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  config = {
    boot = {
      initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
    };

    fileSystems."/" =
      { device = "/dev/disk/by-label/NIXROOT";
        fsType = "btrfs";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-label/swap"; }
      ];

    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # gpu info packages
    environment.systemPackages = with pkgs; [
      clinfo
      nvtopPackages.full
    ];
  };
}
