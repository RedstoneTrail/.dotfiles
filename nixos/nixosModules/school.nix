{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.school;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];

    dotfiles.allowed-unfree-packages = [
      "google-chrome"
    ];

    security.pki.certificates = [
      (builtins.readFile ../../certificates/securly.pem)
      (builtins.readFile ../../certificates/school.pem)
    ];
  };
}
