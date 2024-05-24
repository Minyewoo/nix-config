{ config, pkgs, inputs, lib, ... }:
let 
  homeUserName = "Minyewoo";
  homeUserNameLower = "minyewoo";
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
      ../../modules/nixos/virtualization/virt-manager.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "research-pc";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  users.users."${homeUserNameLower}" = {
    isNormalUser = true;
    description = homeUserName;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${homeUserNameLower}" = import ./home.nix;
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
        config = '' config /home/${homeUserNameLower}/minyewoo_2023.conf '';
        updateResolvConf = true;
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
