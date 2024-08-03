{ config, pkgs, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/Users/robin";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
