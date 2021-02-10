{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-20.09";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations.shifter = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # modules = [
      #   nixpkgs.nixosModules.notDetected
      #   ./configuration.nix
      # ];
      modules = [
        ({ config, pkgs, ... }:
          let
            overlay-unstable = final: prev: {
              unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          in
          {
            nixpkgs.overlays = [ overlay-unstable inputs.nur.overlay ];
            nixpkgs.config.allowUnfree = true;
          }
        )

        nixpkgs.nixosModules.notDetected
        ./configuration.nix
      ];
    };
  };
}
