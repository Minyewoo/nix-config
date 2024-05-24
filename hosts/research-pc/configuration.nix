{ config, pkgs, inputs, lib, ... }:
let 
  homeUserDescription = "Minyewoo";
  homeUserName = lib.toLower homeUserDescription;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/boot/grub.nix
      ../../modules/nixos/boot/minegrub.nix
      ../../modules/nixos/desktop-environments/gnome.nix
      ../../modules/nixos/graphics/opengl.nix
      ../../modules/nixos/graphics/nvidia.nix
      ../../modules/nixos/i18n/default-locale.nix
      ../../modules/nixos/i18n/ru-locale.nix
      ../../modules/nixos/windowing/xserver.nix
      ../../modules/nixos/virtualization/pci-passthrough.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "research-pc";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  pciPassthrough = {
    cpuType = "amd";
    isNvidiaGpu = true;
    pciIDs = "10de:1b38";
    libvirtUsers = [ homeUserName ];
  };

  users.users."${homeUserName}" = {
    isNormalUser = true;
    description = homeUserDescription;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${homeUserName}" = import ./home.nix;
    };
  };

  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    steam
  ];

  services.openvpn = {
    servers = {
      minyewoo2023  = {
        config = '' config /home/${homeUserName}/minyewoo_2023.conf '';
        updateResolvConf = true;
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
