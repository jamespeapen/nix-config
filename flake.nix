{

  description = "My Home Manager Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      type = "git";
      url = "https://github.com/jamespeapen/dotfiles";
      flake = false;
      submodules = true;
    };
  };

  outputs = { nixpkgs, home-manager, dotfiles, ...}@inputs:
    let
    system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."tux" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ ./home.nix ];
      extraSpecialArgs = {
        inherit (inputs) dotfiles;
      };
    };
  };

}
# vim:set et sw=2 ts=2:
