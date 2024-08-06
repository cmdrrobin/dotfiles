{ config, pkgs, ... }:

{
  home = {
    username = "robin";
    homeDirectory = "/Users/robin";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      go
      opentofu
      python3
      yq
      _1password
      monaspace
      jetbrains-mono
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      raycast
    ];

    file = {
      ".gitconfig".source = ../git/.gitconfig;
      ".config/wezterm".source = ../wezterm;
      ".config/starship".source = ../starship;
      ".config/tmux".source = ../tmux;
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "nvim";
      PAGER = "less -FirSwX";
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
