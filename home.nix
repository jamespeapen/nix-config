{ config, pkgs, lib, home, dotfiles, ... }:

let
  core = import ./config/core.nix {config = config; pkgs = pkgs; home = home; dotfiles = dotfiles};
  gui = import ./config/gui.nix {config = config; pkgs = pkgs; home = home; dotfiles = dotfiles};
in
{
  imports = [ ./config/core.nix ./config/gui.nix];

  home = {
    stateVersion = "23.05";
    username = "tux";
    homeDirectory = "/home/tux/";
  };

}

# vim:set et sw=2 ts=2:

