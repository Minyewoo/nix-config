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
      ../../modules/nixos/gaming/steam.nix
      inputs.home-manager.nixosModules.default
    ];

  networking = {
    hostName = "research-pc";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  users.users."${homeUserName}" = {
    isNormalUser = true;
    description = homeUserDescription;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  pciPassthrough = {
    cpuType = "amd";
    isNvidiaGpu = true;
    pciIDs = "10de:1b38";
    libvirtUsers = [ homeUserName ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${homeUserName}" = import ./home.nix;
    };
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  services = {
    openvpn = {
      servers = {
        minyewoo2023  = {
          config = '' config /home/${homeUserName}/minyewoo_2023.conf '';
          updateResolvConf = true;
        };
      };
    };
    openssh.enable = true;
  };

  system.stateVersion = "23.11";
}
