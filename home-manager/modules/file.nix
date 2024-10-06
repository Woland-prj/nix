{config, ...}: {
  home.file = {
    # Copy pywal templates
    ".config/wal/templates/colors-hyprland.conf".source = ./pywal/templates/colors-hyprland.conf;
    ".config/wal/templates/colors-rofi-pywal.rasi".source = ./pywal/templates/colors-rofi-pywal.rasi;
    ".config/wal/templates/colors-waybar.css".source = ./pywal/templates/colors-waybar.css;
    ".config/wal/templates/colors-wlogout.css".source = ./pywal/templates/colors-wlogout.css;

    # Copy rofi configs
    ".config/rofi/conf.rasi".source = ./rofi/conf.rasi;
    ".config/rofi/config-main.rasi".source = ./rofi/config-main.rasi;
    ".config/rofi/config-wallpaper.rasi".source = ./rofi/config-wallpaper.rasi;

    # Copy wlogout config
    ".config/wlogout".source = ./wlogout/conf;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
