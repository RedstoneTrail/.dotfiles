{
  pkgs,
  config,
  ...
}:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        maxGenerations = 5;
        style = {
          wallpapers = [
            "/home/redstonetrail/.dotfiles/wallpapers/wallpaper.png"
            "/home/redstonetrail/.dotfiles/wallpapers/wallpaper2.png"
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
    };
  };
}
