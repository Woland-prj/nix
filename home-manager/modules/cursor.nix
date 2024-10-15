{pkgs, ...}: {
  home = {
    pointerCursor = {
      package = pkgs.rose-pine-cursor;
      name = "Rose-Pine-Cursor";
      size = 24;
      gtk.enable = true;
      x11 = {
        enable = true;
        defaultCursor = true;
      };
    };
  };
}
