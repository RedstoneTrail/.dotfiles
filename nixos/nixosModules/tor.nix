{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.tor;
in
{
  config = lib.mkIf cfg.enable {
    services.tor = {
      enable = true;
      client.enable = true;
      torsocks.enable = true;
      settings = {
        ControlPort = 9051;
      };
    };

    programs.proxychains.enable = true;
  };
}
