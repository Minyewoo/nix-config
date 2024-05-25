{lib, config, ...}:
with lib;
let
  cfg = config.virtualisation.virt-manager;
in
{
  imports = [
    ./libvirtd.nix
  ];
  options.virtualisation.virt-manager = {
    br0Interface = mkOption {
      type = types.str;
      example = "eth0";
      description = "Physical network interface to bridge to";
    };
  };
  config = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    networking = {
      interfaces.br0.useDHCP = true;
      bridges = {
        "br0" = {
          interfaces = [ cfg.br0Interface ];
        };
      };
    };
  };
}