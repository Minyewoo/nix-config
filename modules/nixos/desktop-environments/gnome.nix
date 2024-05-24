{ pkgs, ... }:
{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    gnome.core-utilities.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-disk-utility
      gnome.nautilus
      evince
    ];
    gnome.excludePackages = with pkgs; [
      gnome-tour
    ];
  };

  programs.dconf.enable = true;
}