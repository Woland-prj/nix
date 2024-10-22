{
  pkgs,
  config,
  ...
}: let
  scripts = {
    wttr = import ../scripts/wttr.nix {
      inherit pkgs;
    };
    wallpaper = import ../scripts/wallpaper.nix {
      inherit pkgs config;
    };
  };
in {
  home.packages = [
    scripts.wttr
    scripts.wallpaper
  ];
}
