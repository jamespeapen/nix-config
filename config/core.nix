{ config, pkgs, ... }:

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

  # wee-slack = with pkgs; weechatScripts.wee-slack.overrideAttrs (old: {
  #   src = fetchFromGitHub {
  #     owner = "wee-slack";
  #     repo = "wee-slack";
  #     rev = "f4fcf380e7baff9b84d32ac5c55fd8effd393119";
  #     sha256 = "ZLkYjlgtSXKzGzWq8annmGALyfxQQdHqR+Mmm5bvkbU=";
  #   };
  # });
  weechat_slack = with pkgs; weechat.override {
    configure = {availablePlugins, ...}: {
      plugins = with availablePlugins; [
        python
      ];
      scripts = with weechatScripts; [
        wee-slack
        edit
      ];
    };
  };

in
{
  home = {
    packages = with pkgs; [
      abook
      btop
      calcurse
      csview
      delta
      dufs
      entr
      eza
      fastfetch
      fd
      fzf
      gcc
      gitFull
      glow
      gnumake
      htop
      hyperfine
      i3-resurrect
      isync-oauth2
      jq
      ijq
      lynx
      miller
      msmtp
      msmtp
      neomutt
      ntfy-sh
      numbat
      oath-toolkit
      pandoc
      parallel
      (pass.withExtensions (ext: with ext; [ pass-tomb ]))
      pre-commit
      python3Packages.ptpython
      rename
      ripgrep
      ripgrep-all
      safe-rm
      smartmontools
      sqlite
      tmux
      urlscan
      viddy
      weechat_slack
      yt-dlp
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

    navi = {
      enable = true;
      enableZshIntegration = true;
    };

    # neovim
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        # neovim
        python3Packages.pynvim
        # LSPs
        nodePackages_latest.bash-language-server
        ccls
        nodePackages_latest.typescript-language-server
        gopls
        pyright
        python3Packages.jedi-language-server
        lua-language-server
        ruff
        rust-analyzer
        rusty-man
        shellcheck
        texlab
        vale
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
    "navi" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/navi;
      recursive = true;
    };
    #"tmux" = {
    #  source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/tmux;
    #  recursive = true;
    #};
    "zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zsh;
      recursive = true;
    };
  };

  home.file = {
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zsh/zshenv;
    };
  };

}

# vim:set et sw=2 ts=2:
