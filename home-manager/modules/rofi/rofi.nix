{
  programs.rofi = {
    enable = true;
  };
  home.file = {
    ".config/rofi/conf.rasi".source = ./rofi/conf.rasi;
    ".config/rofi/config-main.rasi".source = ./rofi/config-main.rasi;
    ".config/rofi/config-wallpaper.rasi".source = ./rofi/config-wallpaper.rasi;
  };
}
