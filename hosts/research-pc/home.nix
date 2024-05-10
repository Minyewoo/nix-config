{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = rec {
    username = "minyewoo";
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      bottles
      parsec-bin
      fastfetch
      jre8
      ocrmypdf
      gnomeExtensions.dash-to-dock
      flutter
      cargo
      rustc
      telegram-desktop
      spotify
    ];

    file = {

    };

    sessionVariables = {
      EDITOR = "codium";
    };

    sessionPath = [
      "${homeDirectory}/.cargo/bin"
    ];

    stateVersion = "23.11";
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout="close,minimize,maximize:appmenu";
    };
  };

  programs = {
    home-manager.enable = true;

    bash.enable = true;

    alacritty.enable = true;

    firefox.enable = true;

    git = {
      enable = true;
      userName  = "Minyewoo";
      userEmail = "const.trushov@gmail.com";
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        dart-code.flutter
        rust-lang.rust-analyzer
      ];
    };
  };
}
