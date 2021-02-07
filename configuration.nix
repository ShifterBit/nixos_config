# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./networking.nix
      ./windowManagers.nix
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

  # Set Time Zone
  time.timeZone = "Africa/Banjul";

  # Enable 32-bit graphics support for games
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Enable Virtualization
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "tek" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Enable DConf
  programs.dconf.enable = true;

  # Enable XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
  xdg.portal.gtkUsePortal = true;
  systemd.user.services.xdg-desktop-portal.environment = {
    XDG_DESKTOP_PORTAL_DIR = config.environment.variables.XDG_DESKTOP_PORTAL_DIR;
  };
 
  # Keep Derivations for nix_direnv
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    '';
  # MongoDB
  services.mongodb.enable = true;

  # Controller Support
  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;

  # Configure X
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.displayManager.lightdm.enable = true;

  # Enable SSH
  programs.ssh.startAgent = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;

  # Brightness
  programs.light.enable = true;

  # Font Config
  fonts.fontconfig.enable = true;
  fonts.fontconfig.antialias = true;
  fonts.fontconfig.allowBitmaps = true;
  fonts.fontconfig.hinting.enable = true;

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
