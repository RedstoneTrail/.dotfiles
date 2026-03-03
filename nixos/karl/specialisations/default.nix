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
  };

  system.nixos.tags = [ "integrated-graphics" ];
}
