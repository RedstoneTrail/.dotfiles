{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    hardware.graphics.enable = true;

    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
      extraModprobeConfig = ''
        options nvidia "NVreg_DynamicPowerManagement=0x03"
      '';
    };

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    swapDevices = [
      { device = "/dev/disk/by-label/swap"; }
    ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # always blacklist nouveau
    boot.blacklistedKernelModules = [ "nouveau" ];

    # enable powertop
    powerManagement.powertop = {
      enable = true;
      # disable all usb power management
      postStart = ''for i in /sys/bus/usb/devices/*/power/control; do /bin/sh -c "echo on > $i"; done'';
    };

    # gpu info packages
    environment.systemPackages = with pkgs; [
      powertop
      clinfo
      pocl
    ];

    services.udev.extraRules = ''
      # Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
      ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
      ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

      # Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
      ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
      ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"

      # Enable runtime PM for NVIDIA VGA/3D controller devices on adding device
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
    '';
  };
}
