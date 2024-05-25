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
      ../../modules/nixos/virtualisation/virt-manager.nix
      ../../modules/nixos/virtualisation/vfio.nix
      ../../modules/nixos/gaming/steam.nix
      ../../modules/nixos/ipmi/ipmi.nix
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

  virtualisation = {
    vfio = {
      enable = true;
      IOMMUType = "amd";
      devices = [ "10de:1b38" ];
      disableEFIfb = false;
      blacklistNvidia = false;
      ignoreMSRs = true;
      applyACSpatch = false;
    };
    virt-manager.br0Interface = "eno1";
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
