{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.nvtopPackages.full
      pkgs.btop-cuda
    ];

    etc."specialisation".text = "vfio-maxxing";
  };

  imports = [
    ../nvidia.nix
  ];

  system.nixos.tags = [ "vfio-maxxing" ];

  # vfio
  boot = {
    initrd = {
      kernelModules = [
        "i915"
        "nvidia"
      ];

      availableKernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
      ];
    };

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "nvidia-drm.modeset=0"
      # "vfio-pci.ids=10de:28e0,10de:22be,1344:5404"
    ];
  };

  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
  };
}
