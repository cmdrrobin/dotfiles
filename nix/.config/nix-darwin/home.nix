{ config, pkgs, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/Users/robin";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # home.file = {
  #   ".gitconfig".source = ~/dotfiles/git/.gitconfig;
  # };

  home.packages = with pkgs; [
    go
    opentofu
    python3
    yq
  ];

  programs.home-manager.enable = true;
}
