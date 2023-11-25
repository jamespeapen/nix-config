{ config, pkgs, lib, home, ... }:

let
  core = import ./config/core.nix {config = config; pkgs = pkgs; home = home;};
  gui = import ./config/gui.nix {config = config; pkgs = pkgs; home = home;};
in
{
  imports = [ ./config/core.nix ./config/gui.nix ];

  home = {
    stateVersion = "23.05";
    username = "tux";
    homeDirectory = "/home/tux/";
  };

}

# vim:set et sw=2 ts=2:

