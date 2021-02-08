{ config, pkgs, ... }:

{

  # SwayWM
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock-effects
      swayidle
      waybar
      wl-clipboard
      mako # notification daemon
      wofi # Dmenu is the default in the config but i recommend wofi since its wayland native
      light
      wdisplays
      xwayland
      sway-contrib.grimshot
      acpi
      i3status-rust
      brightnessctl
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
      acpi
      i3status-rust
      brightnessctl
    ];
  };
}
