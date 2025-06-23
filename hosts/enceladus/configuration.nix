{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules
    ];

  networking.hostName = "enceladus"; # Define your hostname.

  # enable opengl
  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

  nix.settings.experimental-features = ["flakes" "nix-command"];

  gaming.enable = true;
  virtualization.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.networkmanager.enable = true;


  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

  };


  users.users.adrian = {
    isNormalUser = true;
    description = "adrian";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.extraRules= [
    { users = [ "adrian" ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  programs.git.enable = true;
  programs.firefox.enable = true;


  nixpkgs.config.allowUnfree = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    wget
    gnumake

    fira-code-nerdfont
    cantarell-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    starship
    kitty

    cargo
    python3

    session-desktop
    orca-slicer
  ];


  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;


  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.shellAliases = {
    vi = "nvim";
    ll = "ls -l";
    la = "ls -la";
    gs = "git status";

    nsp = "nix-shell -p";
  };


  services.openssh.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

}
