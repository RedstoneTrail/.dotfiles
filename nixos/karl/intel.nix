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
  ];

  allowed-unfree-packages = [
    "intel-ocl"
  ];
}
