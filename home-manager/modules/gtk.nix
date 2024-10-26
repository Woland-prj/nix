{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "magnetic-catppuccin-gtk";
      package = pkgs.magnetic-catppuccin-gtk;
    };
    # iconTheme.package = pkgs.papirus-icon-theme;
    # iconTheme.name = "Papirus Dark";
  };
}
