{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ipmicfg
  ];
}