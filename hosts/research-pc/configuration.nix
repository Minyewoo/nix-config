{ config, pkgs, inputs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.loader = {
    timeout = 5;
    efi = {
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      minegrub-theme = {
        enable = true;
        splash = "100% Flakes!";
      };
    };
  };

  networking.hostName = "research-pc";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  users.users.minyewoo = {
    isNormalUser = true;
    description = "Minyewoo";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      minyewoo = import ./home.nix;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-disk-utility
    gnome.nautilus
    evince
    steam
  ];

  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";  
    };
    excludePackages = with pkgs; [
      xterm
    ];
  };

  services.openvpn = {
    servers = {
      minyewoo2023  = {
        config = '' config /home/minyewoo/minyewoo_2023.conf '';
        updateResolvConf = true;
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
