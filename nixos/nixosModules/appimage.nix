{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.appimage;
in
{
  config.programs.appimage = lib.mkIf cfg.enable {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs =
        pkgs: with pkgs; [
          icu
        ];
    };
  };
}
