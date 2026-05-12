{
  pkgs,
  ...
}:
{
  boot = {
    loader.raspberry-pi.bootloader = "kernel";
    tmp.useTmpfs = true;
  };
}
