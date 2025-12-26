{
  config,
  ...
}:
{
  environment.etc."redstonetrail/kanata/${config.networking.hostName}.kbd".text =
    builtins.readFile ../../kanata/${config.networking.hostName}.kbd;

  services.kanata = {
    enable = true;
    keyboards.default.configFile = "/etc/redstonetrail/kanata/${config.networking.hostName}.kbd";
  };
}
