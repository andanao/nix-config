{
  pkgs,
  lib,
  config,
  # nixpkgs,
  ...
}:
{

  options = {
    benchmarking.enable = lib.mkEnableOption "enable benchmarking";
  };


  config = lib.mkIf config.benchmarking.enable {

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      unigine-superposition
      furmark
    ];
  };
}
