{ pkgs, ... }:
let 
  minyewooUsername = "Minyewoo";
in
{
  imports = [
    ../../modules/home-manager/development/vscode.nix
    ../../modules/home-manager/development/git.nix
    ../../modules/home-manager/development/flutter.nix
    ../../modules/home-manager/development/rust.nix
    ../../modules/home-manager/development/terminal-related.nix
    ../../modules/home-manager/customization/gtk.nix
    ../../modules/home-manager/misc/utilities.nix
    ../../modules/home-manager/misc/social.nix
    ../../modules/home-manager/misc/paperwork.nix
    ../../modules/home-manager/misc/gaming.nix
    ../../modules/home-manager/misc/music.nix
  ];

  gitUserName = minyewooUsername;
  gitUserEmail = "const.trushov@gmail.com";

  home = let
    minyewooUsernameLower = lib.toLower minyewooUsername; 
  in {
    username = minyewooUsernameLower;
    homeDirectory = "/home/${minyewooUsernameLower}";
    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
  };
}
