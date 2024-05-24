{pkgs, ...}:
{
  home.packages = with pkgs; [
    discord
    parsec-bin
    bottles
  ];
}