
{config, pkgs, ... }:

{
  
  # Udev Packages
  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  # DBus packages
  services.dbus.packages = with pkgs; [ gnome2.GConf ];

  # Non-Free Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Home Manager
    home-manager

    # XDG Stuff
    glib
    mime-types
    xdg-user-dirs
    shared-mime-info
    xdg-dbus-proxy
    xdg-desktop-portal
    perl532Packages.FileMimeInfo

    # Extra gnome packages
    polkit_gnome
    gsettings-desktop-schemas

    # Etc
    playerctl
    blueman

    # RSS Reader
    newsboat

    # File Managers
    xfce.thunar

    # PDF Viewer
    zathura

    # Media
    mpv
    youtube-dl

    # Terminal
    alacritty

    # CLI Tools
    wget
    neovim
    git
    neofetch
    axel
    aria
    bat
    exa
    tokei
    viu
    ripgrep
    fd
    fzf
    silver-searcher
    httplz

    # Development Tools
    mongodb-compass
    tree-sitter
    niv
    nixpkgs-fmt

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
    unstable.qutebrowser
    unstable.ungoogled-chromium
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs
    unstable.vivaldi-widevine
    unstable.qutebrowser
    unstable.lynx
    unstable.brave
    unstable.firefox
    unstable.firefox-beta-bin
    unstable.firefox-devedition-bin

    # Utils
    pavucontrol
    nodePackages.livedown
    station

    # Running Software/Gaming
    unstable.lutris
    unstable.steam-run
    appimage-run
    unstable.winetricks
    unstable.wineWowPackages.staging
    
   ];

}
