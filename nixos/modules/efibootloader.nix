{
  #boot.loader.grub.enable = false;
  #boot.loader.grub.devices = " ";
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot";
  #boot.initrd.kernelModules = [ "amdgpu" ];
  #boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];
    };
  }; 
}
