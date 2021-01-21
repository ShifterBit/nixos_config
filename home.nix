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
    # Etc
    xdg-dbus-proxy
    gnome3.gnome-screenshot
    gnome3.gnome-settings-daemon
    kdeApplications.kdeconnect-kde
    playerctl
    xfce.thunar
    blueman
    element-desktop
    mime-types
    shared-mime-info
    perl532Packages.FileMimeInfo
    nextcloud-client

    # Shell Customization
    starship
    autojump
    zsh-completions
    zsh-command-time
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    nix-zsh-completions

    # CLI Tools
    axel
    aria
    bat
    exa
    tokei
    viu
    ripgrep
    fzf
    silver-searcher
    httplz

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    twemoji-color-font
    noto-fonts-emoji-blob-bin
    emojione
    
    # Development Tools
    mongodb-compass
    niv

    # Text Editors
    neovim-nightly
    micro
    kakoune
    

    # Themes
    lxappearance
    materia-theme
    papirus-icon-theme

    # Archiving
    zip
    unzip
    p7zip
    unrar
    gzip

    # Browsers
    ungoogled-chromium

    # Language Servers
    clang
    rnix-lsp
    clang-tools
    rust-analyzer
    nodePackages.pyright
    haskell-language-server
    sumneko-lua-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.vue-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin


    # Running Software/Gaming
    steam-run
    appimage-run
    winetricks
    wineWowPackages.staging
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
