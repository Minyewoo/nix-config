{ lib, ... }:
let 
  homeUserName = "Minyewoo";
in
{
  imports = [
    ../../modules/home-manager/development/vscode.nix
    ../../modules/home-manager/development/git.nix
    ../../modules/home-manager/development/flutter.nix
    ../../modules/home-manager/development/rust.nix
    ../../modules/home-manager/development/terminal-related.nix
    ../../modules/home-manager/virtualization/virt-manager-connections.nix
    ../../modules/home-manager/customization/gtk.nix
    ../../modules/home-manager/misc/utilities.nix
    ../../modules/home-manager/misc/social.nix
    ../../modules/home-manager/misc/paperwork.nix
    ../../modules/home-manager/misc/gaming.nix
    ../../modules/home-manager/misc/music.nix
  ];

  gitUser = {
    name = homeUserName;
    email = "const.trushov@gmail.com";
  };

  home = let
    homeUserNameLower = lib.toLower homeUserName; 
  in {
    username = homeUserNameLower;
    homeDirectory = "/home/${homeUserNameLower}";
    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
  };
}
