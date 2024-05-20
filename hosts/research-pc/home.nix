{ config, pkgs, inputs, ... }:
{
  imports = [
    ../../modules/home-manager/development/vscode.nix
    ../../modules/home-manager/development/git.nix
  ];

  gitUserName = "Minyewoo";
  gitUserEmail = "const.trushov@gmail.com";

  nixpkgs.config.allowUnfree = true;

  home = rec {
    username = "minyewoo";
    homeDirectory = "/home/${username}";

    shellAliases = {
      code = "codium";
    };

    packages = (with pkgs; [
      libreoffice
      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU
      discord
      bottles
      parsec-bin
      fastfetch
      jre_minimal
      gnomeExtensions.dash-to-dock
      flutter
      cargo
      rustc
      telegram-desktop
      spotify
    ]);

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
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
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
  };
}
