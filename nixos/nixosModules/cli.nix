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
    catimg
    gh
    git
    gnumake
    gnupg
    htop-vim
    impala
    jq
    neovim
    pass
    playerctl
    ripgrep
    tmux
    wget
  ];
}
