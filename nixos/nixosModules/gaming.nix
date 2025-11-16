{
  pkgs,
  ...
}:
{
  config = {
    allowed-unfree-packages = [
      "steam"
      "steam-unwrapped"
    ];

    environment.systemPackages = with pkgs; [
      lutris
      mangohud
      prismlauncher
      vkquake
    ];

    programs = {
      steam.enable = true;
      java.enable = true;
      gamemode = {
        enable = true;
        settings = {
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send -a gamemoded start";
            end = "${pkgs.libnotify}/bin/notify-send -a gamemoded end";
          };
        };
      };
    };
  };
}
