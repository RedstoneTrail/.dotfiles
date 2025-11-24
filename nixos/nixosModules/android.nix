{
  pkgs,
  ...
}:
{
  programs.adb.enable = true;

  environment.systemPackages = [
    pkgs.scrcpy
  ];
}
