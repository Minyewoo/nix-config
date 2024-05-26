{pkgs, config, lib, ...}:
let
  texCfg = config.tex;
  vscodeTexCfg = config.programs.vscode.tex;
in
{
  options = {
    tex.enable = lib.mkEnableOption "Tex support";
    programs.vscode.tex = {
      enable = lib.mkEnableOption "Vscode Tex support";
    };
  };

  config = {
    home = lib.mkIf texCfg.enable {
      packages = with pkgs; [
        texlive.combined.scheme-full
      ];
    };

    programs.vscode = lib.mkIf vscodeTexCfg.enable {
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop
        valentjn.vscode-ltex
      ];
    };
  };
}