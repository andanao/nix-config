{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/default.nix
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

  # Install firefox.
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget

    fira-code-nerdfont
    cantarell-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    starship
    neofetch
    kitty

    cargo
    rustc

    bottles
    session-desktop
    discord
    orca-slicer
  ];

  programs.git = {
    enable = true;
    config = {
      user.name = "Adrian Danao-Schroeder";
      user.email = "adriandanao@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      jkl = "cd ~/git/";
      nurse = "sudo nixos-rebuild switch --flake";
    };
  };
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
