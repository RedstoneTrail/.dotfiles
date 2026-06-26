{ pkgs, ... }:
{
  users.users.redstonetrail = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "network"
      "networkmanager"
      "uinput"
      "wireshark"
    ];
    initialHashedPassword = "$y$j9T$rQ1v1g1IaFIJ6P7UHWsJ91$LjP8EG33DaUg9DTwbU8gbV6/eY4TB/SgUvRMvAphWFD";
    shell = pkgs.zsh;
  };
}
