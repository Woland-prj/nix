{
  fileSystems = {
    "/mnt/DATA" = {
      device = "/dev/disk/by-label/DATA";
      fstype = "ntfs";
      options = [
        "users"
        "nofail"
      ];
    };
    "/mnt/BIG" = {
      device = "/dev/disk/by-label/BIG";
      fstype = "ntfs";
      options = [
        "users"
        "nofail"
      ];
    };
  };
}
