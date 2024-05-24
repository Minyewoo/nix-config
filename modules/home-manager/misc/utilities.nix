{pkgs, ...}:
{
  home.packages = with pkgs; [
    woeusb
    vlc
    qbittorrent
    fastfetch
  ];

  programs.firefox.enable = true;
}