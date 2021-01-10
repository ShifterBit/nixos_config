# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  boot = {
    initrd.luks.devices = {
      crypt = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
        preLVM = true;
      };
    };
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  # Allow Non-Free Packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable Home-Manager
  home-manager.users.tek = import ./home.nix;


  # Enable 32-bit graphics support for games
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;


  # Enable Virtualization
  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_4" = {
      uuid = ["f7f5ba98-dc36-4ffb-a880-846b3b64e139"];
    };
  };  
  virtualisation.libvirtd = {
    qemuVerbatimConfig = ''
      seccomp_sandbox = 0
    '';
  };

  # Enable DConf
  programs.dconf.enable = true;

  # Enable XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  xdg.portal.gtkUsePortal = true;
 
  # Keep Derivations for nix_direnv
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    '';

  # MongoDB
  services.mongodb.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Controller Support
  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;


  # DNSCrypt
  services.resolved.enable = false;
  networking = {
    hostName = "nixos";
    nameservers = [ "127.0.0.1" "::1" ];
    resolvconf = {
      enable = true;
      useLocalResolver = true;
    };
    # If using dhcpcd:
    #dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [ "dnscrypt-de-blahdns-ipv4" "dnscrypt-de-blahdns-ipv6" "dnscrypt-fi-blahdns-ipv4" "dnscrypt-fi-blahdns-ipv6" ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };


  # Configure X
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  # X Server Keybindings
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable SSH
  programs.ssh.startAgent = true;


  # SwayWM
  programs.sway = {
  enable = true;
  wrapperFeatures.gtk = true; # so that gtk works properly
  extraPackages = with pkgs; [
    swaylock-effects
    swayidle
    wl-clipboard
    mako # notification daemon
    wofi # Dmenu is the default in the config but i recommend wofi since its wayland native
    wdisplays
    sway-contrib.grimshot
  ];
  };

  # i3WM
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
    dunst # notification daemon
    nitrogen
    i3lock-fancy
    rofi # Dmenu is the default in the config but i recommend wofi since its wayland native
    arandr
  ];
  };
  

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable ZSH
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tek = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "networkmanager" "kvm" "audio" "video" ]; 
     shell = pkgs.zsh;
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget vim git neofetch acpi
     polkit_gnome xdg-user-dirs
     alacritty font-awesome_4
     i3status-rust brightnessctl
     mps-youtube youtube-dl
     mpv-unwrapped xwayland
     virtmanager qemu
     xdg-desktop-portal
   ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
