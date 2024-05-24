{pkgs, ...}:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    dart-code.flutter
    dart-code.dart-code
  ];

  home.packages = with pkgs; [
    flutter
  ];
}