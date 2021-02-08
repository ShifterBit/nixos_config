{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-20.09"; };
    unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; };
    nur = { url = "github:nix-community/NUR"; };
    neovim-nightly-overlay = { url = "github:nix-community/neovim-nightly-overlay"; };
  };
  outputs = { self, home-manager, nixpkgs, nur, neovim-nightly-overlay, ... }@inputs: {
    nixosConfigurations.shifter = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users.tek = import ./home.nix;
        }
        {nixpkgs.overlays = [ nur.overlay neovim-nightly-overlay.overlay]; }

      ] ;
    };
  };
}
