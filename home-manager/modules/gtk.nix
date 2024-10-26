{pkgs, ...}: {
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus Dark";
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
