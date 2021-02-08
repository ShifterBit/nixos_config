{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; };
    nur = { url = "github:nix-community/NUR"; };
  };
  outputs = {home-manager, nixpkgs, nur, ...}: {
     # replace 'joes-desktop' with your hostname here.
     nixosConfigurations.shifter = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ 
         ./configuration.nix
         home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tek = import ./home.nix;
          }
       ];
     };
  };
}

