{ pkgs, lib, config,  ... }: {
  imports = [
    ./gaming.nix
    ./locale.nix
  ];

  gaming.enable = lib.mkDefault false;
  locale.enable = lib.mkDefault true;

}
