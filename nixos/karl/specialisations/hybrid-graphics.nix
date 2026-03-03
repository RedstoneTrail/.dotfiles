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

    etc."specialisation".text = "hybrid-graphics";
  };

  system.nixos.tags = [ "hybrid-graphics" ];

  imports = [
    ../nvidia.nix
  ];
}
