{ config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    curl
    wget
    tmux
    htop-vim
    iputils
    git
    neovim
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
    glow
    mpv
    proxychains
    openssh
    github-cli
    tealdeer
    iproute2
    bash
  ];

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Europe/London";

  #services.tor = {
  #  enable =true;
  #  torsocks.enable = true;
  #  client.enable = true;
  #  settings = {
  #     ControlPort = 9051;
  #  };
  #};

  android-integration = {
    termux-setup-storage.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    xdg-open.enable = true;
    am.enable =true;
  };

  terminal = {
    colors = {
      background = "#000000";
    };
    font = "${pkgs.nerdfonts.override {fonts = ["FiraMono"];}}/share/fonts/opentype/NerdFonts/FiraMonoNerdFontMono-Regular.otf";
  };
}
