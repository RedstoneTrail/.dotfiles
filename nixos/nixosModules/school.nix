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
      zotero
    ];

    dotfiles.allowed-unfree-packages = [
      "google-chrome"
    ];

    programs.firefox.policies.ExtensionSettings."zotero@chnm.gmu.edu" = {
      install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.210";
      installation_mode = "force_installed";
    };

    security.pki.certificates = [
      (builtins.readFile ../../certificates/securly.pem)
      (builtins.readFile ../../certificates/school.pem)
    ];
  };
}
