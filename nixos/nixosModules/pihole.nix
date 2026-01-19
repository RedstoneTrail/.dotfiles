{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.pihole;
  serverIP = "192.168.1.231";
in
{
  config = lib.mkIf cfg.enable {
    docker-containers.pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "${serverIP}:53:53/tcp"
        "${serverIP}:53:53/udp"
        "80:80/tcp"
        "30443:443"
      ];
      volumes = [
        "/var/lib/pihole/:/etc/pihole/"
        "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
      ];
      environment = {
        ServerIP = serverIP;
        TZ = "Europe/London";
        FTLCONF_webserver_api_password = "example password";
      };
      extraDockerOptions = [
        "--cap-add=NET_ADMIN"
        "--dns=127.0.0.1"
        "--dns=1.1.1.1"
      ];
      workdir = "/var/lib/pihole/";
    };
  };
}
