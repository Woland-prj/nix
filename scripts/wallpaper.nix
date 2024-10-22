{
  pkgs,
  config,
  ...
}: let
  square = "/home/${config.home.username}/.wm/wallpapers/wal_square.png";
in
  pkgs.writeShellScriptBin "wallpaper" ''
    swww img ${config.stylix.image} \
            --transition-bezier .43,1.19,1,.4 \
            --transition-fps=60 \
            --transition-type=wipe \
            --transition-duration=0.7 \
            --transition-pos "$( hyprctl cursorpos )"
    magick ${config.stylix.image} -gravity Center -extent 1:1 ${square}
  ''
