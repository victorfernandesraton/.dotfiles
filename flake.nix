{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations =
        # TODO: using callPkgs to make more sense oevrlays
        let
          pkgs = import nixpkgs {
            overlays = [
              (final: prev: {
                electron = prev.electron-bin.override;
              })
            ];
          };
        in
        {
          valhalla = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/valhalla/configuration.nix
              inputs.home-manager.nixosModules.default
            ];
          };
        };

    };
}
