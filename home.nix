{ config, pkgs, lib, home, ... }:

let
  core = import ./config/core.nix {config = config; pkgs = pkgs; home = home;};
  gui = import ./config/gui.nix {config = config; pkgs = pkgs; home = home;};
  work = import ./config/work.nix {config = config; pkgs = pkgs; home = home;};
in
{
  imports = [ ./config/core.nix ./config/gui.nix ./config/work.nix];

  home = {
    stateVersion = "23.05";
    username = "james.eapen";
    homeDirectory = "/home/james.eapen/";
  };

}

# vim:set et sw=2 ts=2:

