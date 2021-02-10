{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-20.09"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = { url = "github:nix-community/NUR"; };
    neovim-nightly-overlay = { url = "github:nix-community/neovim-nightly-overlay"; };
  };
  outputs = { self, home-manager, nixpkgs, nixpkgs-unstable, nur, neovim-nightly-overlay, ... }: {
    nixosConfigurations.shifter = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }:
          let
            overlay-unstable = final: prev: { unstable = nixpkgs-unstable.legacyPackages.x86_64-linux; };
          in
          {
            nixpkgs.overlays = [ nur.overlay overlay-unstable neovim-nightly-overlay.overlay ];
          }
        )

        nixpkgs.nixosModules.notDetected
        ./configuration.nix
      ];
    };
  };
}
