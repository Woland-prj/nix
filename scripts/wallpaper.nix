{
  pkgs,
  userSettings,
  ...
}: let
  themeFolder = "../themes/";
  backgroundUrl = builtins.readFile (./. + themeFolder + ("/" + userSettings.theme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + themeFolder + ("/" + userSettings.theme) + "/backgroundsha256.txt");
  sourceWall = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
in
  pkgs.writeShellScriptBin "wallpaper" ''
    cat ${sourceWall}
  ''
