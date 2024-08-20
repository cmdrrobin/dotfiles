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
    # FIX: due to weird GPU issue
    # https://github.com/wez/wezterm/issues/5990
    wezterm-flake = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, wezterm-flake }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Robins-MacBook-Pro
    darwinConfigurations."Robins-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs self; };
      modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager {
              # allow these packages to be installed. These packages may require to have a license or subscription
              nixpkgs.config.allowUnfree = true;
              # configure users and their required configurations and packages
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.robin = import ./home.nix;
              };
          }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Robins-MacBook-Pro".pkgs;
  };
}
