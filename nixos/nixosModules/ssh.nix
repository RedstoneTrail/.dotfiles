{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.ssh;
in
{
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
  };
}
