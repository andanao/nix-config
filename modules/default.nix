{ pkgs, lib, config,  ... }: {
  imports = [
    ./gaming.nix
    ./locale.nix
    ./virtualization.nix
    ./hyprland.nix
    ./flatpak.nix
  ];

  gaming.enable = lib.mkDefault false;
  locale.enable = lib.mkDefault true;
  virtualization.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault true;
  flatpak.enable = lib.mkDefault true;

}
