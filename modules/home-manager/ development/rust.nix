{pkgs, ...}:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
  ];

  home.packages = with pkgs; [
    cargo
    rustc
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
  ];
}