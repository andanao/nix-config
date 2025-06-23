{ pkgs, lib, config,  ... }: {
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;

    };


    environment.systemPackages = with pkgs; [
      kitty
      waybar

      hyprpaper
      swww

      dunst
      libnotify
      rofi-wayland
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };


    # environment.sessionVariable = {
    #   WLR_NO_HARDWARE_CURSORS = "1";
    #   NIXOS_OZONE_WL = "1";
    # };

    hardware = {
      opengl.enable = true;
    };

  };

}
