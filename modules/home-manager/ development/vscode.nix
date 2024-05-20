{pkgs, ...}:
{
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        dart-code.flutter
        dart-code.dart-code
        rust-lang.rust-analyzer
      ];
    };
}