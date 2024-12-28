{
  programs.rofi = {
    enable = true;
  };
  home.file = {
    ".config/rofi/conf.rasi".source = ./conf.rasi;
    ".config/rofi/config-main.rasi".source = ./config-main.rasi;
    ".config/rofi/config-wallpaper.rasi".source = ./config-wallpaper.rasi;
  };
}
