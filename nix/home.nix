{ config, pkgs, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/Users/robin";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    go
    opentofu
    python3
    yq
    monaspace
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  home.file = {
    ".gitconfig".source = ../git/.gitconfig;
    ".config/wezterm".source = ../wezterm;
    ".config/starship".source = ../starship;
    ".config/tmux".source = ../tmux;
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
