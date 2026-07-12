{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    intel-compute-runtime
    intel-ocl
    libva-vdpau-driver
    intel-vaapi-driver
    intel-media-driver

    libvdpau-va-gl
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  dotfiles.allowed-unfree-packages = [
    "intel-ocl"
  ];
}
