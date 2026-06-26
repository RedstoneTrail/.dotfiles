{
  pkgs,
  config,
  ...
}:
{
  boot = {
    loader = {
      # temporarily comment the line below when setting up secure boot
      limine.secureBoot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl."kernel.sysrq" = 1;

    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = [
    pkgs.unstable.sbctl
  ];
}
