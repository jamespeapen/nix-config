{ config, pkgs, dotfiles, ... }:

{
  home = {
    packages = with pkgs; [
      inkscape
      lm_sensors
      mutt-wizard
      rxvt-unicode
      tilix
      vlc
      warpd
      xdragon
      zathura
    ];
  };

  programs = {

    rofi = {
      enable = true;
      theme = "gruvbox-dark-hard";
    };

  };

  # ~/.config file symlinks
  xdg.configFile = {
    "i3" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/i3;
      recursive = true;
    };
    "sway" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/sway;
      recursive = true;
    };
    "waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/waybar;
      recursive = true;
    };
    "zathura" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zathura;
      recursive = true;
    };
  };

}

# vim:set et sw=2 ts=2:
