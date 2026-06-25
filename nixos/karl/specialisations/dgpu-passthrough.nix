{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.nvtopPackages.intel
      pkgs.btop
    ];

    etc."specialisation".text = "dgpu-passthrough";
  };

  system.nixos.tags = [ "dgpu-passthrough" ];

  # vfio
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      "i915"
    ];

    kernelParams = [
      "intel_iommu=on"
      "vfio-pci.ids=10de:28e0,10de:22be"
    ];
  };

  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
  };
}
