{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tek";
  home.homeDirectory = "/home/tek";
  home.packages = with pkgs; [
    steam-run
    unzip
    p7zip
    unrar
    gzip
    starship
    axel
    uget
    aria
    ungoogled-chromium
    firefox-devedition-bin
    google-chrome
    httplz
    xdg-dbus-proxy
    autojump
    zsh-completions
    zsh-command-time
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    nix-zsh-completions
    neovim-nightly
    nodejs
    ripgrep
    fzf
    silver-searcher
    gcc
    gnome3.gnome-screenshot
    niv
    playerctl
    lxappearance
    materia-theme
    papirus-icon-theme
    twemoji-color-font
    noto-fonts-emoji-blob-bin
    emojione
    xfce.thunar
    blueman
    mongodb-compass
    dragon-drop
    bat
    exa
    tokei
    viu




    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    wineWowPackages.full
    winetricks
  ];

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
