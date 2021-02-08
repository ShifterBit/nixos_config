{ config, pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # DNSCrypt
  services.resolved.enable = false;
  networking = {
    hostName = "shifter";
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

}
