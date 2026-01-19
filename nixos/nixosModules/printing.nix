{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.printing;
in
{
  config = lib.mkIf cfg.enable {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
