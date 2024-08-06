{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
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
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";

      # enable Touch ID for sudo commands
      security.pam.enableSudoTouchIdAuth = true;

      # home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      # OSX specific configurations
      system.defaults = {
        dock.autohide = true;
        loginwindow.LoginwindowText = "Hello World 👋🏻";
        screencapture.location = "~/Pictures/Screenshots";
        # TODO: get an error "Could not write domain com.apple.universalaccess; exiting"
        # universalaccess.reduceMotion = true;
      };

      # use capslock for escape key
      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
      };

      # DANGER! When enabled, only fonts that is managed by Nix will be enabled
      # fonts.fontDir.enable = false;

      # Automatic Garbage Collection
      nix.gc = {
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

      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
      homebrew.casks = [
          "wezterm"
          "raycast"
          "monodraw"
      ];

      # My personal folder
      users.users.robin = {
        home = "/Users/robin";
        shell = pkgs.zsh;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Robins-MacBook-Pro
    darwinConfigurations."Robins-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
          configuration
          home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.robin = import ./home.nix;
          }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Robins-MacBook-Pro".pkgs;
  };
}
