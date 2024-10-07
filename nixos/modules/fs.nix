{
  fileSystems = {
    "/mnt/DATA" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "ntfs";
      options = [
        "users"
        "nofail"
      ];
    };
    "/mnt/BIG" = {
      device = "/dev/disk/by-label/BIG";
      fsType = "ntfs";
      options = [
        "users"
        "nofail"
      ];
    };
  };
}
