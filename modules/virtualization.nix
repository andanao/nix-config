{ pkgs, lib, config,  ... }: {

  options = {
    virtualization.enable = lib.mkEnableOption "enable virtualization";
  };

  config = lib.mkIf config.virtualization.enable {

    environment.systemPackages = with pkgs; [
      bottles
      qemu
      quickemu

      quickgui
    ];

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["adrian"];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

  };

}
