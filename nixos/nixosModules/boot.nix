{
  pkgs,
  ...
}:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        # temporarily comment the line below when setting up secure boot
        secureBoot.enable = true;
        package = pkgs.unstable.limine;
        style = {
          wallpapers = [
            "/home/redstonetrail/.dotfiles/wallpapers/wallpaper.png"
          ];
          interface = {
            branding = "joe's based nixos config";
          };
          graphicalTerminal = {
            brightBackground = "212121";
            background = "22212121";
          };
        };
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = [
    pkgs.unstable.sbctl
  ];
}
