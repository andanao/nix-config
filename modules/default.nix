{ pkgs, lib, config,  ... }: {
  imports = [
    ./gaming.nix
    ./locale.nix
    ./virtualization.nix
    ./hyprland.nix
    ./flatpak.nix
    ./kanata.nix
    ./syncthing.nix
    ./benchmarking.nix
  ];

  gaming.enable = lib.mkDefault false;
  virtualization.enable = lib.mkDefault false;
  benchmarking.enable = lib.mkDefault false;

  locale.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  flatpak.enable = lib.mkDefault true;
  kanata.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
}
