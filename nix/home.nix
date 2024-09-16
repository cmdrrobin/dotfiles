{ inputs }:

{ config, pkgs, lib, ... }:
{
  home = {
    username = "robin";
    homeDirectory = "/Users/robin";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      _1password
      gnupg
      gh
      go
      gopass
      jetbrains-mono
      jq
      monaspace
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      nodejs_20
      ollama
      opentofu
      pinentry-tty
      python3
      raycast
      rustup
      tldr
      vault
      yq
    ];

    file = {
      ".gitconfig".source = ../git/.gitconfig;
      ".config/kitty".source = ../kitty;
      ".config/starship".source = ../starship;
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CACHE_HOME = "$HOME/.cache";
      EDITOR = "nvim";
      PAGER = "less -FirSwX";
      CLICOLOR = 1;
      STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
      SSH_AUTH_SOCK = "/Users/robin/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      s = "sesh connect \$(sesh list | fzf)";
    };

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "v1.1.2";
            sha256 = "061jjpgghn8d5q2m2cd2qdjwbz38qrcarldj16xvxbid4c137zs2";
          };
        file = "fzf-tab.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    colors = {
      "bg+" = "#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796";
      fg = "#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6";
      marker = "#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../tmux/tmux.conf;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "CatppuccinMocha";
    };
    themes = {
      CatppuccinMocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
          sha256 = "1g73x0p8pbzb8d1g1x1fwhwf05sj3nzhbhb65811752p5178fh5k";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
