{ pkgs, lib, config, ... }: {

  options = {
    flatpak.enable = lib.mkEnableOption "enable flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"     # Manage flatpak permissions - should always have this
        "it.mijorus.gearlever"           # Manage and support AppImages
        "com.rtosta.zapzap"              # WhatsApp client
        "app.bluebubbles.BlueBubbles"    # iMessage for linux
      ];

      update.onActivation = true;
    };
  };
}
