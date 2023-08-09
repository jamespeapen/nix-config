{ config, pkgs, dotfiles, ... }:

{
  home = {
    packages = with pkgs; [
      abook
      btop
      calcurse
      delta
      entr
      exa
      fd
      fzf
      gcc
      git
      gnumake
      htop
      isync
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
      smartmontools
      sqlite
      tmux
      urlscan
      urlview
      weechat
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
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/fd";
      recursive = true;
    };
    "git" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/git";
      recursive = true;
    };
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/nvim";
      recursive = true;
    };
    "tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/tmux";
      recursive = true;
    };
    "zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/zsh";
      recursive = true;
    };
  };

  home.file = {
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/zsh/zshenv";
    };

    ".local/bin" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin";
      recursive = true;
      executable = true;
    };
  };

}

# vim:set et sw=2 ts=2:
