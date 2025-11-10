{
  pkgs,
  ...
}:
{
  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    abook
    aerc
    brightnessctl
    buf
    catimg
    custom.mountui
    cyme
    fd
    ffmpeg-full
    fzf
    gh
    git
    glow
    gnumake
    htop-vim
    impala
    jq
    lua-language-server
    man-pages
    man-pages-posix
    mpv
    neovim
    nixd
    nixfmt-rfc-style
    pass
    playerctl
    prettier
    python3
    ripgrep
    smartmontools
    texlab
    tldr
    tmux
    tree
    vitetris
    wget
  ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services = {
    smartd.enable = true;
    locate = {
      enable = true;
      interval = "hourly";
    };
  };
}
