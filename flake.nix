{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs = { self,
              nixpkgs,
              nix-flatpak,
              ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        enceladus = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hosts/enceladus/configuration.nix
          ];
        };
      };
    };
}
