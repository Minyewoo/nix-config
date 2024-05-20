{
  boot.loader = {
    timeout = 5;
    efi = {
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
    };
  };
}