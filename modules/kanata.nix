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
      mxkeys = {
        devices = [
          "/dev/input/event21" #warning this may change
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
        (defsrc
         caps
        )
        (defvar
         tap-time 150
         hold-time 200
        )
        (defalias
         caps (tap-hold 200 200 esc lctl)
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
