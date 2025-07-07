{ pkgs, lib, config,  ... }: {

  options = {
    kanata.enable = lib.mkEnableOption "enable kanata";
  };

  config = lib.mkIf config.kanata.enable {
    environment.systemPackages = with pkgs; [
      kanata
    ];

  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
        (defsrc
         caps
        )
        (defvar
         tap-time 100
         hold-time 125
        )
        (defalias
         caps (tap-hold 125 125 esc lctl)
        )

        (deflayer base
         @caps
        )
        '';
      };
    };
  };

  boot.kernelModules = ["uinput"];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  };
}
