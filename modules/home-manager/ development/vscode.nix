{pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  home.sessionVariables = {
    EDITOR = "codium";
  };

  home.shellAliases = {
    code = "codium";
  };
}