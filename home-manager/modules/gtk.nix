{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-GTK";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus Dark";
  };
}
