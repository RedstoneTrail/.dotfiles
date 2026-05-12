{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.input;
in
{
  config = lib.mkIf cfg.enable {
    environment.etc."redstonetrail/kanata/${config.networking.hostName}.kbd".text =
      builtins.readFile ../../kanata/${config.networking.hostName}.kbd;

    services.kanata = {
      enable = true;
      keyboards.default.configFile = "/etc/redstonetrail/kanata/${config.networking.hostName}.kbd";
    };
  };
}
