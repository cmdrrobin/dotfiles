{ config, pkgs, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/Users/robin";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.file = {
    ".gitconfig".source = ../git/.gitconfig;
    ".config/wezterm".source = ../wezterm;
    ".config/starship".source = ../starship;
    ".config/tmux".source = ../tmux;
  };

  home.packages = with pkgs; [
    go
    opentofu
    python3
    yq
  ];

  programs.home-manager.enable = true;
}
