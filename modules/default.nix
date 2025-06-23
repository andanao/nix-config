{ pkgs, lib, config,  ... }: {
  imports = [
    ./gaming.nix
    ./locale.nix
    ./virtualization.nix
  ];

  gaming.enable = lib.mkDefault false;
  locale.enable = lib.mkDefault true;
  virtualization.enable = lib.mkDefault false;

}
