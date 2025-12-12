{
  pkgs,
  ...
}:
{
  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # communications
    abook
    aerc
    pass

    # system-level
    brightnessctl
    cyme # lsusb-like

    # for nvim
    buf
    lua-language-server
    neovim
    nixd
    nixfmt-rfc-style
    prettier
    texlab
    tinymist
    websocat

    # networking
    arp-scan
    dig
    impala
    nmap

    # useful
    bc
    custom.mountui
    fd
    ffmpeg-full
    file
    fzf
    jq
    (mpv.override {
      scripts = with mpvScripts; [
        uosc
        mpris
        mpv-image-viewer.detect-image
        mpv-image-viewer.image-positioning
      ];
    })
    ripgrep
    socat
    tmux
    tree
    w3m-nographics
    wget
    zip
    unzip

    # man
    man-pages
    man-pages-posix
    tldr

    # git
    gh
    git

    # development
    gnumake
    (python3.withPackages (pyton-pkgs: [
      python3Packages.pygobject3
      python3Packages.requests
    ]))
    typst

    # gtk
    gtk4
    gtk3
    gtk2

    # monitoring
    htop-vim
    hyperfine
    lm_sensors
    playerctl
    smartmontools

    # fun
    catimg
    figlet
    glow
    lolcat
    vitetris
    yt-dlp
  ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.smartd.enable = true;
}
