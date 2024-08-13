{ self, pkgs, lib, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # These packages are available system wide
  environment.systemPackages =
    [
      pkgs.neovim
      pkgs.ripgrep
      pkgs.fzf
      pkgs.direnv
      pkgs.bat
      pkgs.starship
      pkgs.tmux
      pkgs.zoxide
      pkgs.fd
      pkgs.git
      pkgs.lazygit
      pkgs.lazydocker
      pkgs.sesh
      pkgs.wezterm
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # OSX specific configurations
    defaults = {
      dock.autohide = true;
      loginwindow.LoginwindowText = "Hello World 👋🏻";
      screencapture.location = "~/Pictures/Screenshots"; # Save screenshots to defined folder
      NSGlobalDomain.ApplePressAndHoldEnabled = false; # Disable press and hold for diacritics
      # TODO: get an error "Could not write domain com.apple.universalaccess; exiting"
      # universalaccess.reduceMotion = true;
    };

    # use capslock for escape key
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };


  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";

  # enable Touch ID for sudo commands
  security.pam.enableSudoTouchIdAuth = true;

  nix = {
    home-manager.backupFileExtension = "backup";
    configureBuildUsers = true;
    useDaemon = true;

    # Automatic Garbage Collection
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 15;
          Weekday = 7;
        }
      ];
      options = "--delete-older-than 7d";
    };
  };


  # Homebrew needs to be installed on its own!
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    casks = [
      "obsidian"
      "tunnelblick"
      "resilio-sync"
      "nikitabobko/tap/aerospace"
    ];
    masApps = {
      Amphetamine = 937984704;
      Todoist = 585829637;
    };
  };

  # My personal folder
  users.users.robin = {
    home = "/Users/robin";
    shell = pkgs.zsh;
  };

  # allow these packages to be installed. These packages may require to have a license or subscription
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "raycast"
    "1password-cli"
    "vault"
  ];

}
