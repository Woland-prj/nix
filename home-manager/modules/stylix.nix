{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}: let
  themeFolder = "../../../themes/";
  themePath = themeFolder + userSettings.theme + "/" + userSettings.theme + ".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + themeFolder + ("/" + userSettings.theme) + "/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + themeFolder + ("/" + userSettings.theme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + themeFolder + ("/" + userSettings.theme) + "/backgroundsha256.txt");
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  home.file.".currenttheme".text = userSettings.theme;
  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;
  stylix.fonts = {
    monospace = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    serif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    sansSerif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
    sizes = {
      terminal = 16;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  stylix.targets.alacritty.enable = false;
  programs.alacritty.settings = {
    colors = {
      # TODO revisit these color mappings
      # these are just the default provided from stylix
      # but declared directly due to alacritty v3.0 breakage
      primary.background = "#" + config.lib.stylix.colors.base00;
      primary.foreground = "#" + config.lib.stylix.colors.base07;
      cursor.text = "#" + config.lib.stylix.colors.base00;
      cursor.cursor = "#" + config.lib.stylix.colors.base07;
      normal.black = "#" + config.lib.stylix.colors.base00;
      normal.red = "#" + config.lib.stylix.colors.base08;
      normal.green = "#" + config.lib.stylix.colors.base0B;
      normal.yellow = "#" + config.lib.stylix.colors.base0A;
      normal.blue = "#" + config.lib.stylix.colors.base0D;
      normal.magenta = "#" + config.lib.stylix.colors.base0E;
      normal.cyan = "#" + config.lib.stylix.colors.base0B;
      normal.white = "#" + config.lib.stylix.colors.base05;
      bright.black = "#" + config.lib.stylix.colors.base03;
      bright.red = "#" + config.lib.stylix.colors.base09;
      bright.green = "#" + config.lib.stylix.colors.base01;
      bright.yellow = "#" + config.lib.stylix.colors.base02;
      bright.blue = "#" + config.lib.stylix.colors.base04;
      bright.magenta = "#" + config.lib.stylix.colors.base06;
      bright.cyan = "#" + config.lib.stylix.colors.base0F;
      bright.white = "#" + config.lib.stylix.colors.base07;
    };
    font.size = config.stylix.fonts.sizes.terminal;
    font.normal.family = userSettings.font;
  };

  home.file.".wm/colors-waybar.css".text = ''
    @define-color foreground #${config.lib.stylix.colors.base00};
    @define-color background #${config.lib.stylix.colors.base07};
    @define-color cursor #${config.lib.stylix.colors.base07};

    @define-color color0 #${config.lib.stylix.colors.base00};
    @define-color color1 #${config.lib.stylix.colors.base01};
    @define-color color2 #${config.lib.stylix.colors.base02};
    @define-color color3 #${config.lib.stylix.colors.base03};
    @define-color color4 #${config.lib.stylix.colors.base04};
    @define-color color5 #${config.lib.stylix.colors.base05};
    @define-color color6 #${config.lib.stylix.colors.base06};
    @define-color color7 #${config.lib.stylix.colors.base07};
    @define-color color8 #${config.lib.stylix.colors.base08};
    @define-color color9 #${config.lib.stylix.colors.base09};
    @define-color color10 #${config.lib.stylix.colors.base0A};
    @define-color color11 #${config.lib.stylix.colors.base0B};
    @define-color color12 #${config.lib.stylix.colors.base0C};
    @define-color color13 #${config.lib.stylix.colors.base0D};
    @define-color color14 #${config.lib.stylix.colors.base0E};
    @define-color color15 #${config.lib.stylix.colors.base0F};
  '';
  home.file.".wm/colors-hyprland.conf".text = ''
    $background = rgb(${config.lib.stylix.colors.base07})
    $foreground = rgb(${config.lib.stylix.colors.base00})
    $color0 = rgb(${config.lib.stylix.colors.base00})
    $color1 = rgb(${config.lib.stylix.colors.base01})
    $color2 = rgb(${config.lib.stylix.colors.base02})
    $color3 = rgb(${config.lib.stylix.colors.base03})
    $color4 = rgb(${config.lib.stylix.colors.base04})
    $color5 = rgb(${config.lib.stylix.colors.base05})
    $color6 = rgb(${config.lib.stylix.colors.base06})
    $color7 = rgb(${config.lib.stylix.colors.base07})
    $color8 = rgb(${config.lib.stylix.colors.base08})
    $color9 = rgb(${config.lib.stylix.colors.base09})
    $color10 = rgb(${config.lib.stylix.colors.base0A})
    $color11 = rgb(${config.lib.stylix.colors.base0B})
    $color12 = rgb(${config.lib.stylix.colors.base0C})
    $color13 = rgb(${config.lib.stylix.colors.base0D})
    $color14 = rgb(${config.lib.stylix.colors.base0E})
    $color15 = rgb(${config.lib.stylix.colors.base0F})
  '';
  home.file.".wm/colors-rofi.rasi".text = ''
    * {
        background: rgba(0,0,1,0.5);
        foreground: #FFFFFF;
        color0:     #${config.lib.stylix.colors.base00};
        color1:     #${config.lib.stylix.colors.base01};
        color2:     #${config.lib.stylix.colors.base02};
        color3:     #${config.lib.stylix.colors.base03};
        color4:     #${config.lib.stylix.colors.base04};
        color5:     #${config.lib.stylix.colors.base05};
        color6:     #${config.lib.stylix.colors.base06};
        color7:     #${config.lib.stylix.colors.base07};
        color8:     #${config.lib.stylix.colors.base08};
        color9:     #${config.lib.stylix.colors.base09};
        color10:     #${config.lib.stylix.colors.base0A};
        color11:     #${config.lib.stylix.colors.base0B};
        color12:     #${config.lib.stylix.colors.base0C};
        color13:     #${config.lib.stylix.colors.base0D};
        color14:     #${config.lib.stylix.colors.base0E};
        color15:     #${config.lib.stylix.colors.base0F};
    }
  '';
  home.file.".wm/image-rofi.rasi".text = ''
    * { current-image: url("/home/${config.home.username}/.wm/wallpapers/wal_square.png", height); }
  '';

  stylix.targets.rofi.enable = true;
  # stylix.targets.gtk.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [userSettings.font];
    sansSerif = [userSettings.font];
    serif = [userSettings.font];
  };
}
