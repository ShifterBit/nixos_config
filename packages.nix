
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

    # Terminal
    alacritty

    # CLI Tools
    wget
    neovim
    git
    neofetch
    youtube-dl
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
    vivaldi-widevine
    tree-sitter
    niv
    nixpkgs-fmt

    # OBS
    obs-studio
    obs-wlrobs
    obs-v4l2sink

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
    qutebrowser
    ungoogled-chromium
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-widevine
    qutebrowser
    lynx

    # Utils
    pavucontrol
    nodePackages.livedown
    station

    # Running Software/Gaming
    lutris
    steam-run
    appimage-run
    winetricks
    wineWowPackages.staging
    
   ];

}
