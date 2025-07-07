{ lib, config,  ... }:{
  options = {
    syncthing.enable = lib.mkEnableOption "enable Syncthing";
  };

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
