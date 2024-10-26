{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus Dark";
  };
}
