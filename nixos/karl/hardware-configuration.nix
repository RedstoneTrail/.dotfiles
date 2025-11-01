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

    # nvidia
    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      # powerManagement.offload = true;
      # powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = false;
    };

    # so much cuda
    allowed-unfree-packages = [
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cuobjdump"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_gdb"
      "cuda-merged"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvml_dev"
      "cuda_nvprune"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libcusparse"
      "libnpp"
      "libnvjitlink"
      "nvidia-x11"
    ];

    environment.systemPackages = with pkgs; [
      clinfo
      nvtopPackages.full
    ];
  };
}
