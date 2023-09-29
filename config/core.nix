{ config, pkgs, dotfiles, ... }:

let
  # Inspiration: https://github.com/NixOS/nixpkgs/issues/108480#issuecomment-1115108802
  isync-oauth2 = with pkgs; buildEnv {
    name = "isync-oauth2";
    paths = [ isync ];
    pathsToLink = ["/bin"];
    nativeBuildInputs = [ makeWrapper ];
    postBuild = ''
        wrapProgram "$out/bin/mbsync" \
          --prefix SASL_PATH : "${cyrus_sasl}/lib/sasl2:${cyrus-sasl-xoauth2}/lib/sasl2"
      '';
  };
in
{
  home = {
    packages = with pkgs; [
      abook
      btop
      calcurse
      delta
      entr
      eza
      fd
      fzf
      gcc
      git
      gnumake
      htop
      isync-oauth2
      lynx
      msmtp
      neomutt
      hyperfine
      jq
      miller
      msmtp
      neofetch
      ntfy-sh
      oath-toolkit
      pandoc
      parallel
      (pass.withExtensions (ext: with ext; [
        pass-tomb
      ]))
      pre-commit
      ripgrep
      ripgrep-all
      safe-rm
      smartmontools
      sqlite
      tmux
      urlscan
      urlview
      (weechat.override {
         configure = {availablePlugins, ...}: {
           plugins = with availablePlugins; [
             python
           ];
           scripts = with weechatScripts; [
             wee-slack
             edit
           ];
         };
      })
      youtube-dl
      yq-go
      zoxide
    ];
  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    # neovim
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        # neovim
        python3Packages.pynvim
        # LSPs
        shellcheck
        nodePackages_latest.bash-language-server
        python3Packages.jedi-language-server
        lua-language-server
        rust-analyzer
        rusty-man
        texlab
      ];
    };

  };

  # ~/.config file symlinks
  xdg.configFile = {
    "fd" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/fd;
      recursive = true;
    };
    "git" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/git;
      recursive = true;
    };
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/nvim;
      recursive = true;
    };
    "tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/tmux;
      recursive = true;
    };
    "zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zsh;
      recursive = true;
    };
  };

  home.file = {
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zsh/zshenv;
    };

    ".local/bin" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/bin;
      recursive = true;
      executable = true;
    };
  };

}

# vim:set et sw=2 ts=2:
